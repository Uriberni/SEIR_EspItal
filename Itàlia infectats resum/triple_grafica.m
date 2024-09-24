clear all 
close all

matriu;

Inf1415=Itliainfectatsresum.s1415;
Inf1617=Itliainfectatsresum.s1617;
Inf1718=Itliainfectatsresum.s1718;
temps=Itliainfectatsresum.setmanes;

plot(Inf1415);
hold on
plot(Inf1617);
plot(Inf1718);
xlabel('Temps (setmanes)');
ylabel('Casos/10^5 hab');
title('Resum Itàlia')
grid on
yline(max(Inf1415),'--');
yline(max(Inf1617),'--');
yline(max(Inf1718),'--');
legend('14/15','16/17','17/18')
hold off
temps=str2double(temps);

%% Ordenar setmanes 
% Personalizar las etiquetas en el eje x para mostrar el orden real del año
num_semanas = length(temps);
xticks(1:num_semanas); % Establecer los marcadores en las posiciones de las semanas
xticklabels(mod(temps-1, 52) + 1); % Etiquetas personalizadas
xtickangle(90);
% Mostrar solo un número limitado de etiquetas en el eje x para evitar aglomeraciones
num_etiquetas_mostrar = 28; 
indices_etiquetas_mostrar = round(linspace(1, num_semanas, num_etiquetas_mostrar)); % Obtener índices de las etiquetas a mostrar
xticks(indices_etiquetas_mostrar); % Establecer las posiciones de las etiquetas a mostrar