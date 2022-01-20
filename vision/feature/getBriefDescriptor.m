function descriptors = getBriefDescriptor(img, features)
  
  descriptors = [];
  for i = 1:size(features,1)
  i
  if(features(i,2)>5 && features(i,2)<size(img,1)-5 && features(i,1)>5 && features(i,1)<size(img,1)-5)
  descriptor = [];
  for m = -2:2
    for n = -2:2
      i_tgt = img(features(i,2)+m, features(i,1)+n);
      i_src = img(features(i,2)+n, features(i,1)+m);
      
      if(i_tgt>=i_src)
        code = 1;
      else
        code = 0;
      end
      
      descriptor = [descriptor, code];
    endfor
  endfor
  
  descriptors = [descriptors; descriptor];
  end
endfor

endfunction
