clear; close all; clc;

dataCentreline = readtable("airJetLab.xlsx", 'Range', 'A1:J4');
dataX60 = readtable("airJetLab.xlsx", 'Range', 'A1:J4');
dataX180 = readtable("airJetLab.xlsx", 'Range', 'A1:J4');
dataX300 = readtable("airJetLab.xlsx", 'Range', 'A1:J4');

manometerAngle = 12.9;
manometerOffset = 11;
nozzleDiameter = 0.03;

%-------------------analysis 1---------------------------------------------

V_E = dataCentreline{4,2};
Q_E = (nozzleDiameter/2)^2*V_E;
M_E = 0.5*(V_E^2)*(Q_E*1.225);

%-------------------analysis 2---------------------------------------------

plot(dataCentreline{1,2:10},dataCentreline{4,2:10},'b:','LineWidth',1.5 ...
    ,'Color','k','LineStyle','-');

xlabel('Distance from Nozzle (mm)', 'FontSize', 12);
ylabel('Velocity (m/s)', 'FontSize', 12);
grid on;

set(gca, 'FontSize', 12, 'LineWidth', 1.5);

%-------------------analysis 3---------------------------------------------



%-------------------analysis 4---------------------------------------------



%-------------------analysis 5---------------------------------------------



%-------------------analysis 6---------------------------------------------

