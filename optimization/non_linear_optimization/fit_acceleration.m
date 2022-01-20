clear all;
close all;

t = [0:1:100]';
y = zeros(size(t,1),1);

% y = 0.5*a*t^2 + v*t + p;


pos = 50;
vel = 100;
a = 2;

y = getY(t, [pos, vel, a]);


figure()
plot(t,y);



%% optimization
state = [0,0,0]'; % [p,v,a]

y_curr = getY(t, state);
error = (y-y_curr);
error_norm = norm(error);
while(error_norm > 0.1)

  % disturb each freedom to get jacobian of error
  % jacobian = [dy/dp, dy/dv, dy/da]
  delta = 0.01;
  dy_dp = (getError(t, [state(1)+delta, state(2), state(3)],y) - getError(t, [state(1)-delta, state(2), state(3)],y)) ./ (2*delta);
  dy_dv = (getError(t, [state(1), state(2)+delta, state(3)],y) - getError(t, [state(1), state(2)-delta, state(3)],y)) ./ (2*delta);
  dy_da = (getError(t, [state(1), state(2), state(3)+delta],y) - getError(t, [state(1), state(2), state(3)-delta],y)) ./ (2*delta);
  
  
  jacobian = [dy_dp, dy_dv, dy_da];
  
  %%  ------------------------------
  %%  update state based on jacobian
  %%  ------------------------------
  
  %% gradient decent
  %% https://www.cnblogs.com/pinard/p/5970503.html
  %learning_rate = 0.001;
  %delta_state = -1.*jacobian'*error;
  %delta_state = learning_rate*(delta_state ./norm(delta_state));
  
  
  % newton method: h*x = -j'*e  => x = -inv(h)*j'*e with: h = j'*j ,  here j is jacobian of error
  % https://jishuin.proginn.com/p/763bfbd31493
  % https://blog.csdn.net/qq_37568167/article/details/105972628
  % https://blog.csdn.net/KYJL888/article/details/111469789
  delta_state = -1.* inv(jacobian'*jacobian)*jacobian'*error;
  
  
  
  state = state .+ delta_state;
  state'
  y_curr = getY(t, state);
  error = (y-y_curr);
  error_norm = norm(error);
  error_norm
  
  %pause(1)
  
end


