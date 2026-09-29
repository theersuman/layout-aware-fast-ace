function [ACESATimg] = ACESATCompute(img, slope, X0, Y0, X1, Y1)
    [Width, Height, Channel] = size(img);
    maxDepth = 255;
	WidthSAT = Width+1;
	HeightSAT = Height+1;
    
    
    avgDist= zeros(1, length(X0));
    for i = 1: length(X0)
        avgDist(i) = computeAvgDist(X0(i), Y0(i), X1(i)-1, Y1(i)-1);
    end

    %avgDist = sqrt((X0+X1-1).^2 + (Y0+Y1-1).^2) / 2;
    Output = zeros(Width, Height, Channel);
    
    %drawLayout(X0, Y0, X1, Y1);
    
    norm_per_pixel = zeros(Width, Height);
    for y = 1:Height
        for x = 1:Width
            x0 = clamp(X0+ x, 1, WidthSAT); 
            x1 = clamp(X1+ x, 1, WidthSAT);
            y0 = clamp(Y0+ y, 1, HeightSAT);
            y1 = clamp(Y1+ y, 1, HeightSAT);
       
            norm = (x1-x0).*(y1-y0)./avgDist;
            norm_per_pixel(x,y) = sum(norm);
        end
    end 

    %tic
    for c = 1:Channel
        I = double(img(:,:,c));
        SAT = zeros(WidthSAT, HeightSAT, maxDepth+1); %65536 -- 256 - va cambiato il numero max a causa della ppi
        
        for val = 1 : (maxDepth+1) %65536 -- 256 - va cambiato il numero max a causa della ppi
            M = clamp(-slope*(I - (val-1)), -maxDepth, maxDepth); %65535 -- 255 - va cambiato il numero max a causa della ppi
            SAT(:,:,val) = integralImage(M);
        end
    %toc
        for y = 1:Height
            for x = 1:Width
                z = I(x,y)*WidthSAT*HeightSAT-WidthSAT;
                
                x0 = clamp(X0+ x, 1, WidthSAT); 
                x1 = clamp(X1+ x, 1, WidthSAT);
                y0 = clamp(Y0+ y, 1, HeightSAT)*WidthSAT+z;
                y1 = clamp(Y1+ y, 1, HeightSAT)*WidthSAT+z;
                rectTot = +SAT(x1+y1)+ SAT(x0+y0)-SAT(x1+y0)-SAT(x0+y1);
                
                val  = rectTot./avgDist; 

                Output(x,y,c) = sum(val);
            
             end
         end 
    
    end
    ACESATimg = Output./norm_per_pixel; 

end
