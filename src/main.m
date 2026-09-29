% MAIN  Enhance one image with Layout-Aware Fast ACE.
%
% Before running:
%   1. Put your input image in the images/ folder and set inputPath below.
%   2. Choose the layout and growth strategy in builtLayoutGammadion.m.

inputPath  = fullfile('..', 'images', 'input.jpg');     % edit as needed
outputPath = fullfile('..', 'results', 'output.jpg');   % edit as needed

img = imread(inputPath);

% Default parameters
areaExponent = 0.5;
slope        = 5;
nRect        = 100;   % number of rectangles for Fast ACE

[Height, Width, ~] = size(img);

tic;
% Build layout
[X0, Y0, X1, Y1] = builtLayoutGammadion(Width, Height);
[X0, Y0, X1, Y1] = trimLayout(X0, Y0, X1, Y1, Width, Height);

% Error-bounded refinement to nRect rectangles
[X0b, Y0b, X1b, Y1b] = goemonLayoutNRect(X0, Y0, X1, Y1, nRect, areaExponent);

% Fast ACE enhancement
ACESATimg = ACESATCompute(img, slope, X0b, Y0b, X1b, Y1b);
ACESATimg = uint8(scalingLinear(ACESATimg));
computationTime = toc;

imwrite(ACESATimg, outputPath);
fprintf('Saved: %s\nComputation time: %.4f s\n', outputPath, computationTime);

% ---- Visualisation (optional) ----
figure;
subplot(1, 3, 1);
imshow(img);
title('Original Image');
text(10, Height + 20, sprintf('Resolution: %dx%d', Width, Height), 'FontSize', 12);

subplot(1, 3, 2);
drawLayout(X0, Y0, X1, Y1);
title('Layout');
axis image;
xlim([-Width, Width]);
ylim([-Height, Height]);

subplot(1, 3, 3);
imshow(ACESATimg);
title('Enhanced Image');
text(10, Height + 20, sprintf('Computation Time: %.4f s', computationTime), 'FontSize', 12);

set(gcf, 'Position', [100, 100, 1200, 400]);
