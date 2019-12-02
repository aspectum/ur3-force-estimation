clear
clc
root = getenv('root_directory');

%% Loading data

load(strcat(root, 'data/prbs.mat'));

mt = time;
mq = q;
mdq = d_q;
mddq = d_d_q;
mtorque = m_torque;

%% Defining filter

order = 20;
passf=10;
stopf=15;
fs = 125;

d = designfilt('differentiatorfir','FilterOrder',order, ...
    'PassbandFrequency',passf,'StopbandFrequency',stopf, ...
    'SampleRate',125);

delay = mean(grpdelay(d));

%% Differentiating

ftime = mt(2*delay+1:end-2*delay);
fq = mq(2*delay+1:end-2*delay,:);
fdq = zeros(size(mq,1)-4*delay, size(mq,2));
fddq = zeros(size(mq,1)-4*delay, size(mq,2));

for n=1:6
    pos = mq(:,n);
    
    vel = filter(d, pos)*fs;

    tt = mt(1:end-delay);
    v = vel;
    v(1:delay) = [];

    tt(1:delay) = [];
    v(1:delay) = [];

    fdq(:,n) = v(delay+1:end-delay);

    acel = filter(d,vel)*fs;

    at = mt(1:end-2*delay);
    a = acel;
    a(1:2*delay) = [];

    at(1:2*delay) = [];
    a(1:2*delay) = [];

    fddq(:,n) = a;
    
end

%% Filtering torques

[num,den] = butter(2,0.05);

ftorque = zeros(size(mtorque,1)-4*delay, size(mtorque,2));

for n=1:6

    filtered = filtfilt(num,den,mtorque(:,n));
    ftorque(:,n) = filtered(2*delay+1:end-2*delay);

end

save(strcat(root, 'data/fdata.mat', 'ftime', 'fq', 'fdq', 'fddq', 'ftorque');