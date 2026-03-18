from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

from black_sea_step1 import BlackSeaInputs, load_black_sea_inputs


@dataclass
class BlackSeaGeometry:
    """Step 2: basic sizes and central indices for the Black Sea experiment.

    Mirrors lines 23–24 and 28–29, 52 of m_BlaSea.m:
      n  = size(a, 2)
      L  = size(A, 2)
      Lo = center index for A (size L)
      n0 = center index for window size n
      I0, J0 = chosen analysis center in A
    """

    n: int       # window size (from a)
    L: int       # full image width (from A)
    Lo: int      # center index for A (size L)
    n0: int      # center index for window size n
    I0: int      # analysis center row in A
    J0: int      # analysis center column in A


def _center_index(size: int) -> int:
    """MATLAB-style 'center' index: L/2+1 for even, (L-1)/2+1 for odd."""
    if size % 2 == 0:
        return size // 2 + 1
    return (size - 1) // 2 + 1


def compute_geometry(base_dir: Path) -> BlackSeaGeometry:
    """Step 2: compute core geometry parameters (n, L, Lo, n0, I0, J0).

    - Loads a and A via step 1.
    - Follows the same formulas as in m_BlaSea.m:
        n  = size(a, 2)
        L  = size(A, 2)
        Lo = center_index(L)
        n0 = center_index(n)
        I0 = 19 + n0
        J0 = 11 + n0
    - Returns a small data object you can pass to later steps.
    """
    inputs: BlackSeaInputs = load_black_sea_inputs(base_dir)

    n = int(inputs.a.shape[1])
    L = int(inputs.A.shape[1])

    Lo = _center_index(L)
    n0 = _center_index(n)

    # Same offsets as in MATLAB:
    #   I0 = 19 + n0; J0 = 11 + n0;
    I0 = 19 + n0
    J0 = 11 + n0

    return BlackSeaGeometry(n=n, L=L, Lo=Lo, n0=n0, I0=I0, J0=J0)


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    geom = compute_geometry(root)
    print(geom)

