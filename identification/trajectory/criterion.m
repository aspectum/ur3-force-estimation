function c = criterion(q, dq, ddq, Y, crit)

    sz_regressor = size(Y(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
    n_params = sz_regressor(2);
    n_points = length(q);

    Phi = zeros(n_points*6, n_params);

    for i=1:n_points

        Yi = Y(q(i,1), q(i,2), q(i,3), q(i,4), q(i,5), q(i,6), dq(i,1), dq(i,2), dq(i,3), dq(i,4), dq(i,5), dq(i,6), ddq(i,1), ddq(i,2), ddq(i,3), ddq(i,4), ddq(i,5), ddq(i,6));
        idx = 6*(i-1) + 1;
        Phi(idx:idx+5, :) = Yi;

    end
    
    
    if crit == "cond"
        
        A = Phi' * Phi;
        A = normc(A);

        s = svd(A);

        c = s(1)/s(end);
        
    elseif crit == "cramer-rao"
    
        P = Phi' * Phi;
        c = - log(det(P));
        
    end
    
end