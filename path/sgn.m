function s = sgn(x,d)

    if abs(x) < d
        s = 0;
    elseif x > 0
        s = 1;
    else
        s = -1;
    end

end