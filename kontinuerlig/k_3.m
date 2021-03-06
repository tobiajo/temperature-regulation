V1 = 10*10^-3; % [m^3]
Vr =  4*10^-3; % [m^3]
V2 = 14*10^-3; % [m^3]
Q  =  2*10^-3; % [m^3/s]
c = 4180; % [J/K*kg]
r = 1000; % [kg/m^3]

s=tf('s');
G1 = 1/((V1/Q)*s+1);
G2 = exp(-(Vr/Q)*s);
G3 = 1/((V2/Q)*s+1);
Kv = 1;
Ku = 1/(Q*c*r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a:
%margin(Ku*G1*G2*G3)
%grid on

% b:
K0 = 10^(95/20);
T0 = 2*pi/0.402;
P = 0.6*K0
I = P/(0.5*T0)
D = P*0.125*T0

% c:
semilogy(t,u)
title('Step: v(t)=-1 (K)','Fontsize',15)
xlabel('t (seconds)','Fontsize',15)
ylabel('u(t) (W)','Fontsize',15)
grid on