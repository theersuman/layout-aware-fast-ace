function [newX0, newY0, newX1, newY1] = addLayer(X0, Y0, X1, Y1, da, a) 
    newX0 = [X0, -da+1,  -a+1,  -a+1,  da];
    newY0 = [Y0,  da  , -da+1,  -a+1, -a+1];
    
    newX1 = [X1,  a,   -da+1,    da,   a];
    newY1 = [Y1,  a,       a,   -da+1, da];
end 