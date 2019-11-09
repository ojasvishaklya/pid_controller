close all;
clear;

% open loop plant
Gp = tf(1, [5 15.5 11.5 1]);

% maximize figure window to use subplots
figure('units', 'normalized', 'outerposition', [0 0 1 1]);

% plant vs sys
subplot(2, 2, 1);
Gc = 1;
plant_vs_sys(Gp, Gc, 1);
title('Plant Vs System');

% stability margins of plant
[GM, PM, Pcf, Gcf] = margin(Gp);
Ku = GM; % gain at which sys is marginally stable
Tu = 2*pi/Pcf; % time period of sustained oscillations

% plant vs sys with P controller
subplot(2, 2, 2);
Kp = 0.5*Ku;
Gc = pid(Kp);
plant_vs_sys(Gp, Gc, 1);
title('Plant Vs System with P');

% plant vs sys with PI controller
subplot(2, 2, 3);
Kp = 0.4*Ku;
Ki = Kp/(0.8*Tu);
Gc = pid(Kp, Ki);
plant_vs_sys(Gp, Gc, 1);
title('Plant Vs System with PI');

% plant vs sys with PID controller
subplot(2, 2, 4);
Kp = 0.6*Ku;
Ki = Kp/(0.5*Tu);
Kd = Kp*0.12*Tu;
Gc = pid(Kp, Ki, Kd);
plant_vs_sys(Gp, Gc, 1);
title('Plant Vs System with PID');

% function to plot step response of plant and closed loop system
function [] = plant_vs_sys(gp, gc, f)
    sys = feedback(gc*gp, f); % closed loop system
    hold on;
    step(gp);
    step(sys);
    legend;
    hold off;
end
