function chi = calc_sigma_points(x, P, lambda)

    L = length(x);
    chi = zeros(L,2*L+1);
    
    chi(:,1) = x;
    
    % This is not Cholesky
    % lambda outside sqrt?
    mx = chol(nearestSPD((L+lambda)*P));
    
    for i=1:L
        chi(:,i) = x + mx(:,i);
    end
    
    for i=(L+1):(2*L)
        chi(:,i) = x - mx(:,i-L);
    end

end