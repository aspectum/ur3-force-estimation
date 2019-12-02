function [y, Y, Yd, S] = ut(fcn, X, wm, wc, n, R)

    m = length(X);
    y = zeros(n,1);
    Y = zeros(n,m);
    
    % ^^ 1e-6
    
    for i=1:m
        
        Y(:,i) = fcn(X(:,i));       % <<-- 8e-4 para fcn_state
        y = y + wm(i) * Y(:,i);
        
    end
    
    % ^^ 0.0394
    
    Yd = Y - y(:, ones(1, m));
    
    d = Yd * diag(sqrt(abs(wc))); % weighted avg of the deviations, kind of
    
    [~, S] = qr([d(:,2:m) R]', 0);
    
    
    if wc(1) < 0
        S = cholupdate(S, d(:,1), '-');
    else
        S = cholupdate(S, d(:,1), '+'); % plus sign redundant
    end
        
    % ^^ 1e-4

end