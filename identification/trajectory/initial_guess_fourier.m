w = 2*pi/10;
fs = 125;
duration = 10;
N = 5;

dt = 1/fs;
samples = duration * fs;
time = dt:dt:duration;
time = time';

A = zeros(samples, 2*N);

for i=1:N
    
    A(:, 2*i-1) = cos(w*i*time);
    A(:, 2*i) = sin(w*i*time);
    
end

AA = inv(A'*A)*A';
%%
% speed: 360 deg/sec on 4,5,6 and 180 deg/sec 1,2,3

dq1 = -pi + 2*pi*rand(samples,1);
delta1 = AA*dq1;

dq2 = -pi + 2*pi*rand(samples,1);
delta2 = AA*dq2;

dq3 = -pi + 2*pi*rand(samples,1);
delta3 = AA*dq3;

dq4 = -2*pi + 4*pi*rand(samples,1);
delta4 = AA*dq4;

dq5 = -2*pi + 4*pi*rand(samples,1);
delta5 = AA*dq5;

dq6 = -2*pi + 4*pi*rand(samples,1);
delta6 = AA*dq6;

delta = [delta1; delta2; delta3; delta4; delta5; delta6];

x = [delta(1:2:end); delta(2:2:end); w];
