from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Tuple

import numpy as np

from black_sea_step1 import BlackSeaInputs, load_black_sea_inputs
from black_sea_step2 import BlackSeaGeometry, compute_geometry


@dataclass
class BlackSeaGradients:
    """Step 3: gradient-like fields for the Black Sea experiment.

    This is a Python/numpy analogue of lines 45–55 of m_BlaSea.m:
      - build a global gradient field G over A
      - compute its magnitude (abs(Grad))
      - cut out a local window g around (I0, J0) of size n
      - compute the magnitude of that local gradient (abs(grad))
    """

    Gx: np.ndarray          # gradient in x (columns)
    Gy: np.ndarray          # gradient in y (rows)
    G_mag: np.ndarray       # |Grad(A)| over the whole image
    gGx: np.ndarray         # local window of Gx around (I0, J0)
    gGy: np.ndarray         # local window of Gy around (I0, J0)
    g_mag: np.ndarray       # |grad| in the local window


def _compute_global_gradients(A: np.ndarray) -> Tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Compute a simple 2D gradient field and its magnitude using numpy.

    - Uses np.gradient as a stand-in for the more elaborate cgraFIe / grad2
      pipeline in MATLAB (which operates via custom Fourier/basis transforms).
    - Returns (Gx, Gy, G_mag).
    """
    # np.gradient returns derivatives along rows (axis=0) and columns (axis=1)
    Gy, Gx = np.gradient(A.astype(float))
    G_mag = np.hypot(Gx, Gy)
    return Gx, Gy, G_mag


def _extract_window(field: np.ndarray, I0: int, J0: int, n: int) -> np.ndarray:
    """Approximate ouPCT behavior: extract an n×n window with reflected borders.

    - Matches the spirit of ouPCT.m, which mirrors indices when they fall
      outside the image domain.
    """
    M, N = field.shape
    if n % 2 == 0:
        n0 = n // 2 + 1
    else:
        n0 = (n - 1) // 2 + 1

    window = np.zeros((n, n), dtype=field.dtype)

    for i in range(n):
        i0 = i - n0
        Ii = I0 + i0
        if Ii < 1:
            Ii = -Ii + 1
        if Ii > M:
            Ii = 2 * M + 1 - Ii

        for j in range(n):
            j0 = j - n0
            Jj = J0 + j0
            if Jj < 1:
                Jj = -Jj + 1
            if Jj > N:
                Jj = 2 * N + 1 - Jj

            # MATLAB is 1-based; convert to 0-based indices for numpy
            window[i, j] = field[Ii - 1, Jj - 1]

    return window


def compute_gradients(base_dir: Path) -> BlackSeaGradients:
    """Step 3: build global and local gradient fields for the Black Sea image A.

    - Loads a, A (step 1) and geometry (step 2).
    - Computes a global gradient field of A via numpy (Gx, Gy, |Grad|).
    - Extracts a local n×n window of that gradient field around (I0, J0),
      mimicking ouPCTe + absV2e in a simpler numpy form.
    """
    inputs: BlackSeaInputs = load_black_sea_inputs(base_dir)
    geom: BlackSeaGeometry = compute_geometry(base_dir)

    A = inputs.A

    Gx, Gy, G_mag = _compute_global_gradients(A)

    gGx = _extract_window(Gx, geom.I0, geom.J0, geom.n)
    gGy = _extract_window(Gy, geom.I0, geom.J0, geom.n)
    g_mag = np.hypot(gGx, gGy)

    return BlackSeaGradients(
        Gx=Gx,
        Gy=Gy,
        G_mag=G_mag,
        gGx=gGx,
        gGy=gGy,
        g_mag=g_mag,
    )


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    grads = compute_gradients(root)
    print("Global gradient shape:", grads.G_mag.shape)
    print("Local window shape:", grads.g_mag.shape)

