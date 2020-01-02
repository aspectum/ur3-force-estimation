function val = fcn_fourier(x)
        
    N = 5;  % order of the fourier series
    q0 = [0; -pi/2; 0; -pi/2; 0; 0];    % position about which the robot oscillates
    fs = 125;   % sampling rate
    duration = 10;  % period
    
    dt = 1/fs;
    samples = duration * fs;
    
    a = reshape(x(1:N*6), N, 6);
    b = reshape(x(N*6+1:end), N, 6);
    w = 2*pi/duration;    % base frequency
    
    [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt);
    
    Y = regressor();
    cond = criterion(q, dq, ddq, Y, "cond");
    
    val = cond;
    
end