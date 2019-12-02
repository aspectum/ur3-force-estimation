% https://github.com/JJHu1993/sr-ukf
% A bunch of transpose throughout (?)

function [x_k, S_k] = sr_ufk(x_km1, S_km1, z, fcn_state, fcn_meas, Rv, Rn)
% input:
%       x_km1 - (x sub k minus 1) - previous state
%       S_km1 - (S sub k minus 1) - previous S
%       z     - current measurement
%       fcn_state - state transition function handle
%       meas_state - measurement function handle
%       Rv - process noise
%       Rn - measurement noise
% output:
%       x_k - current state estimate
%       S_k - current S estimate

    L = length(x_km1);
    m = length(z);
    
    alpha = 0.001;
    beta = 2;
    lambda = L * (alpha^2 - 1);

    c = L + lambda;
    wm = [lambda/c 0.5/c+zeros(1,2*L)];
    wc = wm;
    wc(1) = wc(1) + 1 - alpha^2 + beta;
    
    eta = sqrt(c);
    
    % ^^ 1.8e-6
    
    X = calc_sigma_points(x_km1, S_km1, eta);           % <<-- 6.3e-6
    
    [x, Xt, Xd, Sx] = ut(fcn_state, X, wm, wc, L, Rv);  % <<-- 0.04
    
    [y, ~, Yd, Sy] = ut(fcn_meas, Xt, wm, wc, m, Rn);   % <<-- 1.3e-4
    
    Pxy = Xd * diag(wc) * Yd';
    
    K = Pxy/Sy/Sy';
    
    x_k = x + K * (z - y);
    
    U = K * Sy';
    
    % ^^ 2.8e-5
    
    for i=1:m
        
        Sx = cholupdate(Sx, U(:,i), '-');
        
    end
    
    % ^^ 1e-4
    
    S_k = Sx;
end