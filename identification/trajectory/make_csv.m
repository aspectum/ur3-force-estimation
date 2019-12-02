% N = 5;
% q0 = [0; -pi/2; 0; -pi/2; 0; 0];
% fs = 125;
% duration = 10;
% 
% dt = 1/fs;
% samples = duration * fs;
% %     time = dt:dt:duration;
% 
% a = reshape(x(1:N*6), N, 6);
% %         b = reshape(x(N*6+1:end-1), N, 6);
% %         w = x(end);
% b = reshape(x(N*6+1:end-1), N, 6);
% w = 2*pi/10;
% 
% [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt);
% 
% q(:,1) = q(:,1) ./2;
% dq(:,1) = q(:,1) ./2;
% ddq(:,1) = q(:,1) ./2;

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


[m, idx] = max(dq, [], 2);
accel = zeros(samples,1);
for i=1:samples
    
    accel(i) = ddq(i,idx(i));
    
end

csvwrite("csv/pos.csv",q);
csvwrite("csv/vel.csv",dq);
csvwrite("csv/acc.csv",ddq);
csvwrite("csv/leading.csv",accel);