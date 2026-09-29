# Layout-Aware Fast ACE

MATLAB implementation of the layout configurations evaluated in:

> S. P. Panday and S. Shrestha, "Layout-Aware Fast Automatic Color Equalization:
> A Benchmark of Geometric Region Configurations for Quality–Efficiency
> Trade-offs," under review.

The code extends Fast ACE (FACE) by A. Plutino and M. Tarini
(*IEEE Transactions on Image Processing*, vol. 32, pp. 2786–2798, 2023)
with five layout configurations (Cross, H, I, Clockwise, Anticlockwise),
each combined with two region growth strategies (linear and exponential),
giving ten configurations in total.

## Repository structure

```
layout-aware-fast-ace/
├── src/        MATLAB source code
├── images/     place input images here
└── results/    enhanced images are saved here
```

## Files

**Main script and layout builder**

| File | Description |
|------|-------------|
| `main.m` | Runs Fast ACE on one image, saves the result, and reports computation time |
| `builtLayoutGammadion.m` | Builds the region layout. **Select the layout and growth strategy here** |

**Layout functions (proposed in this work)**

| File | Layout |
|------|--------|
| `crossLayout.m` | Cross |
| `layoutH.m` | H |
| `layoutI.m` | I |
| `clockwiseGammmadion.m` | Clockwise spiral |
| `counterClockwiseGammmadion.m` | Anticlockwise spiral |

**Fast ACE core and helpers (from / adapted from the original FACE implementation)**

| File | Description |
|------|-------------|
| `ACESATCompute.m` | Fast ACE computation using Summed Area Tables |
| `goemonLayoutNRect.m` | Error-bounded refinement of the layout to N rectangles |
| `bestSplitRectSimple.m` | Splits a rectangle to reduce approximation error |
| `rectangleError.m` | Approximation error of a rectangle |
| `computeAvgDist.m` | Average distance of a rectangle from the centre pixel |
| `trimLayout.m` | Removes regions outside the image and degenerate regions |
| `scalingLinear.m` | Linear scaling of the output to [0, 255] |
| `clamp.m` | Clamps values to a range |
| `addLayer.m` | Layer function of the original FACE layout (baseline) |
| `drawLayout.m` | Draws the layout (visualisation only) |

**Reference**

| File | Description |
|------|-------------|
| `ACE_ForzaBruta.m` | Original (brute-force) ACE, used to generate the ACE reference images. Runtime grows as O(N²), so it is slow for large images |

## Requirements

MATLAB R2024a (Image Processing Toolbox)

## Selecting a layout and growth strategy

All ten configurations are selected by editing two lines in the loop
inside `src/builtLayoutGammadion.m`:

```matlab
while b < L
    a = b + i;      % (1) GROWTH
    [X0, Y0, X1, Y1] = counterClockwiseGammmadion(X0, Y0, X1, Y1, b, a);   % (2) LAYOUT
    b = a;
    i = i + 1;
end
```

**(1) Growth strategy: edit the line `a = ...`**

| Strategy    | Formula         | Region increments |
|-------------|-----------------|-------------------|
| Linear      | `a = b + i;`    | 1, 2, 3, 4, ...   |
| Exponential | `a = b + 2^i;`  | 1, 2, 4, 8, ...   |

`i` starts at 0. For linear growth, the first iteration (`i = 0`) creates an
empty ring that `trimLayout` removes, so the effective increments are
1, 2, 3, 4, ...

**(2) Layout: edit the function called inside the loop**

| Layout        | Function                      |
|---------------|-------------------------------|
| Cross         | `crossLayout`                 |
| H             | `layoutH`                     |
| I             | `layoutI`                     |
| Clockwise     | `clockwiseGammmadion`         |
| Anticlockwise | `counterClockwiseGammmadion`  |

**Example:** for the Cross layout with exponential growth, set
`a = b + 2^i;` and replace `counterClockwiseGammmadion` with `crossLayout`.

The default setting is **Anticlockwise, linear growth**.

## Usage

1. Place an input image in `images/` (for example `images/input.jpg`).
2. In MATLAB, set the current folder to `src/`.
3. Open `main.m` and set `inputPath` if your file name is different.
4. Select the layout and growth strategy in `builtLayoutGammadion.m`.
5. Run `main.m`. The enhanced image is saved to `results/output.jpg`, and
   the computation time is printed.

Default parameters (in `main.m`): `slope = 5`, `nRect = 100`,
`areaExponent = 0.5`.

## Test images

The 20 benchmark images are from D. Mould and P. L. Rosin, "A benchmark
image set for evaluating stylization," NPAR 2016. They are not
redistributed here.

## Scope

This release contains the enhancement implementation. The evaluation
scripts (RMSE, PSNR, SSIM, ΔE, Chi-Square) are not included.

## Acknowledgements

The Fast ACE core (`ACESATCompute.m` and the helper functions listed above)
is based on the FACE implementation by A. Plutino and M. Tarini. Please
also cite their work if you use this code.

## Citation

Citation details will be added upon publication.

## License

The new code in this repository (the layout functions and layout builder)
is released under the MIT License (see `LICENSE`). Files based on the
original FACE implementation remain subject to the terms of their
original authors.
