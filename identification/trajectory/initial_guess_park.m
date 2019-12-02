something = @(t) [-(pi*(250*sin((pi*t)/5) - 50*pi*t + 15*pi*t^2 - pi*t^3))/1250, ...
    -(2*pi*(125*sin((2*pi*t)/5) - 50*pi*t + 15*pi*t^2 - pi*t^3))/625, ...
    -(3*pi*(250*sin((3*pi*t)/5) - 150*pi*t + 45*pi*t^2 - 3*pi*t^3))/1250, ...
    -(4*pi*(125*sin((4*pi*t)/5) - 100*pi*t + 30*pi*t^2 - 2*pi*t^3))/625, ...
    t*pi^2 - pi*sin(pi*t) - (3*t^2*pi^2)/10 + (t^3*pi^2)/50];

w = 2*pi/10;
fs = 50;
duration = 60;

dt = 1/fs;
samples = duration * fs;
time = dt:dt:duration;
time = time';

A = zeros(samples, 5);

for i=1:samples
    
    A(i, :) = something(time(i));
    
end

AA = inv(A'*A)*A';

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

x = [delta1; delta2; delta3; delta4; delta5; delta6];


 