function X = calc_sigma_points(x, S, eta)

    mx = eta * S';
    
    Y = x(:, ones(1, length(x)));
    
    X = [x Y+mx Y-mx];

end