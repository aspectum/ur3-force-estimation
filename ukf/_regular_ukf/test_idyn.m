
T = matrix_T();

idyn = @(q,dq,ddq) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6));

t = 1:0.008:60;
q1 = sin(t/6) + 0.1*randn(1,length(t));
q2 = sin(t/5) + 0.1*randn(1,length(t));
q3 = sin(t/4) + 0.1*randn(1,length(t));
q4 = sin(t/3) + 0.1*randn(1,length(t));
q5 = sin(t/2) + 0.1*randn(1,length(t));
q6 = sin(t) + 0.1*randn(1,length(t));

q = [q1;q2;q3;q4;q5;q6];

dq = diff(q,1,2);

ddq = diff(q,2,2);

tau = zeros(size(ddq));

for i=1:length(tau)
    
    taui = idyn(q(:,i), dq(:,i), ddq(:,i));
    tau(:,i) = taui;
    
end

figure()
plot(t(1:length(ddq)), q(:,1:length(ddq)))
figure()
plot(t(1:length(ddq)), dq(:,1:length(ddq)))
figure()
plot(t(1:length(ddq)), ddq)
figure()
plot(t(1:length(ddq)), tau)

%%


T = matrix_T();

idyn = @(q,dq,ddq) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6));

load('data.mat');

tau = zeros(size(q));

for i=1:length(tau)
    
    taui = idyn(q(i,:), d_q(i,:), d_d_q(i,:));
    tau(i,:) = taui';
    
end

%%
figure()
plot(time, tau(:,5), time, m_torque(:,5)); legend('model', 'meas')
