function [ logbeta ] = backward(input, logA, logB, logalphaScale)
    % backward calculation of log-posterior probability
    % input: 1xT, sequence
    % logA: NxN, trasition matrix
    % logB: NxM, emission matrix
    % logp: Nx1, prior probabilities
    % logalphaScale: T, scaling scalars of logalpha
    % output parameters
    % logbeta: NxT, forward probabilities
    [N M] = size(logB);
    T = length(input);
    logbeta = ones(N,T);
    logbeta(:,T) = zeros(N,1);
    for t = (T-1):-1:1
        logbeta(:,t) = log(exp(logA)*exp(logB(:,input(t+1)+1)+logbeta(:,t+1)));
        logbeta(:,t) = logbeta(:,t) + logalphaScale(t);
    end
end

