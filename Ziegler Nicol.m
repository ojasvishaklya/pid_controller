close all;
clear all;
num=[1];
den=[5 15.5 11.5 1];
sys=tf(num,den);
[y,t] =step(sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');

hold on;
[GM, PM, Pcf, Gcf] = margin(Gp);
K = GM; % gain at which sys is marginally stable
T = 2*pi/Pcf; % time period of sustained oscillations

%P-Controller
Kp=0.5*K;
cont=pid(Kp);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');

%PI-Controller
Kp=0.4*K;
Ki=Kp/(0.8*T);
cont=pid(Kp,Ki);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');

%PID-Controller
Kp=0.6*K;
Ki=Kp/(0.5*T);
Kd=Kp*0.12*T;
cont=pid(Kp,Ki,Kd);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');
