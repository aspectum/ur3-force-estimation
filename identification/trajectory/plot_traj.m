traj = 2;       % 1 - fourier; 2 - park

if traj == 1
    
    N = 5;
    q0 = [0; -pi/2; 0; -pi/2; 0; 0];
    fs = 125;
    duration = 10;

    dt = 1/fs;
    samples = duration * fs;
    time = dt:dt:duration;

    a = reshape(x(1:N*6), N, 6);
    b = reshape(x(N*6+1:end-1), N, 6);
    w = 2*pi/10;

    [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt);

end

if traj == 2
    
    fs = 50;
    duration = 10;
    
    dt = 1/fs;
    samples = duration * fs;
    time = dt:dt:duration;
    
    q = zeros(samples, 6);
    dq = zeros(samples, 6);
    ddq = zeros(samples, 6);
    
    for i=1:6
        
        idx = 5*(i-1)+1;
        [q(:,i), dq(:,i), ddq(:,i)] = traj_park_jnt(x(idx:idx+4), samples, dt);
        
    end
    
    q(:,2) = q(:,2) - pi/2;
    q(:,4) = q(:,4) - pi/2;
    
end
%%

root = getenv('root_directory');

% time = ftime;
% q = fq;
% dq = fdq;
% ddq = fddq;

pos = figure(); plot(time,q); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Posições das juntas (rad)'); xlabel('Tempo (s)'); grid on;
vel = figure(); plot(time,dq); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Velocidades das juntas (rad/s)'); xlabel('Tempo (s)'); grid on;
acc = figure(); plot(time,ddq); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Acelerações das juntas (rad/s^2)'); xlabel('Tempo (s)'); grid on;

pos.Children(1).FontSize = 20;
pos.Children(2).FontSize = 20;

vel.Children(1).FontSize = 20;
vel.Children(2).FontSize = 20;

acc.Children(1).FontSize = 20;
acc.Children(2).FontSize = 20;

colors = linspecer(6, 'qualitative');

poss = pos.Children(2).Children;
poss(1).LineWidth = 1.5;
poss(1).Color = colors(1,:);
poss(2).LineWidth = 1.5;
poss(2).Color = colors(2,:);
poss(3).LineWidth = 1.5;
poss(3).Color = colors(3,:);
poss(4).LineWidth = 1.5;
poss(4).Color = colors(4,:);
poss(5).LineWidth = 1.5;
poss(5).Color = colors(5,:);
poss(6).LineWidth = 1.5;
poss(6).Color = colors(6,:);
pos = tight(pos);

vell = vel.Children(2).Children;
vell(1).LineWidth = 1.5;
vell(1).Color = colors(1,:);
vell(2).LineWidth = 1.5;
vell(2).Color = colors(2,:);
vell(3).LineWidth = 1.5;
vell(3).Color = colors(3,:);
vell(4).LineWidth = 1.5;
vell(4).Color = colors(4,:);
vell(5).LineWidth = 1.5;
vell(5).Color = colors(5,:);
vell(6).LineWidth = 1.5;
vell(6).Color = colors(6,:);
vel = tight(vel);

accc = acc.Children(2).Children;
accc(1).LineWidth = 1.5;
accc(1).Color = colors(1,:);
accc(2).LineWidth = 1.5;
accc(2).Color = colors(2,:);
accc(3).LineWidth = 1.5;
accc(3).Color = colors(3,:);
accc(4).LineWidth = 1.5;
accc(4).Color = colors(4,:);
accc(5).LineWidth = 1.5;
accc(5).Color = colors(5,:);
accc(6).LineWidth = 1.5;
accc(6).Color = colors(6,:);
acc = tight(acc);

pos.Children(1).FontSize = 20;
pos.Children(2).FontSize = 20;

vel.Children(1).FontSize = 20;
vel.Children(2).FontSize = 20;

acc.Children(1).FontSize = 20;
acc.Children(2).FontSize = 20;

