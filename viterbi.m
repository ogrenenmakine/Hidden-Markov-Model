function [ bestpath ] = viterbi(test, A, B, p)
    [N, M] = size(B);
    T = length(test);
    bestpath = zeros(1,T);
    score = zeros(N,T);
    maxState = zeros(N,T);
    score(:,1) = log(p) + log(B(:,test(1)+1));
    for t = 2:T
        [score(:,t), maxState(:,t)] = max(bsxfun(@plus,A',score(:,t-1)'),[],2);
        score(:,t) = score(:,t) + log(B(:,test(t)+1));
    end
    [~, bestpath(T)] = max(score(:,T));
    for t = (T-1):-1:1
        bestpath(t) = maxState(bestpath(t+1),t+1);
    end
end

