%Implementation of the ORIGINAL ACE algorithm

function output = ACE_ForzaBruta(img, slope) 

input = double(img);
[Width, Height, Channel] = size(input);

output = (zeros(Width,Height,Channel)); %uint8

for x0 = 1:Width
    for y0 = 1:Height
        sum_r = 0;
        sum_g = 0;
        sum_b = 0;
        sum_norm = 0;
        for x1=1:Width
             for y1=1:Height
                  out_r = clamp(slope*(input(x0,y0,1) - input(x1,y1,1)), -255, 255); 
                  out_g = clamp(slope*(input(x0,y0,2) - input(x1,y1,2)), -255, 255);
                  out_b = clamp(slope*(input(x0,y0,3) - input(x1,y1,3)), -255, 255); 
                    
                  distance = sqrt((x1-x0)^2 + (y1-y0)^2);
                        
                  if(distance ~= 0)
                      sum_r = sum_r + out_r/distance;
                      sum_g = sum_g + out_g/distance;
                      sum_b = sum_b + out_b/distance;
                      sum_norm = sum_norm + 1/distance;
                                               
                   end
              end
        end
        
        %sum_norm = 1;
        output(x0, y0, 1) = (sum_r/sum_norm); %uint8
        output(x0, y0, 2) = (sum_g/sum_norm); %uint8
        output(x0, y0, 3) = (sum_b/sum_norm); %uint8
        
        
    end
end


end


