function [X0out, Y0out, X1out, Y1out, errorBounds] = goemonLayoutNRect(X0, Y0, X1, Y1, TotRect, areaExponent)
    error = zeros(1,length(X0));
    for i = 1:length(X0)
        rect = [X0(i), Y0(i), X1(i), Y1(i)];
        error(i) = rectangleError(rect, areaExponent); 
    end
    
    R = vertcat(X0, Y0, X1, Y1, error);
    [~, n] = size(R);
    
    errorBounds = zeros(1,TotRect);
    while n < TotRect 
        errorBounds(n) = sum(R(5,:));
        
        [~, maxInd] = max(R(5,:));
        [rect1, rect2] = bestSplitRectSimple(R(:, maxInd), areaExponent);
        R(:,maxInd) = rect1;
        n = n+1;
        R(:, n) = rect2;
    end
    %R = sortcols(R, 2); %Sort by Y for cache-coherency
    X0out = R(1,:);
    Y0out = R(2,:); 
    X1out = R(3,:);
    Y1out = R(4,:); 
    
end