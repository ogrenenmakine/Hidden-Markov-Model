function [ logp ] = logsumexp( logp )
    mlogp = max(max(logp));
    if mlogp == -Inf
        logp = -Inf;
    elseif mlogp == Inf
        logp = Inf;
    else
        logp = log(sum(sum(exp(logp - mlogp)))) + mlogp;
    end
end

