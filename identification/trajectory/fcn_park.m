function val = fcn_park(x)
        
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
    
    Y = regressor();
    
    cond = criterion(q, dq, ddq, Y, "cond");
    
    val = cond;
    
end