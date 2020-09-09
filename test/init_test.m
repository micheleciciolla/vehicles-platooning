try
    cd /home/mic-ciciolla/Documents/università/incompleted/elective/4_multirobot/vehicles-platooning/test
    disp("directory changed");
catch
    return

end


    close all

%% PARAMETERS
M = 1200; % mass [kg] of each vehicle

% initial condition states [r, v] - STEADY STATE
n0_init = [0 0];
n1_init = [-3 0];
n2_init = [-8 0];
n3_init = [-13 0];
n4_init = [-18 0];

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
h10 = -0.8; % [s]
h20 = h10*2;
h30 = h10*3;
h40 = h10*4;

% stifness and damping coefficient
% b, kij >0
% maybe we should consider to have one coefficient for each car
b = 550;

% individual params (to-do)
k1 = 120;
k2 = 120;
k3 = 120;
k4 = 90;

% --------------------------------------------------------------
%% SIMULATION

% the leader imposes a constant fleet vel = u0 = 20 [m/s] = 72 [km/h]
% this is a constant VELOCITY input
u0 = 20;

% start simulation
simtime = 200;
out = sim('model.slx',simtime);

fprintf(2,"~\nProcess completed!\n~\n");

clc

%% Getting data from Simulink - state variable structure
t = out.r0.time;
dim = size(t);

r0 = out.r0.signals.values;
r1 = out.r1;
r2 = out.r2;
r3 = out.r3;
r4 = out.r4;

v0 = out.v0;
v1 = out.v1;
v2 = out.v2;
v3 = out.v3;
v4 = out.v4;

err10 = out.err10;
err20 = out.err20;
err30 = out.err30;
err40 = out.err40;

figure()
hold on, grid minor
plot(t,[err10,err20,err30,err40],'-.');
legend('r1-r0-h10v0','r2-r0-h20v0','r3-r0-h30v0','r4-r0-h40v0');
xlabel("time");
ylabel("error");
title("car distance error");

% Printing final error
disp("Final err1");
disp(err10(end))

disp("Final err2");
disp(err20(end))

disp("Final err3");
disp(err30(end))

disp("Final err4");
disp(err40(end))








