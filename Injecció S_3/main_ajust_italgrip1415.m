close all
clear all
x0=[0.90,0.79,0.45,100,100,100,70];
%x0=[0.90,0.79,0.45,600,400,470,90];
fun = @(x) italgrip1415(x(1),x(2),x(3),x(4:7));

% limits inferiors variables
llindarslb=[0.70,0.4,0.15];
Sinjlb=[50,50,50,20];
%llindarslb=[0.90,0.78,0.45];
%Sinjlb=[600,350,450,80];

%limits superiors variables
llindarsub=[0.99,0.85,0.7];
Sinjub=[700,500,500,150];
%llindarsub=[0.90,0.8,0.49];
%Sinjub=[680,500,500,120];

%procés optimització
lb=[llindarslb,Sinjlb];
ub=[llindarsub,Sinjub];
nvars=7;
% Crear les opcions de l'algoritme genètic
options = optimoptions('ga', ...
    'PopulationSize', 200, ...         % Augmenta la mida de la població per a una major exploració
    'MaxGenerations', 500, ...         % Més generacions per buscar millors solucions
    'MutationFcn', @mutationadaptfeasible, ...  % Mutació adaptada a les restriccions
    'CrossoverFraction', 0.8, ...      % Fracció de creuament per permetre una bona combinació de solucions
    'SelectionFcn', @selectiontournament, ... % Selecció de torneig per escollir els millors individus
    'EliteCount', 5, ...               % Assegura que els millors individus es mantinguin en cada generació
    'UseParallel', true, ...           % Habilitar el processament paral·lel per accelerar l'execució
    'MaxTime', 1200, ...               % Limitar el temps d'execució a 20 minuts
    'Display', 'iter', ...             % Mostrar informació en cada iteració
    'PlotFcn', {@gaplotbestf, @gaplotbestindiv, @gaplotdistance, @gaplotrange}); % Mostrar la millor funció objectiu en cada generació

%[x,Error] = fmincon(fun,x0,[],[],[],[],lb,ub);

[x, Error] = ga(fun, nvars, A, b, [], [], lb, ub,[],options);


%[x,Error] = fminsearch(fun,x0);

disp(x);
disp(Error);
[Error,Nous_agru,Inf,Nous_agru2,peak_day,a,sinj1,S,Nous_set,Errortot,Errortotn,I1,I2,I3]=italgrip1415(x(1),x(2),x(3),x(4:7));


italgrip_1415(x(1),x(2),x(3),x(4:7));
%%
figure;
% Ajustar el model lineal
mdl = fitlm(Inf,Nous_set);
coeffs = mdl.Coefficients;
c=coeffs.Estimate(1);
b = coeffs.Estimate(2);
% Veure els resultats de la regressió
disp(mdl);
plot(mdl);
equacio = ['y = ' num2str(c) ' + ' num2str(b) ' · x'];
text(min(Inf)+100,max(Nous_set)-50,equacio, 'FontSize', 10, 'Color', 'r', 'BackgroundColor', 'w');
grid on
ylim([0,inf]);
xlabel('Dades experimentals');
ylabel('Dades del model');
legend('Data','Fit','Confidence Bounds 95%');
title('Recta de regressió Itàlia 14-15')
% Obtenir el p-valor per al terme independent (a) i el pendent (b)
% Test del terme independent (a)
p_value_c = coeffs.pValue(1);
if p_value_c > 0.05
    disp('No es pot rebutjar la hipòtesi que el terme independent és 0');
else
    disp('El terme independent és significativament diferent de 0');
end
% Test del pendent (b)
ci_b = coefCI(mdl, 0.05);  % Interval de confiança per al pendent
if ci_b(2,1) <= 1 && ci_b(2,2) >= 1
    disp('El pendent no és significativament diferent de 1');
    fprintf('Interval de confiança al 95%% és de %.4f a %.4f\n', ci_b(2,1), ci_b(2,2));
else
    disp('El pendent és significativament diferent de 1');
end