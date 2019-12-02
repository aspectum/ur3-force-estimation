clear
clc;

Y = regressor_fr();
sz_regressor = size(Y(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
n_params = sz_regressor(2)

load("../experiment/fid1.mat");
% load("../experiment/fid2.mat");
% load("../experiment/fdata.mat")

q = fq;
dq = fdq;
ddq = fddq;
torque = ftorque;

% q = mq(21:end-20, :);
% dq = mdq(21:end-20, :);
% ddq = fddq;
% torque = mtorque(21:end-20, :);

% q = q;
% dq = d_q;
% ddq = d_d_q;
% torque = m_torque;


n_points = length(ddq)

Gamma = reshape(torque', [n_points*6 1]);
Phi = zeros(n_points*6, n_params);

textprogressbar('calculating Phi: ');
for i=1:n_points
   
    Yi = Y(q(i,1), q(i,2), q(i,3), q(i,4), q(i,5), q(i,6), dq(i,1), dq(i,2), dq(i,3), dq(i,4), dq(i,5), dq(i,6), ddq(i,1), ddq(i,2), ddq(i,3), ddq(i,4), ddq(i,5), ddq(i,6));
    idx = 6*(i-1) + 1;
    Phi(idx:idx+5, :) = Yi;
    textprogressbar(100*i/n_points);
    
end
textprogressbar('done');

theta = inv(Phi' * Phi) * Phi' * Gamma;

fitness(q, dq, ddq, theta, torque, Y)

sigma_rho = norm(Gamma - Phi*theta)/(size(Phi,1) - size(Phi,2));
theta_cov = sigma_rho^2 * inv(Phi' * Phi);

% save('theta_id1_fr.mat', 'theta', 'theta_cov');
% save('theta_id2_fr.mat', 'theta', 'theta_cov');
% save('theta_prbs.mat', 'theta', 'theta_cov');
