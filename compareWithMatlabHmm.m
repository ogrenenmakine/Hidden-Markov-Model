clear;clc;
eSize = 2;
hidden = 2;
createModel(hidden, eSize, true);
[A, B, p] = readModel('model.txt');
data = dlmread('data.txt');
test = dlmread('testdata.txt');
[Anew, Bnew, pnew, avgtrain] = baumwelch(data, A, B, p);
plot(avgtrain)
viterbi(test, A, B, p);
hmmviterbi(test+1, A, B);
viterbi(test, Anew, Bnew, p);
hmmviterbi(test+1, Anew, Bnew);
[An, Bn] = hmmtrain(data+1, A, B, 'tolerance', 1e-4);
[PSTATES,logpseq] = hmmdecode(test+1,A,B);
exp(logpseq)
[PSTATES,logpseq] = hmmdecode(test+1,An,Bn);
exp(logpseq)
[logalpha, logalphaScale] = forward(test, log(A), log(B), log(p));
exp(-sum(logalphaScale))
[logalpha, logalphaScale] = forward(test, log(Anew), log(Bnew), log(pnew));
exp(-sum(logalphaScale))