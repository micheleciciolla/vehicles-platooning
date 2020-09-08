clear
cd /home/mic-ciciolla/Documents/università/incompleted/elective/4_multirobot/vehicles-platooning/test
%% PARAMETERS
M = 1000; % mass [kg] of each vehicle

% initial condition states [r, v] - STEADY STATE
n0_init = [3 0];
n1_init = [-5 0];
n2_init = [-10 0];
n3_init = [-20 0];
n4_init = [-30 0];

% adjacency matrix
% N = 4
% NB. i=[2...4] (?)
% NB. j=[1...5] (?)
% i<j=i+1

A = zeros(5,5);
A(2:end ,1) = ones(4,1);
A(3,2) = 1; A(4,3) = 1; A(5,4) = 1;

% degree of agents i
d0 = 4;
d1 = 2;
d2 = 3;
d3 = 3;
d4 = 2;

% spacing policy
h10 = 0.8; % [s]
h20 = 3*h10;
h30 = 3*h20;
h40 = 3*h30;

% stifness and damping coefficient
% maybe we should consider to have one coefficient for each car
k = 120; % (?)
b = 270; % (?)

% individual params (to-do)
b1 = 120;
k1 = 270;

b2 = 120;
k2 = 270;

b3 = 120;
k3 = 270;

b4 = 120;
k4 = 270;

% --------------------------------------------------------------
%% SIMULATION

% temporal inputs
% the leader imposes a constant fleet vel = u0 = 20 [m/s] = 72 [km/h]
u0 = 20;

% start simulation
simtime = 300;
output = sim('model.slx',simtime);

fprintf(2,"~\nProcess completed!\n~\n");