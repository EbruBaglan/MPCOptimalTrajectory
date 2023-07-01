clear; clc;
close all;
% Step1: From...to...
% initstate= [0; 0;pi/2-b;0;0;0];
% termstate= [0;10;pi/2-b;0;0;0];
% 
% Step2: From...to...
% initstate= [ 0;10;pi/2-b;0;0;0];
% termstate= [10;10;pi/2-b;0;0;0];
% 
% Step3: From...to...
% initstate= [10;10;pi/2-b;0;0;0];
% termstate= [10; 0;pi/2-b;0;0;0];



Ts = 0.4;
p = 30;
nx = 6; % x y theta and derivatives
nu = 6; % 3 motor forces, 3 angles of motors

nesne = nlmpcMultistage(p, nx,nu);
nesne.Ts = Ts;

nesne.Model.StateFcn = "TobuStateFcn";

for i = 1:p
    nesne.Stages(i).CostFcn = 'TobuCostFcn'; %Stages, not States
end

for i = 1:3
    nesne.MV(i).Min = 0; % *0N
    nesne.MV(i).Max = 1000; % *N
    nesne.MV(i+3).Min = -pi/3; % * solved by  quadratic
    nesne.MV(i+3).Max =  pi/3; % *
end

% set limits on states
%nesne.States.Max(3) = pi/3;
%nesne.States.Max(4) = pi/3;

%b = 0;
b = 34/180*pi;
% pi/2-b is the standing position
states(:,1) = [0; 0;pi/2-b;0;0;0];
states(:,2) = [0;10;pi/2-b;0;0;0];
states(:,3) = [10;10;pi/2-b;0;0;0];
states(:,4) = [10; 0;pi/2-b;0;0;0];

for eb =1:3
    x0 = states(:,eb);
    nesne.Model.TerminalState = states(:,eb+1);
    
    u0 = zeros(nu,1); % changed here
    
    % check if the models are correct
    % validateFcns(nesne,x0,u0)
    
    % calculate optimal trajectory
    [~,~,info] = nlmpcmove(nesne,x0,u0);
    infoall(eb) =info; 
    fprintf("Analysis %d is over.\n",eb)
end

EbruGraph2(infoall,p)