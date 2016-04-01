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

%% POST-PROCESS INFORMATION
for i = 1:15 %why do you have it from 1to 14?

% Calculate a "Gross Domestic Product"
exp.labor = 0.3;
exp.capital = 0.05*(i-1); %0.5;
exp.nature_cons = 1- exp.labor - exp.capital;

N = length(T);
labor = Y(:,1);
capital = Y(:,4);
nature = Y(:,3);
nature_cons = delta*labor.*nature;
nature_rate = diff(Y(:,4));
GDP  = capital.^exp.capital .* labor.^exp.labor .* nature_cons.^exp.nature_cons;

% Find time at maximum values of key states and calculations
maxx.GDP(i) = find(GDP==max(GDP));
maxx.wealth(i) = find(capital==max(capital));
maxx.nature_cons(i) = find(nature_cons==min(nature_cons));
maxx.xc(i) = find(labor==max(labor));
if Y(N,2)>0
    maxx.xe(i) = find(Y(:,2)==max(Y(:,2)));
else
    maxx.xe(i) = 0;
end


end % for i

%% Plotting
% plot(T,Y(:,1),'b',T,Y(:,2),'c',T,Y(:,3),'r',T,Y(:,4),'k')
subplot(2,1,1)
plot(T,Y(:,1)/max(Y(:,1)),'b',T,Y(:,2)/max(Y(:,2)),...
    'c',T,Y(:,3)/max(Y(:,3)),'r',T,Y(:,4)/max(Y(:,4)),'k')
legend('xc','xe','nature','wealth')
xlabel('years')


subplot(2,1,2)
xx = [0:.05:.7];
plot([0:.05:.7],maxx.xc./maxx.GDP,'b',...
    [0:.05:.7],maxx.nature_cons./maxx.GDP,'r',...
    [0:.05:.7],maxx.wealth./maxx.GDP,'k');
xlabel('GDP exponent')
ylabel('time of maximum X relative to maximum Y')
legend('xc/GDP','wealth/GDP','nature cons/GDP')
