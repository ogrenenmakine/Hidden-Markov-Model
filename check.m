clc;clear;close all;
n = 2; m = 2;
createRandModel(n, m);
[A, B, p] = readModel('model.txt',n,m);
test = dlmread('testdata.txt');
data = dlmread('data.txt');
ll = randperm(length(data));
train = data(1:(length(data)*4/5),:);
val = data((length(data)*4/5)+1:length(data),:);
hmmviterbi(test+1,A,B)