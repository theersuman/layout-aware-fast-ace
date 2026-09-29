function [newX0, newY0, newX1, newY1] = layoutH(X0, Y0, X1, Y1, b, a) 
    newX0 = [X0, b,   1-b,   1-a, 1-b]; 
    newY0 = [Y0, 1-a, 1-a,   1-a, b ]; 
    newX1 = [X1, a,   b,     1-b, b ];
    newY1 = [Y1, a,   1-b,   a,   a ];
end 