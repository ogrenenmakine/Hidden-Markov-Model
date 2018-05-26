function [logalpha, logpseq] = forward(input, logA, logB, logp)
    % forward calculation of log-posterior probability
    % input: 1xT, sequence
    % logA: NxN, trasition matrix
    % logB: NxM, emission matrix
    % logp: Nx1, prior probabilities
    % output parameters
    % logalpha: NxT, forward probabilities
    % logpseq: T, scaling scalars of logalpha
    [N, M] = size(logB);
    T = length(input);
    logalpha = ones(N,T);
    logpseq = ones(1,T);
    % initialization step
    logalpha(:,1) = logp + logB(:,input(1)+1);
    logpseq(1) = -logsumexp(logalpha(:,1));
    % induction step
    for t = 2:T
        logalpha(:,t) = log(((exp(logA))')*exp(logalpha(:,t-1))) + logB(:,input(t)+1);
        logpseq(t) = -logsumexp(logalpha(:,t));
        logalpha(:,t) = logalpha(:,t) + logpseq(t); % be careful logpseq is already minus sign, it is a division
    end
end

