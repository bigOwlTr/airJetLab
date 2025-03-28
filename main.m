clear; close all; clc;

dataCentreline = readtable("airJetLab.xlsx", 'Range', 'A1:J4');
dataX60 = readtable("airJetLab.xlsx", 'Range', 'A14:D29');
dataX180 = readtable("airJetLab.xlsx", 'Range', 'F14:I35');
dataX300 = readtable("airJetLab.xlsx", 'Range', 'K14:N39');

nozzleDiameter = 0.03;

%-------------------analysis 1---------------------------------------------

V_E = dataCentreline{4,2};
Q_E = (nozzleDiameter/2)^2*pi*V_E;
M_E =V_E*Q_E*1.225;

disp(V_E)
disp(Q_E)
disp(M_E)

%-------------------analysis 2---------------------------------------------
figure('Units','centimeters','Position',[3, 3, 16, 10], ...
    'Name','5.2');
plot(dataCentreline{1,2:10},dataCentreline{4,2:10},'b:','LineWidth',1.5 ...
    ,'Color','k','LineStyle','-');

xlabel('Distance from Nozzle (mm)', 'FontSize', 12, 'Interpreter','latex');
ylabel('Velocity (m/s)', 'FontSize', 12, 'Interpreter','latex');
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
xlabel('Radial Position ($r/D$)', 'FontSize', 12, 'Interpreter','latex');
ylabel('Normalised Velocity ($V/V_E$)', 'FontSize', 12, 'Interpreter','latex');
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12, 'Interpreter','latex');
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
ylabel('Normalised Velocity ($V/V_E$)', 'FontSize', 12, 'Interpreter','latex');
xlabel('Radial Position ($r/D$)', 'FontSize', 12, 'Interpreter','latex');
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12, 'Interpreter','latex');
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
ylabel('Normalised Velocity ($V/V_E$)', 'FontSize', 12, 'Interpreter','latex');
xlabel('Radial Position ($r/D$)', 'FontSize', 12, 'Interpreter','latex');
legend('Velocity Profile', 'Exit Velocity', 'Location', 'northeast', 'FontSize', 12, 'Interpreter','latex');
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

legend([h1, h3, h4], {'Edge Data Points','Jet Edge Linear Model', 'Jet Core (approximate)'}, 'Location', 'northwest', 'Interpreter','latex');

ylim([-2,2])
xlabel('Axial Distance ($x/D$)', 'FontSize', 12, 'Interpreter','latex');
ylabel('Radial Position ($r/D$)', 'FontSize', 12, 'Interpreter','latex');
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off;

%-------------------analysis 5&6-------------------------------------------

Q_X60 = 0;
Q_X180 = 0;
Q_X300 = 0;
M_X60 = 0;
M_X180 = 0;
M_X300 = 0;


for i=3:14
    V_R = dataX60{i,"V"};
    R = dataX60{i,"R"};
    higherR = (R+2)/1000;
    lowerR = (R-2)/1000;
    if i~=8
        halfAnnulusArea = abs(higherR^2-lowerR^2)*pi/2;
    elseif i == 8
        halfAnnulusArea = higherR^2*pi;
    end
        
    halfAnnulusVolumeFlow = halfAnnulusArea*V_R;
    halfAnnulusMomentumFlux = halfAnnulusVolumeFlow*V_R*1.225;
    M_X60 = M_X60+halfAnnulusMomentumFlux;
    Q_X60 = Q_X60+halfAnnulusVolumeFlow;
end

for i=5:18
    V_R = dataX180{i,"V"};
    R = dataX180{i,"R"};
    higherR = (R+2.5)/1000;
    lowerR = (R-2.5)/1000;
    if i~=11
        halfAnnulusArea = abs(higherR^2-lowerR^2)*pi/2;
    elseif i == 11
        halfAnnulusArea = higherR^2*pi;
    end
    halfAnnulusVolumeFlow = halfAnnulusArea*V_R;
    halfAnnulusMomentumFlux = halfAnnulusVolumeFlow*V_R*1.225;
    M_X180 = M_X180+halfAnnulusMomentumFlux;
    Q_X180 = Q_X180+halfAnnulusVolumeFlow;
end

for i=6:24
    V_R = dataX300{i,"V"};
    R = dataX300{i,"R"};
    higherR = (R+2.5)/1000;
    lowerR = (R-2.5)/1000;
     if i~=13
        halfAnnulusArea = abs(higherR^2-lowerR^2)*pi/2;
    elseif i == 13
        halfAnnulusArea = higherR^2*pi;
    end
    halfAnnulusVolumeFlow = halfAnnulusArea*V_R;
    halfAnnulusMomentumFlux = halfAnnulusVolumeFlow*V_R*1.225;
    M_X300 = M_X300+halfAnnulusMomentumFlux;
    Q_X300 = Q_X300+halfAnnulusVolumeFlow;
end

xD_values = [0, 60, 180, 300];

Q_values = [Q_E, Q_X60, Q_X180, Q_X300];
M_values = [M_E, M_X60, M_X180, M_X300];

figure('Units', 'centimeters', 'Position', [3, 3, 7, 10]);
hold on;
scatter(xD_values/30, Q_values/Q_E, 80, 'b', 'filled'); 
xlabel('Axial distance ($x/D$)', 'FontSize', 12, 'Interpreter','latex');
ylabel('Normalised Volumetric Flow Rate ($\dot{Q}/\dot{Q_E}$)', 'FontSize', 12, 'Interpreter','latex');
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
ylim([0,2.5])

hold off;

figure('Units', 'centimeters', 'Position', [3, 3, 7, 10]);
hold on;
scatter(xD_values/30, M_values/M_E, 80, 'r', 'filled');
xlabel('Axial distance ($x/D$)', 'FontSize', 12, 'Interpreter','latex');
ylabel('Normalised Momentum Flux ($\dot{M}/\dot{M_E}$)', 'FontSize', 12, 'Interpreter','latex');
grid on;
ylim([0,1.1])  
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
hold off;


