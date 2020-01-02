clear
clc

%% Loading and defining "functions"

T = matrix_T();

idyn = @(q,dq,ddq) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6));

A = matrix_A();
B = matrix_B();

fdyn = @(q, dq, tau) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
    * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));

%%

load('data.mat');

% trying to use [q, dq, ddq, tau] state

% x_hat_0
initial_state_guess = [q(1,:)'; d_q(1,:)'; d_d_q(1,:)'; m_torque(1,:)'];
x_hat = initial_state_guess;

L = length(initial_state_guess);

% P_0
initial_covariance = eye(L);
P = {initial_covariance};

samples = floor(length(time)/4);
dt = 0.008;

% ukf parameters
alpha = 0.1;
beta = 2;
kappa = 3;
lambda = alpha^2 * (L + kappa) - L;
% lambda = 3 - L;

chi_kminus = zeros(L,2*L+1);
chi_k = zeros(L,2*L+1);

weights_mean = zeros(2*L+1,1);
weights_mean(1) = lambda/(L+lambda);
weights_mean(2:end) = 1/(2*(L+lambda));
weights_cov = weights_mean;
weights_cov(1) = weights_cov(1) + 1 - alpha^2 + beta;

% noise params
Rv = 0.01*eye(L); % process noise
Rv(16:18,16:18) = 10*eye(3);
Rv(22:24,22:24) = 100*eye(3);
Rn = 0.1*eye(L); % sensor noise
Rn(13:24,13:24) = 10*eye(12);

tic
textprogressbar('applying UKF: ');
for i=1:samples
     
    %%%%%%% Calculating sigma points %%%%%%%
    chi_kminus = calc_sigma_points(x_hat(:,end), P{end}, lambda);
    % 9.7267e-04
    
    %%%%%%% Time update (predict?) %%%%%%%
    % might be ineficient, since I'm calling the function many times
    for j=1:(2*L+1)
        chi_k(:,j) = state_transition(chi_kminus(:,j), fdyn, idyn, dt);
    end
    
    % this should be a weighted average
    x_hat_pred = chi_k * weights_mean;
    
    % gotta optimize this
    P_k_pred = Rv;
    for j=1:(2*L+1)
        P_k_pred = P_k_pred + weights_cov(j)*((chi_k(:,j) - x_hat_pred)*(chi_k(:,j) - x_hat_pred)');
    end
    
    Y_k = zeros(size(chi_k));
    % might be ineficient, since I'm calling the function many times
    for j=1:(2*L+1)
        Y_k(:,j) = measurement(chi_k(:,j));
    end
    
    % this should be a weighted average
    y_hat_pred = Y_k * weights_mean;
    
    %%%%%%% Measurement update (correct?) %%%%%%%
    
    Pyy = Rn;
    % to be optimized
    for j=1:(2*L+1)
        Pyy = Pyy + weights_cov(j)*((Y_k(:,j) - y_hat_pred)*(Y_k(:,j) - y_hat_pred)');
    end
    
    % calculate these lengths outside loop?
    Pxy = zeros(length(x_hat_pred), length(y_hat_pred));
    % to be optimized
    for j=1:(2*L+1)
        Pxy = Pxy + weights_cov(j)*((chi_k(:,j) - x_hat_pred)*(Y_k(:,j) - y_hat_pred)');
    end
    
    % Kalman gain
    K = Pxy * inv(Pyy);
    % K = Pxy / Pyy;
    
    % ATTENTION!!!
    y_k = [q(i,:)'; d_q(i,:)'; d_d_q(i,:)'; m_torque(i,:)'];
    
    x_hat = [x_hat, x_hat_pred + K*(y_k - y_hat_pred)];
    P_k = P_k_pred - K*Pyy*K';
%     P_k = chol(P_k)' * chol(P_k); % numerical stability ???
    P(end+1) = {P_k};
    
    textprogressbar(100*i/samples);
    
end
toc