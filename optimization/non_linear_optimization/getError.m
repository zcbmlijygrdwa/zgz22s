function error = getError(t, state, y)
  y_curr = getY(t, state);
  error = (y-y_curr);
endfunction
