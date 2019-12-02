clear
clc

syms lbd0 lbd1 lbd2 lbd3 lbd4 lbd5 a1 a2 a3 a4 a5 t

% Period
T = 10;

w = 2 * pi / T;

q = lbd0 + lbd1*t + lbd2*t^2 + lbd3*t^3 + lbd4*t^4 + lbd5*t^5 + ...
    a1*cos(w*t) + a2*cos(2*w*t) + a3*cos(3*w*t) + a4*cos(4*w*t) + a5*cos(5*w*t);

dq = diff(q,t);
ddq = diff(dq,t);

% subs(q,t,0)   lbd0
% subs(dq,t,0)  lbd1
% subs(ddq,t,0) lbd2

% boundary conditions
q0 = 0;
dq0 = 0;
ddq0 = 0;
qf = 0;
dqf = 0;
ddqf = 0;

% lambda0 = solve(subs(q,t,0) == q0, lbd0);
% lambda1 = solve(subs(dq,t,0) == dq0, lbd1);
% lambda2 = solve(subs(ddq,t,0) == ddq0, lbd2);

% eq1 = subs(q,[t, lbd0, lbd1, lbd2], [T, lambda0, lambda1, lambda2]) == qf
% eq2 = subs(dq,[t, lbd0, lbd1, lbd2], [T, lambda0, lambda1, lambda2]) == dqf
% eq3 = subs(ddq,[t, lbd0, lbd1, lbd2], [T, lambda0, lambda1, lambda2]) == ddqf

eq1 = subs(q,t,0) == q0;
eq2 = subs(dq,t,0) == dq0;
eq3 = subs(ddq,t,0) == ddq0;
eq4 = subs(q,t,T) == qf;
eq5 = subs(dq,t,T) == dqf;
eq6 = subs(ddq,t,T) == ddqf;

[A, B] = equationsToMatrix([eq1, eq2, eq3, eq4, eq5, eq6], [lbd0, lbd1, lbd2, lbd3, lbd4, lbd5]);
lambda = simplify(linsolve(A,B))

%%
assume(a1,'real');
assume(a2,'real');
assume(a3,'real');
assume(a4,'real');
assume(a5,'real');
test = subs(dq, [lbd0 lbd1 lbd2 lbd3 lbd4 lbd5], lambda')