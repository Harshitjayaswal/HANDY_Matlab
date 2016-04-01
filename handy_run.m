% This m-file runs the "HANDY" = Human and Nature DYnamics model as
% developed by Motesharrei:
% S. Motesharrei et al. / Ecological Economics 101 (2014) 90–102
% Human and nature dynamics (HANDY): Modeling inequality and use of
% resources in the collapse or sustainability of societies
% Safa Motesharrei, Jorge Rivas, Eugenia Kalnay

global alpha beta S rho gamma lambda kappa delta

%% SIMULATE HANDY MODEL
% States are:
% X(1) = n.c, number of commoners
% X(2) = n.e, number of elites
% X(3) = y, quantity of nature
% X(4) = w, accumulated wealth

% Specify global parameters 
alpha.m = 0.01;         % [1/yr] normal (minimimum) death rate
alpha.M = 0.07;         % [1/yr] Famine (maximum) death rate
beta.c = 0.03;          % 0.03[1/yr] commoner birth rate
beta.e = 0.03;          % [1/yr] elite birth rate
S = 5e-4;               % [nauture/(person * yr)] subsitence salary per person
rho = 5e-3;             % 5e-3[nature/person] subsitence salary per capita
gamma = 0.01;           % [1/(nature * yr)] regeneration rate of nature
lambda = 100;           % 100[nature] nature carrying capacity
kappa = 10;             % 10[--] inequality factor (multiple of elite consumption per person divided by commoner consumption per person)
delta = 1.3e-5;           % 1.3e-5= 

% Set initial conditions
nc_o = 100;             % initial number of commoners
ne_o = 0;               % initial number of elites
y_o = lambda;           % initial quantity of nature
w_o = 0;                % initial quanity of wealth

% Call the differential equation function
y0 = [nc_o ne_o y_o w_o];       % vector of intial conditions
tspan = [0 500];                % time span of simulation
[T,Y] = ode45(@handy_dot,tspan,y0);
