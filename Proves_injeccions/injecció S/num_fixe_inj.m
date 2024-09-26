% Función de inyección puntual de susceptibles
function S_inj = num_fixe_inj(t, injection_times, injection_amounts)
    S_inj = 0;  % Inicia sin inyecciones
    % Recorre cada tiempo de inyección
    for i = 1:length(injection_times)
        if abs(t - injection_times(i)) < 1e-3 && injection_amounts(i) > 0  % Inyecta solo si la cantidad es > 0
            S_inj = injection_amounts(i);
            break;  % Sale del bucle tras encontrar una inyección válida
        end
    end
end

% Modificar el sistema SEIR para incorporar la inyección puntual
function dYdt = SEIR_with_punctual_injection(t, Y, params)
    S = Y(1);
    I = Y(2);
    R = Y(3);
    
    beta = params(1);
    gamma = params(2);
    
    % Parámetros de las inyecciones
    max_injections = 10;  % Número máximo de inyecciones
    injection_times = params(3:2:(2*max_injections+2));  % Tiempos de inyección
    injection_amounts = params(4:2:(2*max_injections+2));  % Cantidades de inyección
    
    % Obtener la inyección de susceptibles en el tiempo t
    S_inj = num_fixe_inj(t, injection_times, injection_amounts);
    
    % Actualizar el compartimento de susceptibles
    S = S + S_inj;
    
    % Ecuaciones del modelo SEIR
    dSdt = -beta * S * I;
    dIdt = beta * S * I - gamma * I;
    dRdt = gamma * I;
    
    dYdt = [dSdt; dIdt; dRdt];
end

% Función de costo para optimización
function cost = cost_function(params)
    % Simular el modelo con los parámetros dados
    [t, Y] = ode45(@(t, Y) SEIR_with_punctual_injection(t, Y, params), tspan, Y0);
    
    % Datos observados (experimentos)
    I_model = Y(:, 2);  % Infectados modelados
    error = sum((I_model - experimental_data).^2);  % Error cuadrático
    
    % Función de costo es simplemente el error (sin penalización)
    cost = error;
end

% Optimización con fmincon
% Definir el número máximo de inyecciones, por ejemplo 10.


% Parámetros iniciales: [beta, gamma, T1, S1, T2, S2, ..., T10, S10]
params0 = [0.5, 0.1, 30, 50, 60, 0, 90, 0, 120, 0, 150, 0, 180, 0, 210, 0, 240, 0, 270, 0];  % Ejemplo de inicialización

% Definir límites para los parámetros (opcional)
lb = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];  % Límite inferior (por ejemplo, no puede haber tiempos o cantidades negativas)
ub = [1, 1, 300, 100, 300, 100, 300, 100, 300, 100, 300, 100, 300, 100, 300, 100, 300, 100, 300, 100];  % Límite superior (máximos valores posibles)

options = optimoptions('fmincon','Display','iter');
[params_opt, fval] = fmincon(@(params) cost_function(params), params0, [], [], [], [], lb, ub, [], options);
