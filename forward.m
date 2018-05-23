function [logalpha, logalphaScale] = forward(input, logA, logB, logp)
    % forward calculation of log-posterior probability
    % input: 1xT, sequence
    % logA: NxN, trasition matrix
    % logB: NxM, emission matrix
    % logp: Nx1, prior probabilities
    % output parameters
    % logalpha: NxT, forward probabilities
    % logalphaScale: T, scaling scalars of logalpha
    [N, M] = size(logB);
    T = length(input);
    logalpha = ones(N,T);
    logalphaScale = ones(1,T);
    logalpha(:,1) = logp + logB(:,input(1)+1);
    logalphaScale(1) = -logsumexp(logalpha(:,1));
    for t = 2:T
        logalpha(:,t) = log(((exp(logA))')*exp(logalpha(:,t-1))) + logB(:,input(t)+1);
        logalphaScale(t) = -logsumexp(logalpha(:,t));
        logalpha(:,t) = logalpha(:,t) + logalphaScale(t);
    end
end

