from __future__ import annotations

from dataclasses import dataclass
from typing import Tuple

import numpy as np

from black_sea_step4_pattern import BlackSeaPattern


@dataclass
class BlackSeaScoreParts:
    """Step 5: components of the snPfIe score decomposition.

    Mirrors PPfIe.m + norIe.m + snPfIe.m at a high level:
      - Pf: "signal" component of the gradient aligned with the pattern
      - f_Pf: "noise" residual after removing Pf, masked by pattern magnitude
      - score: nor(Pf) / nor(f_Pf)
    """

    Pf_x: np.ndarray
    Pf_y: np.ndarray
    f_Pf_x: np.ndarray
    f_Pf_y: np.ndarray
    score: float


def _sca(a_x: np.ndarray, a_y: np.ndarray, b_x: np.ndarray, b_y: np.ndarray) -> np.ndarray:
    """Equivalent to scaIe for 2-component fields."""
    return a_x * b_x + a_y * b_y


def _nor(a_x: np.ndarray, a_y: np.ndarray) -> float:
    """Equivalent to norIe: sqrt(sum(sca(a,a))) / n."""
    n = a_x.shape[1]
    a2 = _sca(a_x, a_y, a_x, a_y)
    s2 = float(np.sum(a2))
    return (np.sqrt(s2) / n) if n else 0.0


def score_against_pattern(
    pattern: BlackSeaPattern, g_x: np.ndarray, g_y: np.ndarray
) -> BlackSeaScoreParts:
    """Compute a snPfIe-like score between a pattern and a local gradient field.

    Directly mirrors PPfIe.m:
      af = sca(pattern, g)
      Pf = af * pattern
      f_Pf = (g - Pf) * |pattern|
      score = nor(Pf) / nor(f_Pf)

    Notes:
    - This expects g_x, g_y to be the same shape as pattern.ax/ay (n×n).
    - Center element is zeroed like MATLAB (no direction in the exact center).
    """
    a_x = pattern.ax
    a_y = pattern.ay

    if g_x.shape != a_x.shape or g_y.shape != a_y.shape:
        raise ValueError("pattern and local gradient must have the same shape")

    n = a_x.shape[1]
    n0 = (n // 2 + 1) if (n % 2 == 0) else ((n - 1) // 2 + 1)

    af = _sca(a_x, a_y, g_x, g_y)
    Pf_x = af * a_x
    Pf_y = af * a_y

    Pf_x[n0 - 1, n0 - 1] = 0.0
    Pf_y[n0 - 1, n0 - 1] = 0.0

    r_x = g_x - Pf_x
    r_y = g_y - Pf_y

    ar = np.sqrt(a_x * a_x + a_y * a_y)
    f_Pf_x = r_x * ar
    f_Pf_y = r_y * ar

    f_Pf_x[n0 - 1, n0 - 1] = 0.0
    f_Pf_y[n0 - 1, n0 - 1] = 0.0

    denom = _nor(f_Pf_x, f_Pf_y)
    score = (_nor(Pf_x, Pf_y) / denom) if denom != 0.0 else float("inf")

    return BlackSeaScoreParts(Pf_x=Pf_x, Pf_y=Pf_y, f_Pf_x=f_Pf_x, f_Pf_y=f_Pf_y, score=score)


if __name__ == "__main__":
    # Tiny sanity check: pattern vs itself should give high score.
    n = 29
    pat = BlackSeaPattern(ax=np.ones((n, n)), ay=np.zeros((n, n)))
    parts = score_against_pattern(pat, pat.ax, pat.ay)
    print("score:", parts.score)

