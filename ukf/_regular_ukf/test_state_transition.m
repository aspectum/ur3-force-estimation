function x1 = test_state_transition(x, fdyn, idyn, dt)

    x1 = zeros(size(x));

    tic
    for j=1:(2*size(x,1)+1)
%         chi_k(:,j) = state_transition(chi_kminus(:,j), fdyn, idyn, dt);

        % q_t+1 = q_t + dt * dq_t
        x1(1:6,j) = x(1:6,j) + dt * x(7:12,j);

        % dq_t+1 = dq_t + dt * ddq_t
        x1(7:12,j) = x(7:12,j) + dt * x(13:18,j);

        % use the values I just predicted or the past ones (x)?
        % using the past

        x1(13:18,j) = fdyn(x(1:6,j), x(7:12,j), x(19:24,j));

        x1(19:24,j) = idyn(x(1:6,j), x(7:12,j), x(13:18,j));
        
    end
    toc

end