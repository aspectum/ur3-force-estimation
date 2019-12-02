rosshutdown
close all
clear
clc

%% Loading and defining "functions"

% T = matrix_T();
% 
% idyn = @(q,dq,ddq) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
%     dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6));
% 
% A = matrix_A();
% B = matrix_B();
% 
% fdyn = @(q, dq, tau) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
%     * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));

J = matrix_J();

tau_f = @(q, F) (J(q(1), q(2), q(3), q(4), q(5), q(6)))'*F;

T = matrix_T();

idyn = @(q,dq,ddq, F) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6)) + tau_f(q, F);

A = matrix_A();
B = matrix_B();

fdyn = @(q, dq, tau, F) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
    * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)) - tau_f(q, F));

%% Connecting to robot pc
setenv('ROS_MASTER_URI','http://192.168.1.68:11311')
rosinit('http://192.168.1.68:11311')

%% Creating subscriber
sub = rossubscriber('/subsampled_arm');

%% ukf params
x = zeros(30,1);

L = length(x);

% S_0
initial_covariance = eye(L);
S = chol(initial_covariance);

dt = 1/10;

% noise params

Rv = diag([0.01*ones(1,6), 0.1*ones(1,6), ...
    3.1402, 3.7819, 3.9333, 4.4187, 3.0232, 3.3642, ...
    0.4915, 0.6024, 0.3796, 0.0935, 0.0776, 0.0775, ...
    1*ones(1,6)])^2;    

Rn = diag([0.01*ones(1,6), ...
    0.0124, 0.0163, 0.0170, 0.0121, 0.0134, 0.0120, ... 
    1.8569, 2.1043, 1.3987, 0.0595, 0.0048, 0.0290])^2;


fcn_state = @(x) state_transition(x, fdyn, idyn, dt);
fcn_meas = @(x) measurement(x);

% xv = zeros(L, samples); 

%% receiving first data


data = receive(sub, 1);
stnsec = data.Header.Stamp.Nsec;
stsec = data.Header.Stamp.Sec;
time(1) = 0;
q(1,:) = data.Position;
dq(1,:) = data.Velocity;
torque(1,:) = data.Effort;

for i=2:10
    
    data = receive(sub, 1);
    time(i) = (data.Header.Stamp.Nsec - stnsec)/1e9 + data.Header.Stamp.Sec - stsec;
    q(i,:) = data.Position;
    dq(i,:) = data.Velocity;
    torque(i,:) = data.Effort;
    
end

%% Initializing plots

