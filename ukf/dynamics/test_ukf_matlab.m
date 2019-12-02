clear all, clc

%% Loading and defining "functions"

load('theta_prbs_fr.mat');
% load('theta_id2_fr.mat');

Y = regressor_fr();

% Colocar a FORÇA
tau_func = @(q,dq,ddq) Y(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6)) * theta;
% timeit = 4.2869e-04

A = matrixA(theta);
B = matrixB(theta);

% Colocar a FORÇA
dotdotq = @(q, dq, tau) (B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
    \ (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));
% timeit inv = 4.8069e-04
% timeit A\B = 4.9269e-04

%% Validation

q = 10*randn(6,1);
dq = 10*randn(6,1);
ddq_in = 10*randn(6,1);
tau = tau_func(q, dq, ddq_in);
ddq_out = dotdotq(q, dq, tau);
ddq_in - ddq_out

%% Timing

N = 1000;

tic
for i=1:N
    q = 10*randn(6,1);
    dq = 10*randn(6,1);
    ddq_in = 10*randn(6,1);
    tau_func(q, dq, ddq_in);
end
toc/N

%%

N = 1000;

tic
for i=1:N
    q = 10*randn(6,1);
    dq = 10*randn(6,1);
    tau = 10*randn(6,1);
    dotdotq(q, dq, tau);
end
toc/N
