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
%step(inv(Ku)*Ku*(G1*G2*G3));
%title('Step: u(t)=8360 (W)','Fontsize',15)
%xlabel('t','Fontsize',15)
%ylabel('y(t) (K)','Fontsize',15)
%grid on
%inv(ku) % [W]

% b:
%stepinfo(G1*G2*G3)

% c:
step(1*Kv*G1*G2*G3)
title('Step: v(t)=1 (K)','Fontsize',15)
xlabel('t','Fontsize',15)
ylabel('y(t) (K)','Fontsize',15)
grid on