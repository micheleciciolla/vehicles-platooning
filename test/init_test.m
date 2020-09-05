%% test
M = 1200; % mass [kg] of each vehicle

% temporal inputs
[u0,u1,u2,u3,u4] = deal(1,1,1,1,1);

% initial condition states [r, v]
n0_init = [0 0];
n1_init = [-5 0];
n2_init = [-10 0];
n3_init = [-15 0];
n4_init = [-20 0];

simtime = 50;
output = sim('model.slx',simtime);
disp("------------ Completed ------------");