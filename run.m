clc;clear;
m = 2;
n = 25;
for i = 1:1
    createRandModel(n, m);
    [A, B, p] = readModel('model.txt',n,m);
    test = dlmread('testdata.txt');
    exp(obsv_prob(test, A, B, p, n))
    viterbi(test, A, B, p, n);
    data = dlmread('data.txt');
    [A, B, h] = baumwelch(data, A, B, p, n, m);
    exp(obsv_prob(test, A, B, p, n))
    plot(h)
    hold on;
end