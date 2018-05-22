function [ bestpath ] = viterbi(o, A, B, p, n)
    A = log(A);
    nObs = length(o);
    delta = zeros(nObs,n);
    psi = ones(nObs,n);
    for i = 1:n
        delta(1,i) = log(p(i)) + log(B(i,o(1)+1));
    end
    for t = 2:nObs
        for j = 1:n
            maxval = -Inf;
            maxind = 0;
            for r = 1:n
                newval = delta(t-1,r) + A(r,j);
                if newval > maxval
                    maxval = newval;
                    maxind = r;
                end
                delta(t,j) = maxval + log(B(j,o(t)+1));
                psi(t,j) = maxind;
        end
    end
    bestpath = ones(1,nObs);
    [y bestpath(end)] = max(delta(end,:));
    for t = (nObs-1):-1:1
        bestpath(t) = psi(t+1,bestpath(t+1));
    end
end