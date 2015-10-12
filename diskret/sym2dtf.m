function H = sym2dtf(h,Ts)
[num,den]=numden(h);
num_n=sym2poly(num);
den_n=sym2poly(den);
H = tf(num_n,den_n,Ts);
end