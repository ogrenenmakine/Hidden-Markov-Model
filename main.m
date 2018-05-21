clc;clear;
m = 2; % alphabet length
prompt = 'What is the number of hidden states? \n';
n = input(prompt);
createRandModel(n, m);
[A, B, p] = readModel('model.txt',n,m);
test = dlmread('testdata.txt');
while true
    prompt = 'Your commands, sir?\n(0)Refresh A and B type: refresh\n(1)For observation probability of test sequence type:obsv_prob\n(2)For best state sequence type:virterbi\n(3)To train the model type:learn\n(4)To exit type:exit\n';
    cm = input(prompt,'s');
    if strcmp(cm,'refresh')
        createRandModel(n, m);
        [A, B, p] = readModel('model.txt',n,m);
        test = dlmread('testdata.txt');
    elseif strcmp(cm,'obsv_prob')
        obsv_prob(test, A, B, p, n)
    elseif strcmp(cm,'viterbi')
        viterbi(test, A, B, p, n)
    elseif strcmp(cm,'learn')
        data = dlmread('data.txt');
        [A, B, h] = baumwelch(data, A, B, p, n, m);
        plot(h)
        hold on;
    elseif strcmp(cm,'exit')
        break
    else
        continue
    end
end