figure();
tplot = cell(6,1);
for i=1:6
    tplot{i} = subplot(2,3,i);
    ttl = 'Torque ' + string(i);
    plot(time, torque(:,i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time, torque(:,i), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);
end

figure();
qplot = cell(6,1);
for i=1:6
    qplot{i} = subplot(2,3,i);
    ttl = 'Joint position ' + string(i);
    plot(time, q(:,i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time, q(:,i), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);
end

figure();
dqplot = cell(6,1);
for i=1:6
    dqplot{i} = subplot(2,3,i);
    ttl = 'Joint velocity ' + string(i);
    plot(time, dq(:,i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time, dq(:,i), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);
end

figure();
ddqplot = cell(6,1);
for i=1:6
    ddqplot{i} = subplot(2,3,i);
    ttl = 'Joint accel ' + string(i);
    plot(time, dq(:,i), 'Color', [0.6350 0.0780 0.1840]); legend('ukf')
    title(ttl);
end

figure();
fplot = cell(6,1);
for i=1:6
    fplot{i} = subplot(2,3,i);
    ttl = 'End-effector force' + string(i);
    plot(time, torque(:,i), 'Color', [0.6350 0.0780 0.1840]); legend('ukf')
    title(ttl);
end



%%
tic
i = 1;
while true
    
    if mod(i,20) == 0
        
        set(qplot{1}.Children(1), 'xdata', time);
        set(qplot{2}.Children(1), 'xdata', time);
        set(qplot{3}.Children(1), 'xdata', time);
        set(qplot{4}.Children(1), 'xdata', time);
        set(qplot{5}.Children(1), 'xdata', time);
        set(qplot{6}.Children(1), 'xdata', time);
        set(qplot{1}.Children(2), 'xdata', time);
        set(qplot{2}.Children(2), 'xdata', time);
        set(qplot{3}.Children(2), 'xdata', time);
        set(qplot{4}.Children(2), 'xdata', time);
        set(qplot{5}.Children(2), 'xdata', time);
        set(qplot{6}.Children(2), 'xdata', time);
        
        set(qplot{1}.Children(1), 'ydata', xv(1,:));
        set(qplot{2}.Children(1), 'ydata', xv(2,:));
        set(qplot{3}.Children(1), 'ydata', xv(3,:));
        set(qplot{4}.Children(1), 'ydata', xv(4,:));
        set(qplot{5}.Children(1), 'ydata', xv(5,:));
        set(qplot{6}.Children(1), 'ydata', xv(6,:));
        set(qplot{1}.Children(2), 'ydata', q(:,1));
        set(qplot{2}.Children(2), 'ydata', q(:,2));
        set(qplot{3}.Children(2), 'ydata', q(:,3));
        set(qplot{4}.Children(2), 'ydata', q(:,4));
        set(qplot{5}.Children(2), 'ydata', q(:,5));
        set(qplot{6}.Children(2), 'ydata', q(:,6));
        
        set(dqplot{1}.Children(1), 'xdata', time);
        set(dqplot{2}.Children(1), 'xdata', time);
        set(dqplot{3}.Children(1), 'xdata', time);
        set(dqplot{4}.Children(1), 'xdata', time);
        set(dqplot{5}.Children(1), 'xdata', time);
        set(dqplot{6}.Children(1), 'xdata', time);
        set(dqplot{1}.Children(2), 'xdata', time);
        set(dqplot{2}.Children(2), 'xdata', time);
        set(dqplot{3}.Children(2), 'xdata', time);
        set(dqplot{4}.Children(2), 'xdata', time);
        set(dqplot{5}.Children(2), 'xdata', time);
        set(dqplot{6}.Children(2), 'xdata', time);

        set(dqplot{1}.Children(1), 'ydata', xv(7,:));
        set(dqplot{2}.Children(1), 'ydata', xv(8,:));
        set(dqplot{3}.Children(1), 'ydata', xv(9,:));
        set(dqplot{4}.Children(1), 'ydata', xv(10,:));
        set(dqplot{5}.Children(1), 'ydata', xv(11,:));
        set(dqplot{6}.Children(1), 'ydata', xv(12,:));
        set(dqplot{1}.Children(2), 'ydata', dq(:,1));
        set(dqplot{2}.Children(2), 'ydata', dq(:,2));
        set(dqplot{3}.Children(2), 'ydata', dq(:,3));
        set(dqplot{4}.Children(2), 'ydata', dq(:,4));
        set(dqplot{5}.Children(2), 'ydata', dq(:,5));
        set(dqplot{6}.Children(2), 'ydata', dq(:,6));
        
        set(ddqplot{1}.Children(1), 'xdata', time);
        set(ddqplot{2}.Children(1), 'xdata', time);
        set(ddqplot{3}.Children(1), 'xdata', time);
        set(ddqplot{4}.Children(1), 'xdata', time);
        set(ddqplot{5}.Children(1), 'xdata', time);
        set(ddqplot{6}.Children(1), 'xdata', time);

        set(ddqplot{1}.Children(1), 'ydata', xv(13,:));
        set(ddqplot{2}.Children(1), 'ydata', xv(14,:));
        set(ddqplot{3}.Children(1), 'ydata', xv(15,:));
        set(ddqplot{4}.Children(1), 'ydata', xv(16,:));
        set(ddqplot{5}.Children(1), 'ydata', xv(17,:));
        set(ddqplot{6}.Children(1), 'ydata', xv(18,:));
        
        set(tplot{1}.Children(1), 'xdata', time);
        set(tplot{2}.Children(1), 'xdata', time);
        set(tplot{3}.Children(1), 'xdata', time);
        set(tplot{4}.Children(1), 'xdata', time);
        set(tplot{5}.Children(1), 'xdata', time);
        set(tplot{6}.Children(1), 'xdata', time);
        set(tplot{1}.Children(2), 'xdata', time);
        set(tplot{2}.Children(2), 'xdata', time);
        set(tplot{3}.Children(2), 'xdata', time);
        set(tplot{4}.Children(2), 'xdata', time);
        set(tplot{5}.Children(2), 'xdata', time);
        set(tplot{6}.Children(2), 'xdata', time);

        set(tplot{1}.Children(1), 'ydata', xv(19,:));
        set(tplot{2}.Children(1), 'ydata', xv(20,:));
        set(tplot{3}.Children(1), 'ydata', xv(21,:));
        set(tplot{4}.Children(1), 'ydata', xv(22,:));
        set(tplot{5}.Children(1), 'ydata', xv(23,:));
        set(tplot{6}.Children(1), 'ydata', xv(24,:));
        set(tplot{1}.Children(2), 'ydata', torque(:,1));
        set(tplot{2}.Children(2), 'ydata', torque(:,2));
        set(tplot{3}.Children(2), 'ydata', torque(:,3));
        set(tplot{4}.Children(2), 'ydata', torque(:,4));
        set(tplot{5}.Children(2), 'ydata', torque(:,5));
        set(tplot{6}.Children(2), 'ydata', torque(:,6));
        
        set(fplot{1}.Children(1), 'xdata', time);
        set(fplot{2}.Children(1), 'xdata', time);
        set(fplot{3}.Children(1), 'xdata', time);
        set(fplot{4}.Children(1), 'xdata', time);
        set(fplot{5}.Children(1), 'xdata', time);
        set(fplot{6}.Children(1), 'xdata', time);

        set(fplot{1}.Children(1), 'ydata', xv(25,:));
        set(fplot{2}.Children(1), 'ydata', xv(26,:));
        set(fplot{3}.Children(1), 'ydata', xv(27,:));
        set(fplot{4}.Children(1), 'ydata', xv(28,:));
        set(fplot{5}.Children(1), 'ydata', xv(29,:));
        set(fplot{6}.Children(1), 'ydata', xv(30,:));

    end
    
    data = receive(sub, 1);
    time(i) = (data.Header.Stamp.Nsec - stnsec)/1e9 + data.Header.Stamp.Sec - stsec;
    q(i,:) = data.Position;
    dq(i,:) = data.Velocity;
    torque(i,:) = data.Effort;
    z = [q(i,:)'; dq(i,:)'; torque(i,:)'];
    
    [x, S] = sr_ufk(x, S, z, fcn_state, fcn_meas, Rv, Rn);
    
    xv(:,i) = x;
    
%     textprogressbar(100*i/samples);
    i = i+1;
end
toc
