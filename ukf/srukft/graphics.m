%% BIG PLOTS

x_hat = xv;
%% Torque
d = 18;

figure();

a = cell(6);

for i=1:6
    a{i} = subplot(2,3,i);
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

