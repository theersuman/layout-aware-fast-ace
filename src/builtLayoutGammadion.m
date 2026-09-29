function [X0, Y0, X1, Y1] = builtLayoutGammadion(W, H)
% BUILTLAYOUTGAMMADION  Build the rectangular region layout for Fast ACE.
%
%   The layout is built by repeatedly adding rings of rectangles around the
%   centre pixel until the whole image (L = max(W, H)) is covered.
%
%   TO SELECT A CONFIGURATION, edit the two marked lines below:
%     (1) Growth strategy : the line  a = ...
%     (2) Layout          : the function called inside the loop
%   See README.md for the full list of options.

    X0 = [];
    Y0 = [];
    X1 = [];
    Y1 = [];
    b = 1;
    L = max(W, H);   % the larger image dimension
    i = 0;

    % A while loop is used because linear (1,2,3,4,...) and exponential
    % (1,2,4,8,...) growth need different numbers of iterations to cover
    % the whole image.
    while b < L
        a = b + i;      % (1) GROWTH:  a = b + i   -> linear
                        %              a = b + 2^i -> exponential
        [X0, Y0, X1, Y1] = counterClockwiseGammmadion(X0, Y0, X1, Y1, b, a);   % (2) LAYOUT
        b = a;
        i = i + 1;
    end
end
