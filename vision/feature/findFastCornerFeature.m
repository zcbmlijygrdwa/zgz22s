function features = findFastCornerFeature(img)

% https://senitco.github.io/2017/06/30/image-feature-fast/

features = [];
r = 20;

% find fast corner points
for i = 4:size(img,1)-3
  i
  for j = 4:size(img,2)-4
    i_p = img(i,j);
    i_t = [img(i,j-3)];
    i_t = [i_t; img(i+1,j-3)];
    i_t = [i_t; img(i+2,j-2)];
    i_t = [i_t; img(i+3,j-1)];
    i_t = [i_t; img(i+3,j)];
    i_t = [i_t; img(i+3,j+1)];
    i_t = [i_t; img(i+2,j+2)];
    i_t = [i_t; img(i+1,j+3)];
    i_t = [i_t; img(i+0,j+3)];
    i_t = [i_t; img(i-1,j+3)];
    i_t = [i_t; img(i-2,j+2)];
    i_t = [i_t; img(i-3,j+1)];
    i_t = [i_t; img(i-3,j+0)];
    i_t = [i_t; img(i-3,j-1)];
    i_t = [i_t; img(i-2,j-2)];
    i_t = [i_t; img(i-1,j-3)];
    i_t;
    
    
    count = 0;
    count_max = 0;
    
    for m = 1:length(i_t)
      if(i_t(m)>=i_p+r)
        count = count +1;
      else
        count_max = max(count_max, count);
        count = 0;
      end
    endfor
    
    is_feature = false;
    if(count_max >=9)
      is_feature = true;
    end
    
    count = 0;
    count_max = 0;
    for m = 1:length(i_t)
      if(i_t(m)<=i_p-r)
        count_max = max(count_max, count);
        count = count +1;
      else
        count = 0;
      end
    endfor

    if(count_max >=9)
      is_feature = true;
    end
    
    if(is_feature)
      %count_max
      features = [features; [i,j]];
    end
    
  endfor
endfor
  
endfunction
