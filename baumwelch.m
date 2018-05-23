function [A, B, p, avgtrain, avgval, logliketrain, loglikeval] = baumwelch(train, val, A, B, p)
    avgtrain = 0;
    avgval = 0;
    for i = 1:1000
        logliketrain = 0;
        loglikeval = 0;
        logA = log(A);
        logB = log(B);
        logp = log(p);
        Pnew = ones(size(logp));
        Anew = ones(size(logA));
        Bnew = ones(size(logB));
        for idx = 1:size(train,1)
            input = train(idx,:);
            T = length(input);
            [logalpha, logalphaScale] = forward(input, logA, logB, logp);
            logbeta = backward(input, logA, logB, logalphaScale);
            loggamma = logalpha + logbeta;
            loggamma = loggamma - logsumexp(loggamma);
            chi = zeros(size(A,1));
            for t = 1:(T-1)
                tmp = (exp(logalpha(:,t))*exp(((logbeta(:,t+1) + logB(:,input(t+1)+1))'))) + exp(logA);
                chi = chi + tmp / sum(sum(tmp));
            end
            Pnew = Pnew + exp(loggamma(:,1));
            Anew = Anew + chi;
            for k = 1:size(B,2)
                Bnew(:,k) = Bnew(:,k) + sum(exp(loggamma(:,input==k)),2);
            end
            logliketrain = cat(1,logliketrain,logsumexp(logalphaScale));
        end
        avgtrain = cat(1,avgtrain,logsumexp(logliketrain)/size(train,1));
        for idx = 1:size(val,1)
            input = val(idx,:);
            T = length(input);
            [logalpha, logalphaScale] = forward(input, logA, logB, logp);
            loglikeval = cat(1,loglikeval,logsumexp(logalphaScale));
        end
        avgval = cat(1,avgval,logsumexp(loglikeval)/size(val,1));
        p = Pnew ./ sum(Pnew);
        A = Anew ./ repmat(sum(Anew,1),size(A,1),1);
        B = Bnew ./ repmat(sum(Bnew,2),1,size(B,2));
        if i > 1 & abs(1 - loglikeval(i-1)/loglikeval(i)) < 1e-6
            break;
        end
    end
end

