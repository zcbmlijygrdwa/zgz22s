function y = getY(t, state)
  % state = [p,v,a];
  
  pos = state(1);
  vel = state(2);
  acc = state(3);
  
  y = zeros(size(t,1),1);
  for i = 2:size(t,1)
    d_t = t(i)-t(i-1);
    vel = vel + acc*d_t;
    pos = pos + vel*d_t + 0.5*acc*d_t*d_t;
    y(i) = pos;
  endfor
  
endfunction
