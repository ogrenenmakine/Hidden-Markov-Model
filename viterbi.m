function [ bestpath ] = viterbi(test, A, B, p)
    % viterbi algorithm
    % test: 1xT, sequence
    % A: NxN, trasition matrix
    % B: NxM, emission matrix
    % p: Nx1, prior probabilities
    [N, M] = size(B);
    T = length(test);
    bestpath = zeros(1,T);
    score = ones(N,T);
    % Initialization
    psi = zeros(N,T);
    score(:,1) = log(p) + log(B(:,test(1)+1));
    % Recursion
    for t = 2:T
        [score(:,t), psi(:,t)] = max(bsxfun(@plus,log(A'),score(:,t-1)'),[],2);
        score(:,t) = score(:,t) + log(B(:,test(t)+1));
    end
    [~, bestpath(T)] = max(score(:,T));
    % Path backtracking
    for t = (T-1):-1:1
        bestpath(t) = psi(bestpath(t+1),t+1);
    end
end

