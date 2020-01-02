clear
clc
n = 1000;   % number of initial guesses

%%% I'm generating 1000 initial guesses and taking the 50 best

%%% uncomment if generating guesses for the fourier parametrization
% best_scores = 1e20*ones(1,50);
% best_xs = zeros(61,50);

%%% uncomment if generating guesses for the park parametrization
best_scores = 1e20*ones(1,50);
best_xs = zeros(30,50);


%%% uncomment the appropriate lines for fourier or park
for j=1:n
%     run('initial_guess_fourier.m');
    run('initial_guess_park.m');

%     con = constraints(x, "fourier");
    con = constraints(x, "park");
    
    if con < 0
        
%         score = fcn_fourier(x);
        score = fcn_park(x);
        
        if score < best_scores(1)
            best_scores(1) = score;
            score
            best_xs(:,1) = x;
            
            [best_scores, order] = sort(best_scores, 'descend');
            best_xs = best_xs(:,order);
            j
            
        end
        
    end
    
end

save('initialguesses.mat', 'best_xs')