# MATLAB Wiki

Welcome to **MATLAB Wiki** – a collection of MATLAB scripts, functions, and examples designed to help you learn MATLAB and speed up your everyday development.

Whether you are a beginner looking to understand the basics or an experienced user who needs reusable snippets for rapid prototyping, this repository provides practical, well‑documented examples that you can directly use or adapt.

## Purpose

- **Learn MATLAB** – Each example focuses on a specific concept (data visualisation, matrix operations, file I/O, etc.) with clear comments.
- **Fast development** – Reusable utilities and templates to avoid reinventing the wheel. Copy, paste, and modify to fit your projects.
- **Best practices** – Demonstrates clean coding, vectorisation, and efficient MATLAB workflows.

## Repository Structure

```
Matlab_utility/
├── Basics/               # Fundamental scripts (loops, conditionals, functions)
├── Plotting/             # Examples of 2D/3D plots, customisation, subplots
├── Data_io/              # Reading/writing CSV, Excel, text files, MAT files
├── Utilities/            # Handy functions (timer, progress bar, string tools)
├── Fast_dev/             # Templates for common tasks (curve fitting, image processing, etc.)
├── Demos/                # Small demo projects combining multiple utilities
└── README.md
```

## Getting Started

### Prerequisites

- MATLAB R2019b or later (older versions may work but are not actively tested)
- No additional toolboxes are required for most examples, but some scripts might suggest the Curve Fitting, Image Processing, or Statistics Toolbox. Such dependencies are noted in the file headers.

### Clone the Repository

```bash
git clone https://github.com/GitMasterNikanjam/Matlab_Wiki.git
```

Then add the folder and its subfolders to your MATLAB path:

```matlab
addpath(genpath('path/to/Matlab_Wiki'))
```

Or open MATLAB and navigate directly to the cloned folder.

## Examples for Fast Development

Below are a few highlights from the repository:

| Example | Location | Description |
|---------|----------|-------------|
| **Quick plot with one line** | `plotting/quick_plot.m` | Automatic axis labels, legend, and title from variable names. |
| **Read any CSV file** | `data_io/read_any_csv.m` | Handles mixed data types and missing values. |
| **Progress bar for loops** | `utilities/progress_bar.m` | Display a simple text‑based progress bar in the command window. |
| **Fit & evaluate a polynomial** | `fast_dev/curve_fit_template.m` | Least‑squares fitting with residuals and plot. |
| **Batch process images** | `fast_dev/batch_image_resize.m` | Resize all JPEGs in a folder – perfect for dataset preparation. |

To run any example, simply open the script in MATLAB and press `F5`. Most scripts produce a figure or print output to the command window.

## Learning Path Suggestions

1. **Start with `basics/`** – Understand matrix operations, cell arrays, and writing functions.
2. **Move to `plotting/`** – Learn to create publication‑ready figures.
3. **Experiment with `data_io/`** – Load real data from external files.
4. **Explore `fast_dev/`** – See how to assemble small utilities into larger tasks.
5. **Build your own project** using the templates provided.

## Contributing

Contributions are welcome! If you have a useful utility or a well‑commented example that helps others learn MATLAB:

1. Fork the repository.
2. Create a new branch for your feature/example.
3. Follow the existing style (clear comments, self‑contained scripts).
4. Submit a pull request.

Please ensure your code runs without errors on a clean MATLAB installation (or list required toolboxes at the top of the file).

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details. Feel free to use the code in your own projects, academic work, or commercial applications.

---

**Happy coding with MATLAB!**  
If you find this repository useful, consider giving it a ⭐ on GitHub.
```