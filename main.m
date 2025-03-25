clear; close all; clc;

dataCentreline = readtable("airJetLab.xlsx", 'Range', 'A1:J4');
dataX60 = readtable("airJetLab.xlsx", 'Range', 'A14:D29');
dataX180 = readtable("airJetLab.xlsx", 'Range', 'F14:I35');
dataX300 = readtable("airJetLab.xlsx", 'Range', 'K14:N39');

manometerAngle = 12.9;
manometerOffset = 11;
nozzleDiameter = 0.03;

%-------------------analysis 1---------------------------------------------

V_E = dataCentreline{4,2};
Q_E = (nozzleDiameter/2)^2*V_E;
M_E = 0.5*(V_E^2)*(Q_E*1.225);

disp(V_E)
disp(Q_E)
disp(M_E)

%-------------------analysis 2---------------------------------------------
figure('Units','centimeters','Position',[3, 3, 16, 10], ...
    'Name','5.2');
plot(dataCentreline{1,2:10},dataCentreline{4,2:10},'b:','LineWidth',1.5 ...
    ,'Color','k','LineStyle','-');

xlabel('Distance from Nozzle (mm)', 'FontSize', 12);
ylabel('Velocity (m/s)', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);

%-------------------analysis 3---------------------------------------------
figure('Units','centimeters','Position',[3, 3, 16, 10],'Name','5.3 X=60');
plot(dataX60{1:14, "R"}/30,dataX60{1:14,"V"}/V_E,'LineWidth',1.5,'Color','k', ...
    'LineStyle','-');
hold on
plot([-2.1, 2.1],[1, 1],'b','LineWidth',1.5,'LineStyle','--');
xlim([-2.1, 2.1]);  
ylim([0, 1.1]);   
xlabel('Radial Position (r/D)', 'FontSize', 12);
ylabel('Normalised Velocity (V/V_E)', 'FontSize', 12);
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off


figure('Units','centimeters','Position',[3, 3, 16, 10],'Name','5.3 X=180');
plot(dataX180{1:21, "R"}/30,dataX180{1:21,"V"}/V_E,'LineWidth',1.5,'Color','k', ...
    'LineStyle','-');
hold on
plot([-2.1, 2.1],[1, 1],'b','LineWidth',1.5,'LineStyle','--');
xlim([-2.1, 2.1]);  
ylim([0, 1.1]);   
ylabel('Normalised Velocity (V/V_E)', 'FontSize', 12);
xlabel('Radial Position (r/D)', 'FontSize', 12);
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off


figure('Units','centimeters','Position',[3, 3, 16, 10],'Name','5.3 X=300');
plot(dataX300{1:25, "R"}/30,dataX300{1:25,"V"}/V_E,'LineWidth',1.5,'Color','k', ...
    'LineStyle','-');
hold on
plot([-2.1, 2.1],[1, 1],'b','LineWidth',1.5,'LineStyle','--');
xlim([-2.1, 2.1]);  
ylim([0, 1.1]);   
ylabel('Normalised Velocity (V/V_E)', 'FontSize', 12);
xlabel('Radial Position (r/D)', 'FontSize', 12);
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off
%-------------------analysis 4---------------------------------------------
coreLength = 120;
divergenceUpper = table([60, 180, 300]', [24, 35, 40]', ...
    'VariableNames', {'X', 'Y'});
DivergenceLower = table([60, 180, 300]', [-28, -35, -50]', ...
    'VariableNames', {'X', 'Y'});

upperDivergenceLM = fitlm(divergenceUpper, 'Y ~ X');
disp(upperDivergenceLM);
lowerDivergenceLM = fitlm(DivergenceLower, 'Y ~ X');
disp(lowerDivergenceLM);

figure('Units', 'centimeters', 'Position', [3, 3, 16, 10], 'Name', '5.4');
hold on;

% Plot the black crosses as edge data points
h1 = plot(divergenceUpper.X/30, divergenceUpper.Y/30, 'kx','LineWidth',1.25);
plot(DivergenceLower.X/30, DivergenceLower.Y/30, 'kx','LineWidth',1.25);

r_start = [0.5, -0.5];  
r_end = 0;              
axial_start = 0;        
axial_end = 4;         
x_start = [0, 0];     
x_end = 4;             

h4=plot([x_start(1), x_end], [r_start(1), r_end], 'r--', 'LineWidth', 1.5); 
plot([x_start(2), x_end], [r_start(2), r_end], 'r--', 'LineWidth', 1.5); 

X_extrapolate = [0; divergenceUpper.X];
upper_prediction = predict(upperDivergenceLM, X_extrapolate);
lower_prediction = predict(lowerDivergenceLM, X_extrapolate);

h3 = plot(X_extrapolate/30, upper_prediction/30, 'k', 'LineWidth', 1.5,'LineStyle','--');
plot(X_extrapolate/30, lower_prediction/30, 'k', 'LineWidth', 1.5,'LineStyle','--');

legend([h1, h3, h4], {'Edge Data Points','Jet Edge Linear Model', 'Jet Core (approximate)'}, 'Location', 'northwest');

ylim([-2,2])
xlabel('Axial Distance (r/D)', 'FontSize', 12);
ylabel('Radial Position (r/D)', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off;

%-------------------analysis 5---------------------------------------------



%-------------------analysis 6---------------------------------------------

