close all
clear all


x0=[0.9,0.65,0.2,20,20,20,10];
%x0=[0.99,0.75,0.45,100,290,160,0];
fun = @(x)espgrip1617_S(x(1),x(2),x(3),x(4:7));

% limits inferiors variables
llindarslb=[0.7,0.6,0.4];
Sinjlb=[0,0,0,0];
%llindarslb=[0.99,0.75,0.45];
%Sinjlb=[100,290,160,0];

%limits superiors variables
llindarsub=[1,0.85,0.65];
Sinjub=[500,450,450,40];
%llindarsub=[0.99,0.75,0.49];
%Sinjub=[100,290,160,0];

%procés optimització
lb=[llindarslb,Sinjlb];
ub=[llindarsub,Sinjub];
%nonlcon = @nonlinConstraints;
%options = optimoptions('fmincon', 'Algorithm', 'interior-point', 'Display', 'iter');
nvars=7;
options = optimoptions('ga', ...
    'PopulationSize', 200, ...         % Augmenta la mida de la població per a una major exploració
    'MaxGenerations', 500, ...         % Més generacions per buscar millors solucions
    'MutationFcn', @mutationadaptfeasible, ...  % Mutació gaussiana per a una millor cerca local
    'CrossoverFraction', 0.8, ...      % Fracció de creuament per permetre una bona combinació de solucions
    'SelectionFcn', @selectiontournament, ... % Selecció de torneig per escollir els millors individus
    'EliteCount', 5, ...               % Assegura que els millors individus es mantinguin en cada generació
    'UseParallel', true, ...           % Habilitar el processament paral·lel per accelerar l'execució
    'MaxTime', 1200, ...               % Limitar el temps d'execució a 30 minuts
    'Display', 'iter', ...             % Mostrar informació en cada iteració
    'PlotFcn', {@gaplotbestf, @gaplotbestindiv, @gaplotdistance, @gaplotrange}); % Mostrar la millor funció objectiu en cada generació

%[x,Error] = particleswarm(fun,nvars,lb,ub);
[x, Error] = ga(fun, nvars, [], [], [], [], lb, ub, [],options);
%[x,Error] = fminsearch(fun,x0);
disp(x);
disp(Error);
[Error,Nous_agru,Inf,Nous_agru2,peak_day,a,sinj1,S,Nous_set]=espgrip1617_S(x(1),x(2),x(3),x(4:7));

espgrip_1617_S(x(1),x(2),x(3),x(4:7));
%%
% Ajustar el model lineal
mdl = fitlm(Inf,Nous_set);
coeffs = mdl.Coefficients;
c=coeffs.Estimate(1);
b = coeffs.Estimate(2);
% Veure els resultats de la regressió
disp(mdl);
plot(mdl);
equacio = ['y = ' num2str(c) ' + ' num2str(b) ' · x'];
text(min(Inf)+100,max(Nous_set),equacio, 'FontSize', 10, 'Color', 'r', 'BackgroundColor', 'w');
grid on
ylim([0,inf]);
xlabel('Dades experimentals');
ylabel('Dades del model');
legend('Data','Fit','Confidence Bounds 95%');
title('Recta de regressió Itàlia 16-17')
% Obtenir el p-valor per al terme independent (a) i el pendent (b)
% Test del terme independent (a)
p_value_a = coeffs.pValue(1);
if p_value_a > 0.05
    disp('No es pot rebutjar la hipòtesi que el terme independent és 0');
else
    disp('El terme independent és significativament diferent de 0');
end
% Test del pendent (b)
ci_b = coefCI(mdl, 0.05);  % Interval de confiança per al pendent
if ci_b(2,1) <= 1 && ci_b(2,2) >= 1
    disp('El pendent no és significativament diferent de 1');
else
    disp('El pendent és significativament diferent de 1');
end
