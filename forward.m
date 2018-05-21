function [ alpha, logm ] = forward(o, A, B, logp, n)
    nObs = length(o);
    alpha = zeros(nObs, n);
    l = zeros(n,1);
    for i = 1:n
        alpha(1,i) = logp(i) + B(i,o(1)+1);
    end
    for t = 2:nObs
        for j = 1:n
            for i = 1:n
                l(i) = alpha(t-1,i) + A(i,j) + B(j,o(1)+1);
            end
            alpha(t,j) = logsumexp(l);
        end
    end
    logm = logsumexp(alpha(end,:));
end

