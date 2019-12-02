function val = fitness(q, dq, ddq, theta, measured_torques, Y)
                                    
    torques = torque_from_regressor(q, dq, ddq, theta, Y);
%     torques = lag2(q, dq, ddq, theta);
    torques = torques';
    Tau = zeros(1,6);
    for i=1:length(q)-1
        for j=1:6
            Tau(j) = Tau(j) + (torques(i,j) - measured_torques(i,j)).^2;
        end
    end
    
    val = sum(Tau)/length(q)/6;
end