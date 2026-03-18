from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

import numpy as np

from black_sea_step1 import load_black_sea_inputs
from black_sea_step2 import _center_index  # reuse exact formula
from black_sea_step3 import _compute_global_gradients, _extract_window
from black_sea_step4_pattern import BlackSeaPattern, build_circular_pattern
from black_sea_step5_score import score_against_pattern


@dataclass
class BlackSeaScanResult:
    """Step 6: scan the pattern score over an m×m grid to form maD, then embed it."""

    maD: np.ndarray   # shape (m, m)
    B: np.ndarray     # shape (L, L) embedded map (like MATLAB inPCT result)
    I0: int           # scan center row (MATLAB 1-based)
    J0: int           # scan center col (MATLAB 1-based)
    m: int            # scan window size


def _embed_in_place(B: np.ndarray, I0: int, J0: int, maD: np.ndarray) -> np.ndarray:
    """Equivalent to inPCT.m (no bounds protection, assumes it fits)."""
    m = maD.shape[0]
    if m % 2 == 0:
        m0 = m // 2 + 1
    else:
        m0 = (m - 1) // 2 + 1

    out = B.copy()
    for i in range(m):
        i0 = (i + 1) - m0
        for j in range(m):
            j0 = (j + 1) - m0
            out[(I0 + i0) - 1, (J0 + j0) - 1] = maD[i, j]
    return out


def run_scan(base_dir: Path, m: int = 37, pr: float = 0.15, wd: float = 0.90, pnd: float = 0.0) -> BlackSeaScanResult:
    """Step 6: produce maD and embedded map B (Python analogue of m_BlaSea lines 63–82).

    Differences vs MATLAB:
    - MATLAB uses a specific gradient field G from cgraFIe; we use numpy gradients.
    - Score uses the same PPfIe/norIe ratio logic, translated to numpy.
    """
    inputs = load_black_sea_inputs(base_dir)
    A = inputs.A

    n = int(inputs.a.shape[1])
    L = int(A.shape[1])

    # Pattern diP (ind==0, circle)
    pattern = build_circular_pattern(n=n, pr=pr, wd=wd, pnd=pnd)

    # Global gradients of A
    Gx, Gy, _ = _compute_global_gradients(A)

    # Scan around the center of A (Lo, Lo)
    Lo = _center_index(L)
    I0 = Lo
    J0 = Lo

    if m % 2 == 0:
        m0 = m // 2 + 1
    else:
        m0 = (m - 1) // 2 + 1

    maD = np.ones((m, m), dtype=float)

    for i in range(m):
        i0 = (i + 1) - m0
        for j in range(m):
            j0 = (j + 1) - m0

            gGx = _extract_window(Gx, I0 + i0, J0 + j0, n)
            gGy = _extract_window(Gy, I0 + i0, J0 + j0, n)

            parts = score_against_pattern(pattern, gGx, gGy)
            maD[i, j] = parts.score

    # Embed maD into an L×L canvas initialized to min(maD), like MATLAB
    mD = float(np.min(maD))
    canvas = np.ones((L, L), dtype=float) * mD
    B = _embed_in_place(canvas, I0, J0, maD)

    return BlackSeaScanResult(maD=maD, B=B, I0=I0, J0=J0, m=m)


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    res = run_scan(root)
    print("maD shape:", res.maD.shape)
    print("B shape:", res.B.shape)
    print("maD min/max:", float(np.min(res.maD)), float(np.max(res.maD)))

