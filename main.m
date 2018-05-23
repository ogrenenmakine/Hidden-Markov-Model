clc;clear;
ctrain = false;
fprintf('Your commands, sir?\n(0)Predefined type:predefined\n(1)Random initialization type:random\n(2)For observation probability of test sequence type:obsv_prob\n(3)For best state sequence type:viterbi\n(4)To train the model type:learn\n(5)To exit type:exit\n');
while true
    prompt = 'type:';
    cm = input(prompt,'s');
    data = dlmread('data.txt');
    test = dlmread('testdata.txt');
    if strcmp(cm,'predefined')
        m = 2;
        n = 2;
        createModel(n, m, true);
        [A, B, p] = readModel('model.txt',n,m);
        [~, obs_prob] = forward(test, log(A), log(B), log(p));
        obs_prob = exp(-sum(obs_prob))
        bestpath = viterbi(test, A, B, p)
        ctrain = false;
    elseif strcmp(cm,'random')
        m = 2;
        prompt2 = 'Enter the number of hidden states:';
        n = input(prompt2);
        createModel(n, m, false);
        [A, B, p] = readModel('model.txt',n,m);
        ctrain = false;
    elseif strcmp(cm,'obsv_prob') & ctrain == false
        [~, obs_prob] = forward(test, log(A), log(B), log(p));
        obs_prob = exp(-sum(obs_prob))
    elseif strcmp(cm,'obsv_prob') & ctrain == true
        [~, obs_prob] = forward(test, log(Anew), log(Bnew), log(pnew));
        obs_prob_aftertrain = exp(-sum(obs_prob))
    elseif strcmp(cm,'viterbi') & ctrain == false
        bestpath = viterbi(test, A, B, p)
    elseif strcmp(cm,'viterbi') & ctrain == true
        bestpathaftertraining = viterbi(test, Anew, Bnew, pnew)
    elseif strcmp(cm,'learn')
        [Anew, Bnew, pnew, avgtrain] = baumwelch(data, A, B, p);
        [~, previous_probability] = forward(test, log(A), log(B), log(p));
        obs_prob = exp(-sum(previous_probability))
        [~, aftertraining_probability] = forward(test, log(Anew), log(Bnew), log(pnew));
        obs_prob_aftertrain = exp(-sum(aftertraining_probability))
        figure
        plot(avgtrain)
        ctrain = true;
    elseif strcmp(cm,'exit')
        break
    else
        continue
    end
end