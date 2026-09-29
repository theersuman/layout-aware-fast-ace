function [newX0, newY0, newX1, newY1] = clockwiseGammmadion(X0, Y0, X1, Y1, b, a) 
    newX0 = [X0, -b+1,  -a+1,  -a+1,  b];
    newY0 = [Y0,  b  , -b+1,  -a+1, -a+1];
    
    newX1 = [X1,  a,   -b+1,    b,   a];
    newY1 = [Y1,  a,       a,   -b+1, b];
end 