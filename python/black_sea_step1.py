from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Tuple

import numpy as np
from PIL import Image


@dataclass
class BlackSeaInputs:
    """Step 1: raw inputs for the Black Sea experiment.

    This mirrors lines 13–21 of m_BlaSea.m:
      - load BlSa0.bmp and BlSa1.bmp
      - extract a and A as single-channel images (blue channel here)
    """

    a: np.ndarray  # from BlSa0.bmp, single channel
    A: np.ndarray  # from BlSa1.bmp, single channel
    a_rgb: np.ndarray  # full RGB from BlSa0.bmp
    A_rgb: np.ndarray  # full RGB from BlSa1.bmp


def _load_rgb_image(path: Path) -> np.ndarray:
    """Load an image file as an RGB numpy array with shape (H, W, 3)."""
    img = Image.open(path).convert("RGB")
    return np.array(img)


def load_black_sea_inputs(base_dir: Path) -> BlackSeaInputs:
    """Step 1: load Black Sea images and extract a, A.

    - Reads BlSa0.bmp and BlSa1.bmp from the given base directory.
    - Converts them to RGB arrays.
    - Takes the blue channel ([:, :, 2]) as a and A, matching
      'a=b' and 'A=B' in m_BlaSea.m.
    """
    im0_path = base_dir / "BlSa0.bmp"
    im1_path = base_dir / "BlSa1.bmp"

    a_rgb = _load_rgb_image(im0_path)
    A_rgb = _load_rgb_image(im1_path)

    # MATLAB code:
    #   [r,g,b] = RGBf(Pc); a = b;
    #   [R,G,B] = RGBf(Pc); A = B;
    a = a_rgb[:, :, 2]
    A = A_rgb[:, :, 2]

    return BlackSeaInputs(a=a, A=A, a_rgb=a_rgb, A_rgb=A_rgb)


def demo_shapes(base_dir: Path) -> Tuple[Tuple[int, int], Tuple[int, int]]:
    """Small helper for exploration: return shapes of a and A."""
    inputs = load_black_sea_inputs(base_dir)
    return inputs.a.shape, inputs.A.shape


if __name__ == "__main__":
    # Simple manual test:
    root = Path(__file__).resolve().parent.parent
    a_shape, A_shape = demo_shapes(root)
    print("a shape:", a_shape)
    print("A shape:", A_shape)

