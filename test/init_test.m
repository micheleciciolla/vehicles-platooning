%% test
M = 2000; % mass [kg] of each vehicle
u = 1; % lin. velocity platoon input

% initial condition states [x y thehta psi]
n0_init = [10 0 0 0];
n1_init = [7 0 0 0];
n2_init = [3 0 0 0];
n3_init = [0 0 0 0];
n4_init = [-3 0 0 0];

simtime = 50;
output = sim('model.slx',simtime);
clc
disp("------------ Completed ------------");