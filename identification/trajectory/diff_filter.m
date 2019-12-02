function [tt, ds] = diff_filter(s, time, order, passf, stopf, fs)

    d = designfilt('differentiatorfir', 'FilterOrder', order, ...
        'PassbandFrequency', passf, 'StopbandFrequency', stopf, ...
        'SampleRate', fs);
    
    delay = mean(grpdelay(d));
    ds = filter(d, s)*fs;
    
    tt = time(1:end-delay);
    tt(1:delay) = [];
    
    ds(1:delay, :) = [];
    ds(1:delay, :) = [];

end