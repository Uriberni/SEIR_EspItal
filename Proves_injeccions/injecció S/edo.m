clear all
close all

% Parámetros del modelo SEIR
beta = 0.3;  % Tasa de transmisión
sigma = 0.1; % Tasa de progresión (de expuesto a infectado)
gamma = 0.1; % Tasa de recuperación
N = 1000;    % Población total

% Condiciones iniciales
S0 = 999;
E0 = 1;
I0 = 0;
R0 = 0;
y0 = [S0; E0; I0; R0];

% Tiempo de simulación
tspan = [0 160];

% Resolver el sistema de ecuaciones diferenciales sin inyección
[t_no_injection, y_no_injection] = ode45(@SEIR_no_injection, tspan, y0);

% Resolver el sistema de ecuaciones diferenciales con inyección
[t_injection, y_injection] = ode45(@SEIR_with_injection, tspan, y0);

% Graficar los resultados
figure;

% Graficar sin inyección
subplot(2,1,1);
plot(t_no_injection, y_no_injection(:,1), 'b', 'DisplayName', 'Susceptible');
hold on;
plot(t_no_injection, y_no_injection(:,2), 'm', 'DisplayName', 'Exposed');
plot(t_no_injection, y_no_injection(:,3), 'r', 'DisplayName', 'Infected');
plot(t_no_injection, y_no_injection(:,4), 'g', 'DisplayName', 'Recovered');
xlabel('Tiempo');
ylabel('Población');
title('Modelo SEIR sin Inyección');
legend;
hold off;

% Graficar con inyección
subplot(2,1,2);
plot(t_injection, y_injection(:,1), 'b', 'DisplayName', 'Susceptible');
hold on;
plot(t_injection, y_injection(:,2), 'm', 'DisplayName', 'Exposed');
plot(t_injection, y_injection(:,3), 'r', 'DisplayName', 'Infected');
plot(t_injection, y_injection(:,4), 'g', 'DisplayName', 'Recovered');
xlabel('Tiempo');
ylabel('Población');
title('Modelo SEIR con Inyección Puntual de Susceptibles');
legend;
hold off;

disp(t);

% Función que describe el modelo SEIR sin inyección
function dydt = SEIR_no_injection(t,y)
    % Parámetros del modelo
    beta = 0.3;  % Tasa de transmisión
    sigma = 0.1; % Tasa de progresión (de expuesto a infectado)
    gamma = 0.1; % Tasa de recuperación
    N = 1000;    % Población total

    S = y(1);
    E = y(2);
    I = y(3);
    R = y(4);
    
    % Ecuaciones diferenciales
    dSdt = -beta * S * I / N;
    dEdt = beta * S * I / N - sigma * E;
    dIdt = sigma * E - gamma * I;
    dRdt = gamma * I;
    
    dydt = [dSdt; dEdt; dIdt; dRdt];
end

% Función que describe el modelo SEIR con inyección puntual
function dydt = SEIR_with_injection(t, y)
    % Parámetros del modelo
    beta = 0.3;  % Tasa de transmisión
    sigma = 0.1; % Tasa de progresión (de expuesto a infectado)
    gamma = 0.1; % Tasa de recuperación
    N = 1000;    % Población total

    S = y(1);
    E = y(2);
    I = y(3);
    R = y(4);
    
    % Inyección puntual de susceptibles en t = 50
    if abs(t - 100) < 1e-3
        S = S + 200000000000; % Añadir 50 susceptibles en t = 50
    end
    
    % Ecuaciones diferenciales
    dSdt = -beta * S * I / N;
    dEdt = beta * S * I / N - sigma * E;
    dIdt = sigma * E - gamma * I;
    dRdt = gamma * I;
    
    dydt = [dSdt; dEdt; dIdt; dRdt];
end

