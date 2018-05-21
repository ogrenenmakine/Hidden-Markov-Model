function [ beta ] = backward(o, A, B, p, n)
    nObs = length(o);
    beta = zeros(nObs, n);
    beta(end,:) = 0;
    l = zeros(1,n);
    for t = (nObs-1):-1:1
        for j = 1:n
            for i = 1:n
                l(i) = beta(t+1,i) + A(i,j) + B(j,o(t)+1);
            end
            beta(t,j) = logsumexp(l);
        end
    end
end

