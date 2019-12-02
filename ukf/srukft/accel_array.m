function accel = accel_array(q, dq, tau)

    root = getenv('root_directory');
    load(strcat(root, 'data/theta_prbs_fr'));

    A = matrixA(theta);
    B = matrixB(theta);

    fdyn = @(q, dq, tau, F) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
        * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));
    
    accel = zeros(length(q), 6);
    
    for i=1:length(q)
        ai = fdyn(q(i,:), dq(i,:), tau(i,:)');
        accel(i,:) = ai;
    end

end