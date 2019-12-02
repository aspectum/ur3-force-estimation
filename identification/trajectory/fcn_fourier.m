function val = fcn_fourier(x)
        
    N = 5;
    q0 = [0; -pi/2; 0; -pi/2; 0; 0];
    fs = 125;
    duration = 10;
    
    dt = 1/fs;
    samples = duration * fs;
    
    a = reshape(x(1:N*6), N, 6);
%     b = reshape(x(N*6+1:end-1), N, 6);
%     w = x(end);
    b = reshape(x(N*6+1:end), N, 6);
    w = 2*pi/10;
    
    [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt);
        
%     order = 20;
%     passf = 10;
%     stopf = 1.5 * passf;
%     
%     [tt, dq] = diff_filter(q, time, order, passf, stopf, fs);
%     
%     [ttt, ddq] = diff_filter(dq, tt, order, passf, stopf, fs);
%     
%     delay = (length(time) - length(tt))/2;
%     
%     q = q(2*delay+1:end-2*delay,:);
%     dq = dq(delay+1:end-delay,:);
    
    Y = regressor();
%     q(:,1) = q(:,1) ./2;
%     dq(:,1) = q(:,1) ./2;
%     ddq(:,1) = q(:,1) ./2;
    cond = criterion(q, dq, ddq, Y, "cond");
    
    val = cond;
    
end