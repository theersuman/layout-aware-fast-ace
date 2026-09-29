function output = scalingLinear(img)

MAXr = max(max(img(:,:,1)));
MAXg = max(max(img(:,:,2)));
MAXb = max(max(img(:,:,3)));

MINr = min(min(img(:,:,1)));
MINg = min(min(img(:,:,2)));
MINb = min(min(img(:,:,3)));

output(:,:,1) = 255.0*(img(:,:,1) - MINr) / (MAXr - MINr);
output(:,:,2) = 255.0*(img(:,:,2) - MINg) / (MAXg - MINg); 
output(:,:,3) = 255.0*(img(:,:,3) - MINb) / (MAXb - MINb); 

end
