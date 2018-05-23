clear;clc;
eSize = 2;
hidden = 25;
createModel(hidden, eSize, true);
[A, B, p] = readModel('model.txt', hidden, eSize);
data = dlmread('data.txt'); rlist = randperm(length(data));
train = data(rlist(1:(length(data)*4/5)),:);
val = data(rlist((length(data)*4/5)+1:length(data)),:);
[Anew, Bnew, pnew, avgtrain, avgval, logliketrain, loglikeval] = baumwelch(train, val, A, B, p);
plot(avgtrain)
hold on;
plot(avgval)

viterbi(test, val, A, B, p)

