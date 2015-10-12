% Välj först godtycklig polplacering (q_k)
% - Ger väldigt mycket.

q_k = 0.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

KuHp_tf = c2d(Ku*G1*G2*G3,1) % c2d = kontinuerlig till diskret
% "step(G1*G2*G3,KuHp_tf)" Jämförelse kontinuerlig tidsdiskret modell
% = >
% KuHp(z) = B(z)/A(z) = (b3*z^(-3)+b4*z^(-4)/(1+a1*z^(-1)+a2*z^(-2))
% = >
% P(z) = A'(z)*C'(z) + B(z)*D(z)  där A' = A(z)*(1-z^-1), C(z) = C'(z)*(1-z^(-1))
% nc' = nb -1 = 3
% nd  = na'-1 = 2
% m   = na'   = 3 => P(z) = (1-q*z^(-1))^3
syms z
syms a1 a2 b3 b4
syms c1 c2 c3 d0 d1 d2
syms q
A     = collect(1 + a1*z^-1 + a2*z^-2);
Aprim = collect(A*(1-z^-1));
B     = collect(b3*z^-3 + b4*z^-4);
Cprim = collect(1 + c1*z^-1 + c2*z^-2 + c3*z^-3);
C     = collect(Cprim*(1-z^-1));
D     = collect(d0 + d1*z^-1 + d2*z^-2);
P     = (1-q*z^-1)^3;
Kr    = collect(subs(P/B, z, 1));
% A'(z)*C'(z) + B(z)*D(z) = (1-q*z^(-1))^3
% =>
% z^5: a1 + c1 - 1 = -3*q
% z^4: a2 - a1 - c1 + c2 + a1*c1 = 3*q^2
% z^3: c3 - c2 - a2 - a1*c1 + a1*c2 + a2*c1 + b3*d0 = -q^3
% z^2: a1*c3 - a1*c2 - a2*c1 - c3 + a2*c2 + b3*d1 + b4*d0 = 3*q^2
% z^1: a2*c3 - a2*c2 - a1*c3 + b3*d2 + b4*d1 = 0
% z^0: -a2*c3 + b4*d2 = 0
% AMatrix * XMatrix = BMatrix där XMatrix = [c1; c2; c3; d0; d1; d2]
AMatrix = [1       0       0       0       0       0 ;
           -1+a1   1       0       0       0       0 ;
           -a1+a2  -1+a1   1       b3      0       0 ;
           -a2     -a1+a2  -1+a1   b4      b3      0 ;
           0       -a2     -a1+a2  0       b4      b3;
           0       0       -a2     0       0       b4;];
BMatrix = [-3*q-(a1-1)  ;
           3*q^2-(a2-a1);
           -q^3-(-a2)   ;
           0            ;
           0            ;
           0            ;];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Insättning av konstanter
a1_k = -1.686; % INSÄTTNING AV KONSTANTER MED numden(A) HADE VARIT ATT FÖREDRA
a2_k = 0.7097;
b3_k = 1.526e-06;
b4_k = 1.361e-06;
% =>
Kr = subs(Kr, [b3 b4], [b3_k b4_k])
Kr = double(subs(Kr, [b3 b4 q], [b3_k b4_k q_k]))
fprintf('\nXMatrix = [c1; c2; c3; d0; d1; d2]\n')
XMatrix = collect(subs(inv(AMatrix)*BMatrix,[a1 a2 b3 b4],[a1_k a2_k b3_k b4_k]))
XMatrix = double(subs(inv(AMatrix)*BMatrix,[a1 a2 b3 b4 q],[a1_k a2_k b3_k b4_k q_k]));
c1_k = XMatrix(1,1);
c2_k = XMatrix(2,1);
c3_k = XMatrix(3,1);
d0_k = XMatrix(4,1);
d1_k = XMatrix(5,1);
d2_k = XMatrix(6,1);
% =>
A = subs(A,[a1 a2],[a1_k a2_k]);
B = subs(B,[b3 b4],[b3_k b4_k]);
C = subs(C,[c1 c2 c3],[c1_k c2_k c3_k]);
D = subs(D,[d0 d1 d2],[d0_k d1_k d2_k]);
P = subs(P,[q],[q_k]);
% =>
q = q_k
a1 = a1_k;
a2 = a2_k;
b3 = b3_k;
b4 = b4_k;
c1 = c1_k
c2 = c2_k
c3 = c3_k
d0 = d0_k
d1 = d1_k
d2 = d2_k
% =>
A_tf = sym2dtf(A,1);
B_tf = sym2dtf(B,1);
C_tf = sym2dtf(C,1);
D_tf = sym2dtf(D,1);
P_tf = sym2dtf(P,1);
% =>
Htot_tf = Kr*B_tf/(A_tf*C_tf+B_tf*D_tf); % Y(z)/R(z)
step(Htot_tf)
grid on
