function accel = accel_array(q, dq, tau)

    A = matrix_A();
    B = matrix_B();

    dotdotq = @(q, dq, tau) (B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
        \ (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));
    
    fdyn = @(q, dq, tau) min(9*ones(6,1), max(-9*ones(6,1), dotdotq(q, dq, tau)));
    
    accel = zeros(length(q), 6);
    
    for i=1:length(q)
        ai = fdyn(q(i,:), dq(i,:), tau(i,:)');
        accel(i,:) = ai;
    end

end