% Función de inyección puntual de susceptibles
function S_inj = susceptibles_injection_puntual(t, injection_times, injection_amounts)
    % injection_times: Vector con los tiempos de inyección
    % injection_amounts: Vector con las cantidades a inyectar en cada tiempo correspondiente
    S_inj = 0;  % Inicia la inyección en 0
    % Recorre cada tiempo de inyección
    for i = 1:length(injection_times)
        if abs(t - injection_times(i)) < 1e-3  % Si el tiempo actual coincide con el tiempo de inyección (tolerancia)
            S_inj = injection_amounts(i);  % Inyectar la cantidad correspondiente
            break;
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
    injection_times = params(3:2:end);  % Tiempos de inyección (deben optimizarse)
    injection_amounts = params(4:2:end);  % Cantidades de inyección (deben optimizarse)
    
    % Obtener la inyección de susceptibles en el tiempo t
    S_inj = susceptibles_injection_puntual(t, injection_times, injection_amounts);
    
    % Actualizar el compartimento de susceptibles
    S = S + S_inj;
    
    % Ecuaciones del modelo SEIR
    dSdt = -beta * S * I;
    dIdt = beta * S * I - gamma * I;
    dRdt = gamma * I;
    
    dYdt = [dSdt; dIdt; dRdt];
end

% Optimización con fmincon
% Parametros iniciales: [beta, gamma, T1, S1, T2, S2, ..., Tn, Sn]
params0 = [0.5, 0.1, 30, 50, 60, 40, 90, 30];  % Beta, gamma, tiempos y cantidades iniciales
options = optimoptions('fmincon','Display','iter');
[params_opt, fval] = fmincon(@(params) cost_function(params), params0, [], [], [], [], lb, ub, [], options);
