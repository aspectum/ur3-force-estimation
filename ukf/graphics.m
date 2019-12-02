%% Plot all
n = 19;
figure()
plot(time(1:length(x_hat))-0.008, x_hat(n:(n+5),:), time(1:length(x_hat)), m_torque(1:length(x_hat), :)); legend('ukf', 'meas')

%% Plot single torque
n = 5;
d = 18;
figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), m_torque(1:length(x_hat), n)); legend('ukf', 'meas')
plot(time, m_torque(:, n), time-0.008, x_hat(d + n,1:end-1)); legend('meas', 'ukf')

%% Plot single vel
n = 4;
d = 6;
figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), d_q(1:length(x_hat), n)); legend('ukf', 'meas')
plot(time-0.008, x_hat(d + n,1:end-1), time, d_q(:, n)); legend('ukf', 'meas')

%% Plot single acc
n = 2;
d = 12;
figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), d_d_q(1:length(x_hat), n)); legend('ukf', 'meas')
plot(time-0.008, x_hat(d + n,1:end-1), time, d_d_q(:, n)); legend('ukf', 'meas')

%% Plot force
n = 26;
figure()
plot(time(1:length(x_hat)), x_hat(n,:)); legend('force')