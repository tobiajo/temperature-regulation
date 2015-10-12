% Instruktion:
%  "d_generell, q=0.3" => d_int_model, output t,y1
%  "d_generell, q=0.5" => d_int_model, output t,y2
%  "d_generell, q=0.7" => d_int_model, output t,y3
%  Kör sedan skriptet
hlines = plot(t,y1,t,y2,t,y3)
title('Step: v(t)=1 (K)','Fontsize',15)
xlabel('t (seconds)','Fontsize',15)
ylabel('y(t) (K)','Fontsize',15)
grid on
set(hlines(1),'Displayname',['q = 0.3'])
set(hlines(2),'Displayname',['q = 0.5'])
set(hlines(3),'Displayname',['q = 0.7'])
legend('Location','east')