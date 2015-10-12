% Plottar stegsvaret för valda polplaceringar (q1, q2, q,3),
% samt anger presentear prestanda m.h.a. "stepinfo".

q1 = 0.3;
q2 = 0.5;
q3 = 0.7;

[y1 u1 t1] = d_iterativ(q1);
stepinfo(y1,t1)
[y2 u2 t2] = d_iterativ(q2);
stepinfo(y2,t2)
[y3 u3 t3] = d_iterativ(q3);
stepinfo(y3,t3)

subplot(2,1,1)
hlines1 = plot(t1,y1,t2,y2,t3,y3);
title('Step: r(t)=1 (K)','Fontsize',15)
xlabel('t (seconds)','Fontsize',15)
ylabel('y(t) (K)','Fontsize',15)
grid on
set(hlines1(1),'Displayname',['q = ' num2str(q1)])
set(hlines1(2),'Displayname',['q = ' num2str(q2)])
set(hlines1(3),'Displayname',['q = ' num2str(q3)])
legend('Location','east')

subplot(2,1,2)
hlines2 = plot(t1,u1,t2,u2,t3,u3);
title('Step: r(t)=1 (K)','Fontsize',15)
xlabel('t (seconds)','Fontsize',15)
ylabel('u(t) (W)','Fontsize',15)
grid on
set(hlines2(1),'Displayname',['q = ' num2str(q1)])
set(hlines2(2),'Displayname',['q = ' num2str(q2)])
set(hlines2(3),'Displayname',['q = ' num2str(q3)])
legend('Location','east')