clc;clear;
ctrain = false;
fprintf('Your commands, sir?\n(0)Predefined type:predefined\n(1)Random initialization type:random\n(2)For observation probability of test sequence type:obsv_prob\n(3)For best state sequence type:viterbi\n(4)To train the model type:learn\n(5)To exit type:exit\n');
while true
    prompt = 'type:';
    cm = input(prompt,'s');
    if strcmp(cm,'predefined')
        m = 2;
        n = 2;
        createModel(n, m, true);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
        [~, obs_prob] = forward(test, log(A), log(B), log(p));
        logsumexp(obs_prob)
        bestpath = viterbi(test, A, B, p)
    elseif strcmp(cm,'random')
        m = 2;
        prompt = 'Enter the number of hidden states:';
        m = input(prompt);
        createModel(n, m, false);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
    elseif strcmp(cm,'obsv_prob') & ctrain == false
        [~, obs_prob] = forward(test, log(A), log(B), log(p));
        logsumexp(obs_prob)
    elseif strcmp(cm,'obsv_prob') & ctrain == true
        [~, obs_prob] = forward(test, log(Amax), log(Bmax), log(pmax));
        logsumexp(obs_prob)
    elseif strcmp(cm,'viterbi') & ctrain == false
        bestpath = viterbi(test, A, B, p)
    elseif strcmp(cm,'viterbi') & ctrain == true
        bestpath = viterbi(test, Anew, Bnew, pnew)
    elseif strcmp(cm,'learn')
        data = dlmread('data.txt'); rlist = randperm(length(data));
        train = data(rlist(1:(length(data)*4/5)),:);
        val = data(rlist((length(data)*4/5)+1:length(data)),:);
        [Anew, Bnew, pnew, avgtrain, avgval, logliketrain, loglikeval] = baumwelch(train, val, A, B, p);
        [~, previous_probability] = forward(test, log(A), log(B), log(p));
        logsumexp(previous_probability)
        [~, aftertraining_probability] = forward(test, log(A), log(B), log(p));
        logsumexp(aftertraining_probability)
        figure
        plot(avgtrain)
        hold on;
        plot(avgval)
        hold off;
        figure
        plot(logliketrain)
        hold on;
        plot(loglikeval)
        hold off;
        ctrain = true;
    elseif strcmp(cm,'exit')
        break
    else
        continue
    end
end