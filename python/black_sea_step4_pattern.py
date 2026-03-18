from __future__ import annotations

from dataclasses import dataclass
from typing import Tuple

import numpy as np


@dataclass
class BlackSeaPattern:
    """Step 4: build the idealized vortex/polar direction pattern (diP).

    This is a direct Python translation of the ind==0 branch of CPOLYe.m (Circle).
    Output is a 2-component vector field (ax, ay) on an n×n grid.
    """

    ax: np.ndarray  # x-component of direction field, shape (n, n)
    ay: np.ndarray  # y-component of direction field, shape (n, n)


def _center_index(n: int) -> int:
    if n % 2 == 0:
        return n // 2 + 1
    return (n - 1) // 2 + 1


def build_circular_pattern(n: int, pr: float, wd: float, pnd: float) -> BlackSeaPattern:
    """Build CPOLYe(ind=0, ...) circular pattern.

    Parameters mirror CPOLYe.m:
    - n: grid size
    - pr: inner radius fraction (0..1)
    - wd: band width fraction (0..1) where vectors are non-zero (pr..pr+wd)
    - pnd: "perpendicular" phase shift factor: pp = pnd * (pi/2)
    """
    no = _center_index(n)
    ax = np.zeros((n, n), dtype=float)
    ay = np.zeros((n, n), dtype=float)

    pp = pnd * (np.pi / 2.0)
    pw = pr + wd

    for i in range(n):
        y = (i + 1) - no  # MATLAB-style coordinates
        for j in range(n):
            x = (j + 1) - no
            a = np.arctan2(y, x) + pp
            r = np.sqrt(x * x + y * y)
            ro = r / no

            if ro > pr and ro < pw:
                ax[i, j] = np.cos(a)
                ay[i, j] = np.sin(a)

    ax[no - 1, no - 1] = 0.0
    ay[no - 1, no - 1] = 0.0
    return BlackSeaPattern(ax=ax, ay=ay)


if __name__ == "__main__":
    # Default-ish params from m_BlaSea.m around line 35:
    n = 29
    pr = 0.15
    wd = 0.90
    pnd = 0.0
    pat = build_circular_pattern(n, pr, wd, pnd)
    print("pattern shapes:", pat.ax.shape, pat.ay.shape)

