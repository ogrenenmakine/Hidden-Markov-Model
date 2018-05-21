clc;clear;
m = 2;
n = 25;
for i = 1:1
    createRandModel(n, m);
    [A, B, p] = readModel('model.txt',n,m);
    test = dlmread('testdata.txt');
    data = dlmread('data.txt');
    ll = randperm(length(data));
    train = data(1:(length(data)*4/5),:);
    val = data((length(data)*4/5)+1:length(data),:);
    [Amax, Bmax, h, hval] = baumwelch(train, val, A, B, p, n, m);
    obsv_prob(test, A, B, p, n)
    obsv_prob(test, Amax, Bmax, p, n)
    viterbi(test, A, B, p, n);
    plot(h)
    hold on;
    plot(hval)
end