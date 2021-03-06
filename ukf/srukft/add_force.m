clear
clc

root = getenv('root_directory');
load(strcat(root,"data/id1.mat"));

m_torque = mtorque;
q = mq;
time = mt;

J = matrixJ();

Fmag = 10;

t_start = 10;
t_finish = 20;
dt = 1/50;
n = floor(t_start/dt);
N = floor(t_finish/dt);

F_pure = zeros(size(m_torque));
F_pure(n:N,6) = Fmag;

noise = normrnd(0, 0.1, size(F_pure));
F_noisy = F_pure + noise;

tau_f_pure = zeros(size(m_torque));
tau_f_noisy = zeros(size(m_torque));

for i=1:length(m_torque)
     
    Ji = J(q(i,1),q(i,2),q(i,3),q(i,4),q(i,5),q(i,6));
    tau_fi = Ji' * F_pure(i,:)';
    tau_f_pure(i,:) = tau_fi';
    tau_fi = Ji' * F_noisy(i,:)';
    tau_f_noisy(i,:) = tau_fi' + normrnd(0, 0.1, size(tau_fi'));
    
end

torque_with_force_pure = m_torque + tau_f_pure;
torque_with_force_noisy = m_torque + tau_f_noisy;

save(strcat(root, 'data/t_w_f_6_id1.mat'), 'torque_with_force_noisy', 'F_noisy');

figure()
plot(time, F_noisy)

figure()
plot(time, tau_f_noisy)
