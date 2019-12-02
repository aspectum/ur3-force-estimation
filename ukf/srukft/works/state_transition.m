function x1 = state_transition(x, fdyn, idyn, dt)

    x1 = zeros(length(x),1);
    
    % q_t+1 = q_t + dt * dq_t
    x1(1:6) = x(1:6) + dt * x(7:12);
    
    % dq_t+1 = dq_t + dt * ddq_t
    x1(7:12) = x(7:12) + dt * x(13:18);
    
    % use the values I just predicted or the past ones (x)?
    % using the past
    
    x1(13:18) = fdyn(x(1:6), x(7:12), x(19:24), x(25:30));
    
    x1(19:24) = idyn(x(1:6), x(7:12), x(13:18), x(25:30));
    
    x1(25:30) = x(25:30);
    

end