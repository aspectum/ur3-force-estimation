clear
clc

%%
load('xs_park/done_1.mat');

%%
fs = 50;
duration = 10;

dt = 1/fs;
samples = duration * fs;

q = zeros(samples, 6);
dq = zeros(samples, 6);
ddq = zeros(samples, 6);

for i=1:6

    idx = 5*(i-1)+1;
    [q(:,i), dq(:,i), ddq(:,i)] = traj_park_jnt(x(idx:idx+4), samples, dt);

end

q(:,2) = q(:,2) - pi/2;
q(:,4) = q(:,4) - pi/2;
    
%%

bigq = [q; q; q; q];
bigdq = [dq; dq; dq; dq];
bigddq = [ddq; ddq; ddq; ddq];
time = dt:dt:40;
load("../../experiment/fid1.mat");

%%

pos = figure();
plot(time, bigq(:,1), ftime-4.672, fq(:,1)); legend('Trajetória planejada', 'Trajetória executada')
xlim([0, 40])
grid on
ylabel('Posição da junta (rad)')
xlabel('Tempo (s)')
title('Divergência entre a trajetória planejada e a executada')

%%

vel = figure()
plot(time, bigdq(:,1), ftime-4.672, fdq(:,1)); legend('Trajetória planejada', 'Trajetória executada')
xlim([0, 40])
grid on
ylabel('Velocidade da junta (rad/s)')
xlabel('Tempo (s)')
title('Divergência entre a trajetória planejada e a executada')

%%

acc = figure();
plot(time, bigddq(:,1), ftime-4.672, fddq(:,1)); legend('Trajetória planejada', 'Trajetória executada')
xlim([0, 40])
grid on
ylabel('Aceleração da junta (rad/s^2)')
xlabel('Tempo (s)')
title('Divergência entre a trajetória planejada e a executada')

%%

poss = pos.Children(2).Children;
poss(1).LineWidth = 1.5;
poss(1).Color = [0.9290, 0.6940, 0.1250];
poss(1).LineStyle = '-';
poss(2).LineWidth = 1.5;
poss(2).Color = [0.4940, 0.1840, 0.5560];
poss(2).LineStyle = '-';
pos = tight(pos);

vell = vel.Children(2).Children;
vell(1).LineWidth = 1.5;
vell(1).Color = [0.9290, 0.6940, 0.1250];
vell(1).LineStyle = '-';
vell(2).LineWidth = 1.5;
vell(2).Color = [0.4940, 0.1840, 0.5560];
vell(2).LineStyle = '-';
vel = tight(vel);

accc = acc.Children(2).Children;
accc(1).LineWidth = 1.5;
accc(1).Color = [0.9290, 0.6940, 0.1250];
accc(1).LineStyle = '-';
accc(2).LineWidth = 1.5;
accc(2).Color = [0.4940, 0.1840, 0.5560];
accc(2).LineStyle = '-';
acc = tight(acc);

saveas(pos, '/home/pedro/tcc-tmp-master/my_ur3_model/Figures/divergence1_pos.png');
saveas(vel, '/home/pedro/tcc-tmp-master/my_ur3_model/Figures/divergence1_vel.png');
saveas(acc, '/home/pedro/tcc-tmp-master/my_ur3_model/Figures/divergence1_acc.png');
