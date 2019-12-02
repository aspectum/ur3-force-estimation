clear
clc

root = getenv('root_directory');

%% Loading and defining "functions"

load(strcat(root, 'data/theta_id1_frmat'));

J = matrixJ();

tau_f = @(q, F) (J(q(1), q(2), q(3), q(4), q(5), q(6)))'*F;

Y = regressor_fr();

idyn = @(q,dq,ddq, F) Y(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6))*theta + tau_f(q, F);

A = matrixA(theta);
B = matrixB(theta);

fdyn = @(q, dq, tau, F) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
    * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)) - tau_f(q, F));

%%

load(strcat(root, 'data/id1.mat'));
load(strcat(root, 'data/t_w_f_1_id1.mat'));

% trying to use [q, dq, ddq, tau] state

% x_hat_0
% initial_state_guess = [q(1,:)'; d_q(1,:)'; d_d_q(1,:)'; m_torque(1,:)'; zeros(6,1)];
x = zeros(30,1);

L = length(x);

% S_0
initial_covariance = eye(L);
S = chol(initial_covariance);

% samples = length(mt);
% samples = floor(length(time)/2);
samples = 3850;
dt = 1/50;

% noise params
% Rv = 0.01*eye(L); % process noise
% Rv(16:18,16:18) = 100*eye(3);
% Rv(22:24,22:24) = 100*eye(3);
% Rn = 0.1*eye(L); % sensor noise
% Rn(13:24,13:24) = 10*eye(12);

% Rv = diag([0.01*ones(1,6), 0.1*ones(1,6), ...
%     3.1402, 3.7819, 3.9333, 4.4187, 3.0232, 3.3642, ...
%     0.4915, 0.6024, 0.3796, 0.0935, 0.0776, 0.0775, ...
%     1*ones(1,6)])^2;    

% Rv = diag([0.01*ones(1,6), 0.1*ones(1,6), ...
%     85.9807, 175.8031, 196.3371, 647.5734, 14.7222, 113.2359, ...
%     0.4910, 0.6024, 0.3796, 0.0935, 0.0777, 0.0779, ...
%     1*ones(1,6)])^2;   

Rv = diag([0.01*ones(1,6), 0.1*ones(1,6), ...
    85.9807, 175.8031, 196.3371, 647.5734, 14.7222, 113.2359, ...
    7.5010, 21.4394, 15.4028, 2.7559, 2.5441, 2.3729, ...
    1*ones(1,6)])^2;   

% Rn = diag([0.01*ones(1,6), ...
%     0.0124, 0.0163, 0.0170, 0.0121, 0.0134, 0.0120, ... 
%     1.8569, 2.1043, 1.3987, 0.0595, 0.0048, 0.0290])^2;

Rn = diag([0.01*ones(1,6), ...
    0.0124, 0.0163, 0.0170, 0.0121, 0.0134, 0.0120, ... 
    1.0374, 1.3807, 0.9093, 0.3613, 0.3475    0.2289])^2;


fcn_state = @(x) state_transition(x, fdyn, idyn, dt);
fcn_meas = @(x) measurement(x);

xv = zeros(L, samples); 

tic
textprogressbar('applying UKF: ');
for i=1:samples
    
%     z = [q(i,:)'; d_q(i,:)'; m_torque(i,:)'];
%     z = [q(i,:)'; d_q(i,:)'; torque_with_force_noisy(i,:)'];
    z = [mq(i,:)'; mdq(i,:)'; mtorque(i,:)'];
    z = [mq(i,:)'; mdq(i,:)'; torque_with_force_noisy(i,:)'];
    
    [x, S] = sr_ufk(x, S, z, fcn_state, fcn_meas, Rv, Rn);
    
    xv(:,i) = x;
    
    textprogressbar(100*i/samples);
    
end
toc
toc/i
% 0.0599
save(strcat(root, 'data/srukf_f_1_id1.mat'));