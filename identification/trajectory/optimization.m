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

clear
clc

%%
traj = 2;        % 1 - fourier, 2 - park
opt = 1;         % 1 - fmincon, -1 - ga, 0 - both

if traj == 1
    
    fcn = @fcn_fourier;
    const = @(x) constraints(x, "fourier");
    numberofvariables = 61;
    load f_initialguesses.mat
    
elseif traj == 2
        
    fcn = @fcn_park;
    const = @(x) constraints(x, "park");
    numberofvariables = 50;
    load p_initialguesses.mat
    
end
%% fmincon

if opt >= 0
    
    options = optimoptions(@fmincon, 'Display', 'iter', ...
        'Algorithm', 'interior-point', 'MaxIterations', 1000, ...
        'MaxFunctionEvaluations', 100000,'UseParallel',true);
    
    if max(size(gcp)) == 0 % parallel pool needed
        parpool % create the parallel pool
    end

    tic
    [x, fval] = fmincon(fcn,best_xs(:,end),[],[],[],[],[],[],const, options);
    toc

    save done.mat
    fval

end

%% ga

if opt <= 0

    options = optimoptions('ga','InitialPopulationMatrix',best_xs,'FunctionTolerance',1e-6,'PopulationSize',50,'MaxGenerations',500, 'Display', 'iter');
    tic
    [x,fval] = ga(fcn,numberofvariables,[],[],[],[],[],[],const,options);
    toc

    save done_ga.mat
    fval

end
