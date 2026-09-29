function [X0, Y0, X1, Y1] = trimLayout(X0in, Y0in, X1in, Y1in, W, H)
    X0=[];
    Y0=[];
    X1=[];
    Y1=[];
    for i = 1:length(X0in)
        x0 = max(X0in(i), -W+1);
        y0 = max(Y0in(i), -H+1);
        x1 = min(X1in(i), +W);
        y1 = min(Y1in(i), +H);
        
        if and(x0 < x1, y0 < y1)
            X0=[X0, x0];
            Y0=[Y0, y0];
            X1=[X1, x1];
            Y1=[Y1, y1];
        end

        
    end

end