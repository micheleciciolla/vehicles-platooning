clear
%% PARAMETERS
M = 1000; % mass [kg] of each vehicle

% initial condition states [r, v] - STEADY STATE
n0_init = [0 0];
n1_init = [-5 0];
n2_init = [-10 0];
n3_init = [-15 0];
n4_init = [-20 0];

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
h20 = h10*2;
h30 = h10*3;
h40 = h10*4;

% stifness and damping coefficient
k = 0.5; % (?)
b = 0.5; % (?)

% --------------------------------------------------------------
%% SIMULATION

% temporal inputs
% the leader imposes a constant fleet vel = u0 = 20 [m/s] = 72 [km/h]
[u0,u1,u2,u3,u4] = deal(20,1,1,1,1);


% start simulation
simtime = 50;
output = sim('model.slx',simtime);

fprintf(2,"~\nProcess completed!\n~\n");