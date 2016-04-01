function xdot = handy_dot(t,x)

global alpha beta S rho gamma lambda kappa delta

% States are:
% X(1) = n.c, number of commoners
% X(2) = n.e, number of elites
% X(3) = y, quantity of nature
% X(4) = w, accumulated wealth

% Define variables
n.c = x(1);
n.e = x(2);
y = x(3);
w = x(4);

% specify consumption levels, C, of commoners and elites
w_th = rho*n.c + kappa*rho*n.e;     % threshold in wealth below which famine starts
C.c = min(1,w/w_th)*S*n.c;          % consumption by commoners
C.e = min(1,w/w_th)*kappa*S*n.e;    % consumption by elites

% Specify death raw_thtes
alpha_c = alpha.m + max(0,1-C.c/(S*n.c))*(alpha.M-alpha.m);
alpha_e = alpha.m + max(0,1-C.e/(S*n.e))*(alpha.M-alpha.m);


% Dynamic equations
xdot(1) = beta.c*n.c - alpha_c*n.c;
xdot(2) = beta.e*n.e - alpha_e*n.e;
xdot(3) = gamma*y*(lambda - y) - delta*n.c*y;
xdot(4) = delta*n.c*y - C.c - C.e;

xdot = xdot';