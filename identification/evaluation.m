close all
clear
clc;

% Y = regressor();
% load('theta_prbs.mat');
% load('theta_id1.mat');
% load('theta_id2.mat');

Y = regressor_fr();
% load('theta_id1_fr.mat');
% load('theta_id2_fr.mat');
% load('theta_prbs_fr.mat');
load('supertheta.mat');


% load("../experiment/fid1.mat");
% load("../experiment/fid2.mat");
load("../experiment/fdata.mat");


% load("../experiment/id1.mat")
% load("../experiment/id2.mat")
load("prbs.mat")

q = fq;
dq = fdq;
ddq = fddq;
torque = m_torque(21:end-20, :);
mt = time;
mtorque = m_torque;

% q = mq(21:end-20, :);
% dq = mdq(21:end-20, :);
% ddq = fddq;
% torque = mtorque(21:end-20, :);



fitness(q, dq, ddq, theta, torque, Y)

torques = torque_from_regressor(q, dq, ddq, theta, Y);
torques = torques';

%%

delta = 0;
% delta = 4.672;
% delta = 4.06;

for i=1:6
    
    
    g = figure();
    plot(mt-delta, mtorque(:,i), ftime-delta, torques(:,i));
    title('Torque medido e calculado para trajetória de identificação')
    ylabel('Torque (N.m)')
    xlabel('Tempo (s)')
    xlim([0 20]);
    legend('Medido', 'Calculado')
    
    poss = g.Children(2).Children;
    poss(1).LineWidth = 1.5;
    poss(1).Color = [0.4940, 0.1840, 0.5560];
    poss(1).LineStyle = '-';
    poss(2).LineWidth = 1.5;
    poss(2).Color = [0.9290, 0.6940, 0.1250];
    poss(2).LineStyle = '-';
    
    g = tight(g);
%     fname = '/home/pedro/tcc-tmp-master/my_ur3_model/Figures/torque_ident_cross02_j' + string(i) + '.png';
%     saveas(g, fname);
    
end