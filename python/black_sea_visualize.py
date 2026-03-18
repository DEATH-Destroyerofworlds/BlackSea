from __future__ import annotations

from pathlib import Path

import matplotlib.pyplot as plt

from black_sea_step3 import compute_gradients
from black_sea_step4_pattern import build_circular_pattern
from black_sea_step6_scan import run_scan


def main() -> None:
    base_dir = Path(__file__).resolve().parent.parent

    grads = compute_gradients(base_dir)
    scan = run_scan(base_dir)

    n = grads.g_mag.shape[0]
    pat = build_circular_pattern(n=n, pr=0.15, wd=0.90, pnd=0.0)

    fig, axes = plt.subplots(2, 3, figsize=(12, 8))

    ax = axes[0, 0]
    im = ax.imshow(grads.G_mag, cmap="gray")
    ax.set_title("|Grad(A)| (global)")
    fig.colorbar(im, ax=ax, fraction=0.046)

    ax = axes[0, 1]
    im = ax.imshow(grads.g_mag, cmap="gray")
    ax.set_title("|grad| (local window)")
    fig.colorbar(im, ax=ax, fraction=0.046)

    ax = axes[0, 2]
    ax.quiver(pat.ax, -pat.ay, pivot="mid", scale=30)
    ax.set_title("Pattern diP (quiver)")
    ax.set_aspect("equal")

    ax = axes[1, 0]
    im = ax.imshow(scan.maD, cmap="viridis")
    ax.set_title("maD score map (scan)")
    fig.colorbar(im, ax=ax, fraction=0.046)

    ax = axes[1, 1]
    im = ax.imshow(scan.B, cmap="viridis")
    ax.set_title("Embedded B (L×L)")
    fig.colorbar(im, ax=ax, fraction=0.046)

    axes[1, 2].axis("off")

    fig.tight_layout()
    plt.show()


if __name__ == "__main__":
    main()

