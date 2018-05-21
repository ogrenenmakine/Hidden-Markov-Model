function [Amax,Bmax,logp,h,hval] = baumwelch(train, val, A, B, p, n, m)
    nSeq = length(train);
    logp = log(p);
    A = log(A);
    % random initialization
    alpha = log(rand(m,m));
    phi = log(rand(n,m)); hval = -Inf; h = -Inf;
    % EM variables initialization
    logmval = -Inf;
    logmmax = Inf;
    logmold = 0;
    iter = 1;
    for k = 1:250
        logmold = logmval;
        [logm, alpha, beta, delta, gamma] = obsv_prob(train, A, B, logp, n);
        [logmval, ~, ~, ~, ~] = obsv_prob(val, A, B, logp, n);
        [logp, A, B] = maximization(train, delta, gamma, B, n, m);
        if logmval < logmmax
            Amax = A;
            Bmax = B;
            logmmax = logmval;
        end
        iter = iter + 1;
        hval = cat(1,hval,logmval);
        h = cat(1,h,logm);
        if iter > 1 & (abs(logmold-logmval) <= 1e-5)
            break
            h = h(2:end);
            hval = hval(2:end);
        end
    end
end