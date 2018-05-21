function [logm, alpha, beta, delta, gamma] = obsv_prob(o, A, B, logp, n)
    nObs = length(o);
    gamma = zeros(nObs,n);
    delta = zeros(nObs-1,n,n);
    [alpha, logm] = forward(o, A, B, logp, n);
    beta = backward(o, A, B, logp, n);
    for t = 1:nObs
        for i = 1:n
            gamma(t,i) = exp(alpha(t,i) + beta(t,i) - logm);
        end
    end
    for t = 1:(nObs-1)
        for i = 1:n
            for j = 1:n
                delta(t,i,j) = exp(alpha(t,i)+A(i,j)+log(B(j,o(t+1)+1))+beta(t+1,j)-logm);
            end
        end
    end
end
