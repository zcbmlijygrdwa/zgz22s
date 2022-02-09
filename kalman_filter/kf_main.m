clear all;
close all;

% simulation

car_x = [];
car_y = [];
car_vx = [];
car_vy = [];

x = 0;
y = 0;
vx = 5;
vy = 0;

dt = 1;

car_x = [car_x; x];
car_y = [car_y; y];
car_vx = [car_vx; vx];
car_vy = [car_vy; vy];

state_prev = [x;y;vx;vy];

for i = 1:99

if(i==20)
  state_prev(3) = 2;
  state_prev(4) = 3;
end

F = [
1 0 dt 0
0 1 0 dt
0 0 1 0
0 0 0 1
]; 

state = F*state_prev; 

car_x = [car_x; state(1)];
car_y = [car_y; state(2)];
car_vx = [car_vx; state(3)];
car_vy = [car_vy; state(4)]; 

state_prev = state;
end

figure()
scatter(car_x, car_y);


% generate two sensor data: position sensor and velocity sensor
sensor_pos_var = 0.05;
sensor_vel_var = 0.1;

sensor_pos_x = car_x .+ normrnd(0,sensor_pos_var,length(car_x),1);
sensor_pos_y = car_y .+ normrnd(0,sensor_pos_var,length(car_y),1);

sensor_vel_x = car_vx .+ normrnd(0,sensor_vel_var,length(car_vx),1);
sensor_vel_y = car_vy .+ normrnd(0,sensor_vel_var,length(car_vy),1);




% using KF to estimate states
P = eye(4);  % covariance of states, set to big number to init
P(1,1) = 5;
P(2,2) = 5;
P(3,3) = 5;
P(4,4) = 5;

Q = eye(4)*0.001; % covariance of states process noise

%R = eye(4); % covariance of states sensor noise
%R(1,1) = sensor_pos_var;
%R(2,2) = sensor_pos_var;
%R(3,3) = sensor_vel_var;
%R(4,4) = sensor_vel_var;

R = eye(2); % covariance of states sensor noise
R(1,1) = sensor_pos_var;
R(2,2) = sensor_pos_var;


% observation matrix

%H = [
%1 0 0 0
%0 1 0 0
%0 0 1 0
%0 0 0 1
%];

H = [
1 0 0 0
0 1 0 0
];

kf_x = [];
kf_y = [];
kf_vx = [];
kf_vy = [];


% check observability
o = [H;H*F;H*F*F;H*F*F*F];
observability = rank(o);
if(observability ~= length(state))
  disp("wrong observability");
  return;
end

X = [sensor_pos_x(1); sensor_pos_y(1); sensor_vel_x(1); sensor_vel_y(1)];
for i = 2:length(sensor_pos_x)
  X_prev = X;
  P_prev = P;
  
  % prediction
  X_pred = F*X_prev;
  P_pred = F*P_prev*F' + Q;
  
  % observation
  %Z = [sensor_pos_x(i); sensor_pos_y(i); sensor_vel_x(i); sensor_vel_y(i)];
  Z = [sensor_pos_x(i); sensor_pos_y(i)];
  
  %i
  %c = P_pred
  %b = H*P_pred*H'
  %a = inv(H*P_pred*H' + R)
  K = (P_pred*H')*inv(H*P_pred*H' + R);
  
  X = X_pred + K*(Z - H*X_pred);
  kf_x = [kf_x; X(1)];
  kf_y = [kf_y; X(2)];
  kf_vx = [kf_vx; X(3)];
  kf_vy = [kf_vy; X(4)];
  
  P = (eye(4)-K*H)*P_pred;
endfor

figure()
scatter(sensor_pos_x, sensor_pos_y,'-');
hold on
scatter(kf_x, kf_y,'-');
title("position")
legend("sensor", "kf")

figure()
scatter(sensor_vel_x, sensor_vel_y,'-');
hold on
scatter(kf_vx, kf_vy,'-');
title("velocity")
legend("sensor", "kf")


