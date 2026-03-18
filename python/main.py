import os
from pathlib import Path

import tkinter as tk
from tkinter import ttk, messagebox

import numpy as np

try:
    from PIL import Image
except ImportError:
    Image = None

try:
    from matplotlib.figure import Figure
    from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
except ImportError:
    Figure = None
    FigureCanvasTkAgg = None

from black_sea_step3 import compute_gradients
from black_sea_step6_scan import run_scan


APP_TITLE = "Black sea vortex in Image"
IMAGE_EXTENSIONS = {".bmp", ".png", ".jpg", ".jpeg", ".gif"}


def find_image_files(base_dir: Path) -> list[Path]:
    images: list[Path] = []
    for entry in sorted(base_dir.iterdir()):
        if entry.is_file() and entry.suffix.lower() in IMAGE_EXTENSIONS:
            images.append(entry)
    return images


class ImageViewer(tk.Tk):
    def __init__(self, base_dir: Path) -> None:
        super().__init__()
        self.title(APP_TITLE)
        self.configure(bg="#e5e5e5")

        self.base_dir = base_dir
        self.images = find_image_files(base_dir)

        self._build_ui()
        self._populate_list()

    def _build_ui(self) -> None:
        main = ttk.Frame(self, padding=10)
        main.grid(row=0, column=0, sticky="nsew")

        self.rowconfigure(0, weight=1)
        self.columnconfigure(0, weight=1)

        # Left: list of image files + buttons
        left = ttk.Frame(main)
        left.grid(row=0, column=0, sticky="nsw")

        ttk.Label(left, text="Images:").grid(row=0, column=0, sticky="w")

        self.listbox = tk.Listbox(left, height=20, width=30, exportselection=False)
        self.listbox.grid(row=1, column=0, sticky="nsew", pady=(4, 4))

        scrollbar = ttk.Scrollbar(left, orient="vertical", command=self.listbox.yview)
        scrollbar.grid(row=1, column=1, sticky="ns")
        self.listbox.configure(yscrollcommand=scrollbar.set)

        show_btn = ttk.Button(left, text="Show selected", command=self.show_selected)
        show_btn.grid(row=2, column=0, columnspan=2, pady=(6, 0), sticky="ew")

        analysis_btn = ttk.Button(left, text="Run Black Sea analysis", command=self.run_black_sea_analysis)
        analysis_btn.grid(row=3, column=0, columnspan=2, pady=(6, 0), sticky="ew")

        left.rowconfigure(1, weight=1)
        left.columnconfigure(0, weight=1)

        # Right: image display with axes (matplotlib)
        right = ttk.Frame(main)
        right.grid(row=0, column=1, padx=(16, 0), sticky="nsew")

        main.columnconfigure(0, weight=0)
        main.columnconfigure(1, weight=1)
        main.rowconfigure(0, weight=1)

        if Figure is None or FigureCanvasTkAgg is None:
            # Fallback simple canvas if matplotlib is not available
            self.ax = None
            self.canvas = tk.Canvas(right, width=600, height=600, bg="white", highlightthickness=1)
            self.canvas.grid(row=0, column=0, sticky="nsew")
        else:
            self.figure = Figure(figsize=(6, 6), dpi=100)
            self.ax = self.figure.add_subplot(111)
            self.ax.set_title("")
            self.ax.set_axis_on()

            self.canvas = FigureCanvasTkAgg(self.figure, master=right)
            canvas_widget = self.canvas.get_tk_widget()
            canvas_widget.grid(row=0, column=0, sticky="nsew")
            self.canvas.draw()

        right.rowconfigure(0, weight=1)
        right.columnconfigure(0, weight=1)

    def _populate_list(self) -> None:
        self.listbox.delete(0, tk.END)
        for img_path in self.images:
            self.listbox.insert(tk.END, img_path.name)

        if self.images:
            self.listbox.selection_set(0)

    def show_selected(self) -> None:
        if not self.images:
            messagebox.showinfo("No images", "No image files were found in this folder.")
            return

        if Image is None:
            messagebox.showerror(
                "Pillow not installed",
                "Pillow (PIL) is required to display images.\n\n"
                "Install it with:\n    pip install Pillow",
            )
            return

        if self.ax is None and FigureCanvasTkAgg is not None:
            messagebox.showerror(
                "matplotlib not installed",
                "matplotlib is required to show axes.\n\n"
                "Install it with:\n    pip install matplotlib",
            )
            return

        selection = self.listbox.curselection()
        if not selection:
            messagebox.showinfo("Nothing selected", "Please select an image from the list.")
            return

        idx = selection[0]
        img_path = self.images[idx]

        try:
            img = Image.open(img_path)
        except Exception as exc:
            messagebox.showerror("Error", f"Failed to open image:\n{img_path}\n\n{exc}")
            return

        if self.ax is None:
            # Fallback: just draw raw image on Tk canvas without axes
            from PIL import ImageTk as _ImageTk  # type: ignore

            canvas_width = self.canvas.winfo_width() or self.canvas["width"]
            canvas_height = self.canvas.winfo_height() or self.canvas["height"]
            try:
                canvas_width = int(canvas_width)
                canvas_height = int(canvas_height)
            except ValueError:
                canvas_width = 600
                canvas_height = 600

            img.thumbnail((canvas_width, canvas_height))
            self._current_photo = _ImageTk.PhotoImage(img)

            self.canvas.delete("all")
            x = canvas_width // 2
            y = canvas_height // 2
            self.canvas.create_image(x, y, image=self._current_photo)
            return

        # Show image with axes using matplotlib
        arr = np.array(img)
        self.ax.clear()
        self.ax.imshow(arr)

        h, w = arr.shape[0], arr.shape[1]
        self.ax.set_xticks([0, w - 1])
        self.ax.set_yticks([0, h - 1])
        self.ax.set_xlim(0, w - 1)
        self.ax.set_ylim(h - 1, 0)
        self.ax.tick_params(direction="out")

        self.canvas.draw()

    def run_black_sea_analysis(self) -> None:
        if self.ax is None or FigureCanvasTkAgg is None:
            messagebox.showerror(
                "matplotlib not available",
                "Black Sea analysis needs matplotlib axes to plot into.\n\n"
                "Install it with:\n    pip install matplotlib",
            )
            return

        try:
            grads = compute_gradients(self.base_dir)
            scan = run_scan(self.base_dir)
        except Exception as exc:
            messagebox.showerror("Analysis error", f"Failed to run Black Sea analysis:\n\n{exc}")
            return

        # Show the embedded B map from the scan as an image.
        arr = scan.B
        self.ax.clear()
        im = self.ax.imshow(arr, cmap="viridis")

        h, w = arr.shape[0], arr.shape[1]
        self.ax.set_xticks([0, w - 1])
        self.ax.set_yticks([0, h - 1])
        self.ax.set_xlim(0, w - 1)
        self.ax.set_ylim(h - 1, 0)
        self.ax.tick_params(direction="out")
        self.ax.set_title("Black Sea score map (embedded B)")

        # Ensure colorbar is updated cleanly by recreating the figure canvas.
        self.canvas.draw()


def main() -> None:
    base_dir = Path(__file__).resolve().parent.parent
    app = ImageViewer(base_dir)
    app.mainloop()


if __name__ == "__main__":
    main()