saveas(pos, strcat(root, 'Figures/traj2_pos.png'));
saveas(vel, strcat(root, 'Figures/traj2_vel.png'));
saveas(acc, strcat(root, 'Figures/traj2_acc.png'));
print(pos, strcat(root, 'Figures/traj2_pos'), '-dpdf', '-r0');
print(vel, strcat(root, 'Figures/traj2_vel'), '-dpdf', '-r0');
print(acc, strcat(root, 'Figures/traj2_acc'), '-dpdf', '-r0');

%% ONLY FOR PLOTTING TRAJ0

root = getenv('root_directory');

time = ftime;
q = fq;
dq = fdq;
ddq = fddq;

pos = figure(); plot(time,[q(:,1), q(:,2), q(:,1), q(:,2), q(:,1), q(:,1)]); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Posições das juntas (rad)'); xlabel('Tempo (s)'); grid on;
vel = figure(); plot(time,[dq(:,1), dq(:,1), dq(:,1), dq(:,1), dq(:,1), dq(:,1)]); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Velocidades das juntas (rad/s)'); xlabel('Tempo (s)'); grid on;
acc = figure(); plot(time,[ddq(:,1), ddq(:,1), ddq(:,1), ddq(:,1), ddq(:,1), ddq(:,1)]); legend('Junta 1', 'Junta 2', 'Junta 3', 'Junta 4', 'Junta 5', 'Junta 6');
title('Trajetória de identificação'); ylabel('Acelerações das juntas (rad/s^2)'); xlabel('Tempo (s)'); grid on;

pos.Children(1).FontSize = 20;
pos.Children(2).FontSize = 20;

vel.Children(1).FontSize = 20;
vel.Children(2).FontSize = 20;

acc.Children(1).FontSize = 20;
acc.Children(2).FontSize = 20;

colors = linspecer(6, 'qualitative');

poss = pos.Children(2).Children;
poss(1).LineWidth = 1.5;
poss(1).Color = colors(1,:);
poss(2).LineWidth = 1.5;
poss(2).Color = colors(1,:);
poss(3).LineWidth = 1.5;
poss(3).Color = colors(2,:);
poss(4).LineWidth = 1.5;
poss(4).Color = colors(1,:);
poss(5).LineWidth = 1.5;
poss(5).Color = colors(2,:);
poss(6).LineWidth = 1.5;
poss(6).Color = colors(1,:);
pos = tight(pos);

vell = vel.Children(2).Children;
vell(1).LineWidth = 1.5;
vell(1).Color = colors(1,:);
vell(2).LineWidth = 1.5;
vell(2).Color = colors(1,:);
vell(3).LineWidth = 1.5;
vell(3).Color = colors(1,:);
vell(4).LineWidth = 1.5;
vell(4).Color = colors(1,:);
vell(5).LineWidth = 1.5;
vell(5).Color = colors(1,:);
vell(6).LineWidth = 1.5;
vell(6).Color = colors(1,:);
vel = tight(vel);

accc = acc.Children(2).Children;
accc(1).LineWidth = 1.5;
accc(1).Color = colors(1,:);
accc(2).LineWidth = 1.5;
accc(2).Color = colors(1,:);
accc(3).LineWidth = 1.5;
accc(3).Color = colors(1,:);
accc(4).LineWidth = 1.5;
accc(4).Color = colors(1,:);
accc(5).LineWidth = 1.5;
accc(5).Color = colors(1,:);
accc(6).LineWidth = 1.5;
accc(6).Color = colors(1,:);
acc = tight(acc);

saveas(pos, strcat(root, 'Figures/traj0_pos.png'));
saveas(vel, strcat(root, 'Figures/traj0_vel.png'));
saveas(acc, strcat(root, 'Figures/traj0_acc.png'));
print(pos, strcat(root, 'Figures/traj0_pos'), '-dpdf', '-r0');
print(vel, strcat(root, 'Figures/traj0_vel'), '-dpdf', '-r0');
print(acc, strcat(root, 'Figures/traj0_acc'), '-dpdf', '-r0');