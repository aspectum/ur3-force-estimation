%% BIG PLOTS

x_hat = xv;
%% Torque
d = 18;

figure();

for i=1:6
    subplot(2,3,i);
    ttl = 'torque ' + string(i);
    plot(time(1:length(x_hat)), torque_with_force_noisy(1:length(x_hat), i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time(1:length(x_hat))-0.008, x_hat(d + i,:), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);

end

%% pos
d = 0;

figure();

for i=1:6
    subplot(2,3,i);
    ttl = 'pos ' + string(i);
    plot(time(1:length(x_hat)), q(1:length(x_hat), i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time(1:length(x_hat))-0.008, x_hat(d + i,:), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);

end

%% vel
d = 6;

figure();

for i=1:6
    subplot(2,3,i);
    ttl = 'vel ' + string(i);
    plot(time(1:length(x_hat)), d_q(1:length(x_hat), i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time(1:length(x_hat))-0.008, x_hat(d + i,:), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);

end

%% acc
d = 12;

figure();

for i=1:6
    subplot(2,3,i);
    ttl = 'accel ' + string(i);
    plot(time(1:length(x_hat)), d_d_q(1:length(x_hat), i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time(1:length(x_hat))-0.008, x_hat(d + i,:), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);

end

%% force

d = 24;

figure();

for i=1:6
    subplot(2,3,i);
    ttl = 'force ' + string(i);
    plot(time(1:length(x_hat)), F_noisy(1:length(x_hat), i), 'Color', [0.9290, 0.6940, 0.1250])
    hold on
    plot(time(1:length(x_hat))-0.008, x_hat(d + i,:), 'Color', [0.6350 0.0780 0.1840], 'LineStyle', ':'); legend('meas', 'ukf')
    hold off
    title(ttl);

end

% %% Plot all
% n = 19;
% figure()
% plot(time(1:length(x_hat))-0.008, x_hat(n:(n+5),:), time(1:length(x_hat)), m_torque(1:length(x_hat), :)); legend('meas', 'ukf')
% 
% %% Plot single torque
% n = 2;
% d = 18;
% figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), m_torque(1:length(x_hat), n)); legend('meas', 'ukf')
% % plot(time, m_torque(:, n), time-0.008, x_hat(d + n,1:end-1)); legend('meas', 'ukf')
% 
% %% Plot single pos
% n = 6;
% d = 0;
% figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), q(1:length(x_hat), n)); legend('meas', 'ukf')
% 
% %% Plot single vel
% n = 5;
% d = 6;
% figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), d_q(1:length(x_hat), n)); legend('meas', 'ukf')
% % plot(time-0.008, x_hat(d + n,1:end-1), time, d_q(:, n)); legend('meas', 'ukf')
% 
% %% Plot single acc
% n = 4;
% d = 12;
% figure()
% plot(time(1:length(x_hat))-0.008, x_hat(d + n,:), time(1:length(x_hat)), d_d_q(1:length(x_hat), n)); legend('meas', 'ukf')
% % plot(time-0.008, x_hat(d + n,1:end-1), time, d_d_q(:, n)); legend('meas', 'ukf')
% 
% %% Plot force
% n = 26;
% figure()
% plot(time(1:length(x_hat)), x_hat(n,:)); legend('force')