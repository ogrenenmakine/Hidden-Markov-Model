clc;clear;close all;
m = 2;
n = 2;
for i = 1:1
    createRandModel(n, m);
    [A, B, p] = readModel('model.txt',n,m);
    test = dlmread('testdata.txt');
    data = dlmread('data.txt');
    ll = randperm(length(data));
    train = data(1:(length(data)*4/5),:);
    val = data((length(data)*4/5)+1:length(data),:);
    [Amax, Bmax, logp, h, hval] = baumwelch(train, val, A, B, p, n, m);
    exp(obsv_prob(test, log(A), B, log(p), n))
    exp(obsv_prob(test, Amax, Bmax, logp, n))
    viterbi(test, A, B, p, n)
    hmmviterbi(test+1,A,B)
    plot(h)
    hold on;
    plot(hval)
end