clc;clear;
ctrain = false;
fprintf('Your commands, sir?\n(0)Predefined type:predefined\n(1)Random initialization type:random\n(2)For observation probability of test sequence type:obsv_prob\n(3)For best state sequence type:viterbi\n(4)To train the model type:learn\n(5)To exit type:exit\n');
while true
    prompt = 'type:';
    cm = input(prompt,'s');
    if strcmp(cm,'predefined')
        m = 2;
        n = 2;
        createRandModel(n, m, true);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
        obs_prob = exp(obsv_prob(test, log(A), B, log(p), n))
        bestpath = viterbi(test, A, B, p, n)
    elseif strcmp(cm,'random')
        m = 2;
        n = 25;
        createRandModel(n, m, false);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
    elseif strcmp(cm,'obsv_prob') & ctrain == false
        exp(obsv_prob(test, log(A), B, log(p), n))
    elseif strcmp(cm,'obsv_prob') & ctrain == true
        exp(obsv_prob(test, Amax, Bmax, logp, n))
    elseif strcmp(cm,'viterbi')
        viterbi(test, A, B, p, n)
    elseif strcmp(cm,'learn')
        data = dlmread('data.txt');
        ll = randperm(length(data));
        train = data(1:(length(data)*4/5),:);
        val = data((length(data)*4/5)+1:length(data),:);
        [Amax, Bmax, logp, h, hval] = baumwelch(train, val, A, B, p, n, m);
        previous_probability = exp(obsv_prob(test, log(A), B, log(p), n))
        aftertraining_probability = exp(obsv_prob(test, Amax, Bmax, logp, n))
        plot(h)
        hold on;
        plot(hval)
        ctrain = true;
    elseif strcmp(cm,'exit')
        break
    else
        continue
    end
end