function tau = torque_array(q, dq, ddq)
    
    root = getenv('root_directory');
    load(strcat(root, 'data/theta_prbs_fr'));

    Y = regressor_fr();

    idyn = @(q,dq,ddq, F) Y(q(1), q(2), q(3), q(4), q(5), q(6), ...
        dq(1), dq(2), dq(3), dq(4), dq(5), dq(6), ddq(1), ddq(2), ddq(3), ddq(4), ddq(5), ddq(6))*theta;

%     A = matrixA(theta);
%     B = matrixB(theta);
% 
%     fdyn = @(q, dq, tau, F) inv(B(q(1), q(2), q(3), q(4), q(5), q(6))) ...
%         * (tau - A(q(1), q(2), q(3), q(4), q(5), q(6), dq(1), dq(2), dq(3), dq(4), dq(5), dq(6)));
    
    tau = zeros(length(q), 6);
    
    for i=1:length(q)
        taui = idyn(q(i,:), dq(i,:), ddq(i,:));
        tau(i,:) = taui';
    end

end