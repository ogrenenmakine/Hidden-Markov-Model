function [ logp ] = logsumexp( logp )
    mlogp = max(max(logp));
    logp = log(sum(exp(logp - mlogp))) + mlogp;
end

