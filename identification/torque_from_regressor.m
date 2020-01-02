function torque = torque_from_regressor(q, dq, ddq, theta, Y)
    
    torque = zeros(6, length(q));

    for i=1:length(q)
        torque(:, i) = Y(q(i,1), q(i,2), q(i,3), q(i,4), q(i,5), q(i,6), dq(i,1), dq(i,2), dq(i,3), dq(i,4), dq(i,5), dq(i,6), ddq(i,1), ddq(i,2), ddq(i,3), ddq(i,4), ddq(i,5), ddq(i,6)) * theta;
    end
    
end