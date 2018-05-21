function [logp, logt, phi] = maximization(o, delta, gamma, phi, n, m)
    logp = log(gamma(1,:) ./ sum(gamma(1,:)))';
    logt = log(reshape(sum(delta,1),n,n) ./ repmat(sum(reshape(sum(delta,1),n,n),2),1,n));
    for i = 1:n
        ph = phi(i,:);
        ph(:) = 0;
        for j = 1:n
            ph(o(j)+1) = ph(o(j)+1) + gamma(j,i);
        end
        phi(i,:) = ph(:) / sum(ph);
    end
end
