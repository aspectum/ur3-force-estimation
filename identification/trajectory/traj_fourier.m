function [q, dq, ddq] = traj_fourier(a, b, w, q0, N, samples, dt)

    q = zeros(samples, 6);
    t = dt*(1:samples)';
    
    for i=1:6
        
        for l=1:N
            
            q(:,i) = q(:,i) + (a(l,i)/(w*l))*sin(w*l*t) - (b(l,i)/(w*l))*cos(w*l*t);
            
        end
        
        q(:,i) = q(:,i) + q0(i);
        
    end
    
    dq = zeros(samples, 6);
    
    for i=1:6
        
        for l=1:N
            
            dq(:,i) = dq(:,i) + a(l,i)*cos(w*l*t) + b(l,i)*sin(w*l*t);
            
        end
        
    end
    
    ddq = zeros(samples, 6);
    
    for i=1:6
        
        for l=1:N
            
            ddq(:,i) = ddq(:,i) - a(l,i)*w*l*sin(w*l*t) + b(l,i)*w*l*cos(w*l*t);
            
        end
        
    end

end