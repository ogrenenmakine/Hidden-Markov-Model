clc;clear;
m = 2;
n = 2;
createRandModel(n, m);
[A, B, p] = readModel('model.txt',n,m);
test = dlmread('testdata.txt');
ctrain = false;
fprintf('Your commands, sir?\n(0)Refresh A and B type: refresh\n(1)For observation probability of test sequence type:obsv_prob\n(2)For best state sequence type:viterbi\n(3)To train the model type:learn\n(4)To exit type:exit\n');
while true
    prompt = 'type:';
    cm = input(prompt,'s');
    if strcmp(cm,'refresh')
        createRandModel(n, m);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
    elseif strcmp(cm,'obsv_prob')
        exp(obsv_prob(test, log(A), B, log(p), n))
    elseif strcmp(cm,'viterbi')
        viterbi(test, A, B, p, n)
    elseif strcmp(cm,'learn')
        data = dlmread('data.txt');
        ll = randperm(length(data));
        train = data(1:(length(data)*4/5),:);
        val = data((length(data)*4/5)+1:length(data),:);
        [A, B, logp, h, hval] = baumwelch(train, val, A, B, p, n, m);
        p = exp(logp);
        A = exp(A);
        plot(h)
        hold on;
        ctrain = true;
    elseif strcmp(cm,'exit')
        break
    else
        continue
    end
end