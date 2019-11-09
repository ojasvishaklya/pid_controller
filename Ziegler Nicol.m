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
Ki=0;
Kd=0;
cont=pid(Kp,Ki,Kd);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');

%PI-Controller
Kp=0.45*K;
Ki=T/1.2;
Kd=0;
cont=pid(Kp,1/Ki,Kd);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');

%PID-Controller
Kp=0.6*K;
Ki=T/2;
Kd=T/8;
cont=pid(Kp,1/Ki,Kd);
cl_sys=feedback(sys*cont,1);
[y,t] =step(cl_sys);
plot(t,y,'LineWidth',2); grid on; xlabel('Time(s)'); ylabel('Amplitude');
