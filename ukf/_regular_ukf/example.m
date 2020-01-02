clear
clc

T = matrix_T();

idyn = @(q,dq,ddq) T(q(1), q(2), q(3), q(4), q(5), q(6), ...
    dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6));

A = matrix_A();
B = matrix_B();

fdyn = @(q, dq, tau) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
    * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));

load('data.mat');


n=24;      %number of state
qnoise=0.1;    %std of process 
r=1;    %std of measurement
Q=qnoise^2*eye(n); % covariance of process
R=r^2;        % covariance of measurement  
f=@(x)[x(1:6)+0.008*x(7:12);x(7:12)+0.008*x(13:18);fdyn(x(1:6), x(7:12), x(19:24));idyn(x(1:6), x(7:12), x(13:18))];  % nonlinear state equations
h=@(x) x;                               % measurement equation
s=zeros(24,1);                                % initial state
x=s+qnoise*randn(n,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=1875;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(n,N);
for k=1:N
  z = [q(k,:)'; d_q(k,:)'; d_d_q(k,:)'; m_torque(k,:)'];                  % measurments
  sV(:,k)= s;                             % save actual state
  zV(:,k)  = z;                             % save measurment
  [x, P] = learning_ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + qnoise*randn(n,1);                % update process 
  k
end