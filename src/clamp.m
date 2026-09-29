function y = clamp(x,minval,maxval)
  % return bounded value clipped between minval and maxval
  y = min(max(x,minval),maxval);
end