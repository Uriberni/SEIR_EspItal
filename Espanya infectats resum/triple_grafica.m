clear all 
close all

matriu;

Inf1617=Espanyainfectatsresum.s1617;
Inf1718=Espanyainfectatsresum.s1718;
Inf1819=Espanyainfectatsresum.s1819;
temps=Espanyainfectatsresum.setmanes;

plot(Inf1617);
hold on
plot(Inf1718);
plot(Inf1819);
xlabel('Temps (setmanes)');
ylabel('Casos/10^5 hab');
legend('16/17','17/18','18/19')
title('Resum Espanya')
grid on
hold off


%% Ordenar setmanes 
% Personalizar las etiquetas en el eje x para mostrar el orden real del año
num_semanas = length(temps);
xticks(1:num_semanas); % Establecer los marcadores en las posiciones de las semanas
xticklabels(mod(temps-1, 52) + 1); % Etiquetas personalizadas
xtickangle(90);
% Mostrar solo un número limitado de etiquetas en el eje x para evitar aglomeraciones
num_etiquetas_mostrar = 31; 
indices_etiquetas_mostrar = round(linspace(1, num_semanas, num_etiquetas_mostrar)); % Obtener índices de las etiquetas a mostrar
xticks(indices_etiquetas_mostrar); % Establecer las posiciones de las etiquetas a mostrar