rosshutdown
close all
clear
clc

%% Connecting to robot pc
setenv('ROS_MASTER_URI','http://192.168.1.68:11311')
rosinit('http://192.168.1.68:11311')

%% Creating subscriber
sub = rossubscriber('/subsampled_arm');

%%
% time(i) = (msg{i,1}.Header.Stamp.Nsec - msg{1,1}.Header.Stamp.Nsec)/1e9 + (msg{i,1}.Header.Stamp.Sec - msg{1,1}.Header.Stamp.Sec);

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

figure()
qplot = plot(time, q);
ylim([-3*pi 3*pi])
title('Positions');
xlabel('Time');
ylabel('Joint positions (rad)');
legend('1 ', '2 ', '3 ', '4 ', '5 ', '6 ');

figure()
dqplot = plot(time, dq);
ylim([-3*pi 3*pi])
title('Velocity');
xlabel('Time');
ylabel('Joint velocities (rad/s)');
legend('1 ', '2 ', '3 ', '4 ', '5 ', '6 ');

figure()
tplot = plot(time, torque);
ylim([-20 20])
title('Torque');
xlabel('Time');
ylabel('Joint Torques (N/m)');
legend('1 ', '2 ', '3 ', '4 ', '5 ', '6 ');

tic
while i < 2000
    
    if mod(i,100) == 0
        set(qplot(1), 'xdata',time);
        set(qplot(1), 'ydata',q(:,1));
        set(qplot(2), 'xdata',time);
        set(qplot(2), 'ydata',q(:,2));
        set(qplot(3), 'xdata',time);
        set(qplot(3), 'ydata',q(:,3));
        set(qplot(4), 'xdata',time);
        set(qplot(4), 'ydata',q(:,4));
        set(qplot(5), 'xdata',time);
        set(qplot(5), 'ydata',q(:,5));
        set(qplot(6), 'xdata',time);
        set(qplot(6), 'ydata',q(:,6));

        set(dqplot(1), 'xdata',time);
        set(dqplot(1), 'ydata',dq(:,1));
        set(dqplot(2), 'xdata',time);
        set(dqplot(2), 'ydata',dq(:,2));
        set(dqplot(3), 'xdata',time);
        set(dqplot(3), 'ydata',dq(:,3));
        set(dqplot(4), 'xdata',time);
        set(dqplot(4), 'ydata',dq(:,4));
        set(dqplot(5), 'xdata',time);
        set(dqplot(5), 'ydata',dq(:,5));
        set(dqplot(6), 'xdata',time);
        set(dqplot(6), 'ydata',dq(:,6));

        set(tplot(1), 'xdata',time);
        set(tplot(1), 'ydata',torque(:,1));
        set(tplot(2), 'xdata',time);
        set(tplot(2), 'ydata',torque(:,2));
        set(tplot(3), 'xdata',time);
        set(tplot(3), 'ydata',torque(:,3));
        set(tplot(4), 'xdata',time);
        set(tplot(4), 'ydata',torque(:,4));
        set(tplot(5), 'xdata',time);
        set(tplot(5), 'ydata',torque(:,5));
        set(tplot(6), 'xdata',time);
        set(tplot(6), 'ydata',torque(:,6));
    end
    data = receive(sub, 1);
    time(i) = (data.Header.Stamp.Nsec - stnsec)/1e9 + data.Header.Stamp.Sec - stsec;
    q(i,:) = data.Position;
    dq(i,:) = data.Velocity;
    torque(i,:) = data.Effort;

    i = i + 1;
    
end
toc/i