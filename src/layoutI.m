function [newX0, newY0, newX1, newY1] = layoutI(X0, Y0, X1, Y1, b, a) 
    newX0 = [X0, 1-a, b,   1-a, 1-a]; 
    newY0 = [Y0, b,   1-b, 1-a, 1-b ]; 
    newX1 = [X1, a,   a,   a,   1-b ];
    newY1 = [Y1, a,   b,   1-b,  b ];
end
