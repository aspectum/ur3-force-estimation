close all
clear
clc;

root = getenv('root_directory');

fr = 1;     % 0 - no friction; 1 - with friction
id = 0;     % identification trajectory: 0, 1 or 2

if fr == 0
    Y = regressor();
    frname = '';
    
    if id == 0
        load(strcat(root, 'data/theta_prbs.mat'));
        
    elseif id == 1
        load(strcat(root, 'data/theta_id1.mat'));
        
    elseif id == 2
        load(strcat(root, 'data/theta_id2.mat'));
        
    end
        
elseif fr == 1
    Y = regressor_fr();
    frname = '_fr';
    
    if id == 0
        load(strcat(root, 'data/theta_prbs_fr.mat'));
        
    elseif id == 1
        load(strcat(root, 'data/theta_id1_fr.mat'));
        
    elseif id == 2
        load(strcat(root, 'data/theta_id2_fr.mat'));
        
    end
end
    

if id == 0
    load(strcat(root, 'data/fprbs.mat'));
    load(strcat(root, 'data/prbs.mat'));

    q = fq;
    dq = fdq;
    ddq = fddq;
    torque = m_torque(21:end-20, :);
    mt = time;
    mtorque = m_torque;

    delta = 0;
    lim = 60;
    
elseif id == 1
    load(strcat(root, 'data/fid1.mat'));
    load(strcat(root, 'data/id1.mat'));
    
    q = mq(21:end-20, :);
    dq = mdq(21:end-20, :);
    ddq = fddq;
    torque = mtorque(21:end-20, :);

    delta = 4.672;
    lim = 20;
    
elseif id == 2
    load(strcat(root, 'data/fid2.mat'));
    load(strcat(root, 'data/id2.mat'));
    
    q = mq(21:end-20, :);
    dq = mdq(21:end-20, :);
    ddq = fddq;
    torque = mtorque(21:end-20, :);

    delta = 4.06;
    lim = 20;
    
end


fitness(q, dq, ddq, theta, torque, Y)

torques = torque_from_regressor(q, dq, ddq, theta, Y);
torques = torques';

%% printing

for i=1:6
    
    
    g = figure();
    plot(mt-delta, mtorque(:,i), ftime-delta, torques(:,i));
    title('Torque medido e calculado')
    ylabel('Torque (N.m)')
    xlabel('Tempo (s)')
    xlim([0 lim]);
    legend('Medido', 'Calculado')
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 2;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = ':';
    poss(2).LineWidth = 1.5;
    poss(2).Color = [0.9290, 0.6940, 0.1250];
    poss(2).LineStyle = '-';
    
    if (i > 3) && (id == 0)
        uistack(poss(2), 'top');
    end
    
    g.Children(1).FontSize = 20;
    g.Children(2).FontSize = 20;
    
    g = tight(g);

    saveas(g, strcat(root, 'Figures/torque_ident', string(id), frname, '_j', string(i), '.png'));
    print(g, strcat(root, 'Figures/torque_ident', string(id), frname, '_j', string(i)), '-dpdf', '-r0');
%     saveas(g, strcat(root, 'Figures/torque_ident_cross20', '_j', string(i), '.png'));
%     print(g, strcat(root, 'Figures/torque_ident_cross20', '_j', string(i)), '-dpdf', '-r0');
    
end