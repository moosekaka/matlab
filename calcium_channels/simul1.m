%-----------------%                   
% Simulation File %  

%-----------------%
tic
clear all;close all;
Parameters_Conv1; 
% TE = [];
% YE = [];


te = 150; numSteps=10000;   
tspan = linspace(0,te,numSteps);
options = odeset('AbsTol',1e-11,'RelTol' ,1e-9);%

[TE,YE]=ode15s(@ODE_mod,tspan,ye,options,cellCaPara);
figure;
plot(TE,[YE(:,1),YE(:,3)])

toc

%%
ytmp = rand(5,1); t = 0;
dytmpdt=ODE_mod(t,ytmp,cellCaPara)