close all
clear
clc

root = getenv('root_directory');
load(strcat(root, 'data/srukf_plain_prbs.mat'));
core_name = 'srukf_plain_prbs_j';
root = getenv('root_directory');    % There's another 'root' in the file being loaded
%%  trajectories 1 and 2

% time = mt(1:length(xv)) - mt(1);
% q = mq(1:length(xv),:);
% dq = mdq(1:length(xv),:);
% torque = mtorque(1:length(xv),:);

%% trajectory 0

time = time(1:length(xv));
q = q(1:length(xv),:);
dq = d_q(1:length(xv),:);
torque = m_torque(1:length(xv),:);
% torque = torque_with_force_noisy(1:length(xv),:);

%% Torque

for i=1:6
    
    
    g = figure();
    plot(time, torque(:,i), time, xv(18+i,:));
    title('Torque medido e estimado')
    ylabel('Torque (N.m)')
    xlabel('Tempo (s)')
    legend('Medido', 'Estimado')
    xlim([0 30])
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    poss(2).LineWidth = 2;
    poss(2).Color = [0.9290, 0.6940, 0.1250];
    poss(2).LineStyle = '-';
    
%     if i<4
%     uistack(poss(2), 'top');
%     end
    
    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);
    fullname = strcat(root, 'Figures/torque_', core_name, string(i), '.png');
    saveas(g, fullname);
    partialname = strcat(root, 'Figures/torque_', core_name, string(i));
    print(g, partialname, '-dpdf', '-r0');
    
end

%% pos

for i=1:6
    
    g = figure();
    plot(time, q(:,i), time, xv(i,:));
    title('Posição medida e estimada')
    ylabel('Posição (rad)')
    xlabel('Tempo (s)')
    legend('Medido', 'Estimado')
    xlim([0 30])
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    poss(2).LineWidth = 2;
    poss(2).Color = [0.9290, 0.6940, 0.1250];
    poss(2).LineStyle = '-';
    
    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);
    fullname = strcat(root, 'Figures/pos_', core_name, string(i), '.png');
    saveas(g, fullname);
    partialname = strcat(root, 'Figures/pos_', core_name, string(i));
    print(g, partialname, '-dpdf', '-r0');
    
end

%% vel

for i=1:6
    
    g = figure();
    plot(time, dq(:,i), time, xv(6+i,:));
    title('Velocidade medida e estimada')
    ylabel('Velocidade (rad/s)')
    xlabel('Tempo (s)')
    legend('Medido', 'Estimado')
    xlim([0 30])
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    poss(2).LineWidth = 2;
    poss(2).Color = [0.9290, 0.6940, 0.1250];
    poss(2).LineStyle = '-';
    
    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);
    fullname = strcat(root, 'Figures/vel_', core_name, string(i), '.png');
    saveas(g, fullname);
    partialname = strcat(root, 'Figures/vel_', core_name, string(i));
    print(g, partialname, '-dpdf', '-r0');
    
end

%% acc

load(strcat(root, 'data/fprbs.mat'));

for i=1:6
    
    g = figure();
%     plot(ftime-mt(1), fddq(:,i));
    plot(ftime, fddq(:,i));
    hold on
    plot(time, xv(12+i,:));
%     title('Aceleração estimada')
    title('Aceleração estimada e derivada')
    ylabel('Aceleração (rad/s^2)')
    xlabel('Tempo (s)')
%     ylim([-7.5 7.5])
%     xlim([5 7.5])
    ylim([-15 15])
    xlim([0 30])
%     legend('Estimado')
    legend('Derivado', 'Estimado')
    
    poss = g.Children(2).Children;
%     poss(1).LineWidth = 2;
%     poss(1).Color = [0.4940, 0.1840, 0.5560];
%     poss(1).LineStyle = ':';
    
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    poss(2).LineWidth = 2;
    poss(2).Color = [0.8500, 0.3250, 0.0980];
    poss(2).LineStyle = '-';
    
    uistack(poss(2), 'top');

    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);
    fullname = strcat(root, 'Figures/acc_', core_name, string(i), '.png');
    saveas(g, fullname);
    partialname = strcat(root, 'Figures/acc_', core_name, string(i));
    print(g, partialname, '-dpdf', '-r0');
    
end

%% force


for i=1:6
    
    g = figure();
%     plot(time, F_noisy(1:length(time),i));
%     hold on
    plot(time, xv(24+i,:));
%     title('Esforço estimado e simulado')
    title('Esforço estimado')
    if i <= 3
        ylabel('Força (N)')
    else
        ylabel('Momento (N.m)')
    end
    xlabel('Tempo (s)')
    legend('Estimado')
%     legend('Simulado', 'Estimado')
    xlim([0 30])
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    
%     poss(1).LineWidth = 2;
%     poss(1).Color = [0.4940, 0.1840, 0.5560];
%     poss(1).LineStyle = ':';
%     poss(2).LineWidth = 2;
%     poss(2).Color = [0.8500, 0.3250, 0.0980];
%     poss(2).LineStyle = '-';

    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);
    fullname = strcat(root, 'Figures/force_', core_name, string(i), '.png');
    saveas(g, fullname);
    partialname = strcat(root, 'Figures/force_', core_name, string(i));
    print(g, partialname, '-dpdf', '-r0');

    
end



