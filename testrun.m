clear;clc;
eSize = 2;
hidden = 25;
createModel(hidden, eSize, true);
[A, B, p] = readModel('model.txt', hidden, eSize);
data = dlmread('data.txt');
test = dlmread('testdata.txt');
[Anew, Bnew, pnew, avgtrain] = baumwelch(data, A, B, p);
plot(avgtrain)
viterbi(test, A, B, p)
hmmviterbi(test, A, B)
