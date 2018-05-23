function [A, B, p, avgtrain] = baumwelch(train, A, B, p)
    % baumwelch EM algorithm
    % train: nObsxT, sequence
    % A: NxN, trasition matrix
    % B: NxM, emission matrix
    % p: Nx1, prior probabilities
    % output parameters
    % A: NxN, trasition matrix
    % B: NxM, emission matrix
    % p: Nx1, prior probabilities
    % avgtrain: the average loglikehood over the dataset per iteration
    % logliketrain: the loglikelihood in each step
    avgtrain = 0;
    for i = 1:1000
        logliketrain = 0;
        logA = log(A);
        logB = log(B);
        logp = log(p);
        Pnew = zeros(size(logp)) + eps;
        Anew = zeros(size(logA)) + eps;
        Bnew = zeros(size(logB)) + eps;
        T = size(train,2);
        [N, M] = size(B);
        for idx = 1:size(train,1)
            input = train(idx,:);
            % forward and backward algorithms
            [logalpha, logalphaScale] = forward(input, logA, logB, logp);
            logbeta = backward(input, logA, logB, logalphaScale);
            % gamma, P(qt=Si|O,\lambda)
            loggamma = logalpha + logbeta;
            gamma = exp(loggamma - logsumexp(loggamma));
            % update p, the prior probabilities
            Pnew = Pnew + gamma(:,1);
            % update A, the transitionmatrix
            chi = zeros(size(A,1));
            for t = 1:(T-1)
                tmp = (exp(logalpha(:,t))*exp(((logbeta(:,t+1) + logB(:,input(t+1)+1))'))).*A;
                chi = chi + tmp / sum(sum(tmp));
            end
            Anew = Anew + chi;
            % update B, the emission matrix
            for k = 1:size(B,2)
                Bnew(:,k) = Bnew(:,k) + sum(gamma(:,(input+1)==k),2);
            end
            logliketrain = cat(1,logliketrain,-sum(logalphaScale));
        end
        avgtrain = cat(1,avgtrain,sum(logliketrain)/size(train,1));
        % normalization of updated matrices
        p = Pnew ./ sum(Pnew);
        A = Anew ./ repmat(sum(Anew,2),1,size(A,2));
        B = Bnew ./ repmat(sum(Bnew,2),1,size(B,2));
        % convergence break rule
        if abs(1 - avgtrain(i)/avgtrain(i+1)) < 1e-4
            break;
        end
    end
end