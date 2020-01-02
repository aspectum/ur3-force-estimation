% joint ranges: +- 360, and infinite on end joint
% speed: 360 deg/sec on 4,5,6 and 180 deg/sec 1,2,3
%   src: ur3 tech specs
% accel: 300 deg/sec^2
%   src: dof.robotiq.com universal robots joints values, jacobbom answer
% AVOIDING SELF COLISION
% considering q0 the offset necessary for the standing straight config
% J1 - whatever
% J2 - +- pi/2 (+-pi/4 safer) 
% J3 - +-3pi/4 (+-pi/2 safer)
% J4 - +- pi/2
% J5 and J6 whatever

function [c, ceq] = constraints(x, trajectory)
    
    if trajectory == "fourier"
        
        N = 5;
        q0 = [0; -pi/2; 0; -pi/2; 0; 0];
        fs = 50;
        duration = 10;

        dt = 1/fs;
        samples = duration * fs;

        a = reshape(x(1:N*6), N, 6);
        b = reshape(x(N*6+1:end), N, 6);
        w = 2*pi/10;

        [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt);

    elseif trajectory == "park"

        fs = 50;
        duration = 60;

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
    
    end
    
%     q(:,1) = q(:,1) ./2;
%     dq(:,1) = q(:,1) ./2;
%     ddq(:,1) = q(:,1) ./2;

    
    c = [ ...
%         max(abs(q(:,1))) - 2*pi; ...
        max(abs(q(:,1))) - pi; ...
        max(abs(q(:,2) + pi/2)) - pi/4; ...
        max(abs(q(:,3))) - pi/2; ...
        max(abs(q(:,4) + pi/2)) - pi/2; ...
        max(abs(q(:,5))) - 2*pi; ...
        max(max(abs(dq(:,1:3)))) - 0.75*pi; ...
        max(max(abs(dq(:,4:6)))) - 0.75*2*pi; ...
        max(abs(ddq(:))) - 4*pi/3];
    
%     c = 10*max(check);
    
    ceq = [];
        
end