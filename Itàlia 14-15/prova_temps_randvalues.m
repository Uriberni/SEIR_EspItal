clear all
close all

% Datos de ejemplo (puedes reemplazar esto con tus datos reales)
Inf = [1,3,6]; % Vector semanal de 24 valores
Nous_agru = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]; % Vector diario de 168 valores

% Expande el vector semanal a diario
%Inf_diario = repelem(Inf, 7);

% Vectores de tiempo
tt = 1:length(Inf)*3; % Vector de tiempo para datos diarios
temps = 1:length(Nous_agru); % Vector de tiempo para datos diarios

% Graficar los datos
figure;
plot(tt, Inf, '-or'); % Grafica los datos diarios expandido desde el vector semanal
hold on;
plot(temps, Nous_agru, '-b'); % Grafica los datos diarios originales
hold off;

% Etiquetas y título
xlabel('Días');
ylabel('Valores');
title('Gráfico de Datos Semanales y Diarios Alineados');
legend('Datos Semanales (Expandido a Diario)', 'Datos Diarios');
