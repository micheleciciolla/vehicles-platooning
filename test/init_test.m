%% This form will be useful when simulating with the driving scenario
close all

%% CRUISE VELOCITY v0
fleet_vel = 20;
%% NOISE ON r0
noise = 1;
%% SIMULATION TIME 
simtime = 200;

%% CALL THE SIMULATION
out = simulate(fleet_vel,noise,simtime);

%% CREATE PLOTS
usefulplots(out,simtime);

%% ------- functions -------

function [] = usefulplots(out,simtime)

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
plot(t,[err10,err20,err30,err40],'--','LineWidth',0.1);
legend('r_1-r_0- h_{10}v_0','r_2-r_0- h_{20}v_0','r_3-r_0- h_{30}v_0','r_4-r_0- h_{40}v_0');
xlim([-5,simtime+10])
xlabel("time");
ylabel("error");
title("car distance error");

% Printing final error
disp("Final err1");
disp(err10(end))
if round(err10(end),5) > 0
    fprintf(2," Error must be at least negative\n");
end

disp("Final err2");
disp(err20(end))
if round(err20(end),5) > 0
    fprintf(2," Error must be at least negative\n");
end
    
disp("Final err3");
disp(err30(end))
if round(err30(end),5) > 0
    fprintf(2," Error must be at least negative\n");
end

disp("Final err4");
disp(err40(end))
if round(err40(end),5) > 0
    fprintf(2,"This error is not accettable : error must be at least negative,not positive\n");
end

end

function out = simulate(fleet_vel,noise,simtime)

%% PARAMETERS
M = 1200; % mass [kg] of each vehicle

% initial condition states [r, v] - STEADY STATE
n0_init = [100 20];
n1_init = [80 0];
n2_init = [60 0];
n3_init = [40 0];
n4_init = [20 0];

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

%% ho rimesso negativo
% spacing policy
h10 = -0.8; % [s]
h20 = h10*2;
h30 = h10*3;
h40 = h10*4;

% stifness and damping coefficient
% b, kij >0
b = 2000;

% individual params
k1 = 1600;
k2 = 1500;
k3 = 1400;
k4 = 1100;

% --------------------------------------------------------------
%% SIMULATION

% the leader imposes a constant fleet vel = u0 = 20 [m/s] = 72 [km/h]
% this is a constant VELOCITY, our input is accelleration

% per qualche strano motivo non sono m/s ma ogni 1000 di u sono 0.8m/s (e
% vuoi vedere che dipende dallo spacing policy? me ne sto accorgendo mentre
% te lo scrivo calcola ahah)no ok --> NON DIPENDE DALLO SPACING POLICY ho
% fatto le prove, per cui le u nel grafico degli input sono ragionevoli
u0 = 0;

% start simulation
out = sim('model.slx',simtime);

clc
fprintf(2,"~\nProcess completed!\n~\n");

end







