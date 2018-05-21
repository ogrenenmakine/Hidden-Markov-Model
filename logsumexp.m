function [ x ] = logsumexp( x )
    mx = max(max(x));
    if mx == -Inf
        x = -Inf;
    elseif mx == Inf
        x = Inf;
    else
        x = sum(sum(exp(x - mx))) + mx;
    end
end

