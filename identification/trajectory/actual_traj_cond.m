clear
clc

Y = regressor_fr();

% load("../../experiment/fid1.mat");
load("../../experiment/fid2.mat");
% load("../../experiment/fdata.mat");


% load("../../experiment/id1.mat")
load("../../experiment/id2.mat")
% load("../prbs.mat")

% q = fq;
% dq = fdq;
% ddq = fddq;
% torque = m_torque(21:end-20, :);
% mt = time;
% mtorque = m_torque;

q = mq(21:end-20, :);
dq = mdq(21:end-20, :);
ddq = fddq;
torque = mtorque(21:end-20, :);

criterion(q, dq, ddq, Y, 'cond')