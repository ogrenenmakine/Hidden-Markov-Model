clc;clear;
m = 2;
n = 25;
for i = 1:10
    createRandModel(n, m);
    [A, B, p] = readModel('model.txt',n,m);
    test = dlmread('testdata.txt');
    obsv_prob(test, A, B, p, n)
    viterbi(test, A, B, p, n);
    data = dlmread('data.txt');
    [A, B, h] = baumwelch(data, A, B, p, n, m);
    obsv_prob(test, A, B, p, n)
    plot(exp(h))
    hold on;
end