clc
clear all
close all
warning off all

load lbp_pix
load target

net_cbir2 = newff(minmax(lbp_pix),[140 150 1],{'logsig','logsig','purelin'},'trainrp');
net_cbir2.trainParam.show = 1000;
net_cbir2.trainParam.lr = 0.03;
net_cbir2.trainParam.epochs = 20000;

net_cbir2.trainParam.goal = 1e-3;
% net_cbir.trainParam.mu = 1;
% net_cbir.trainParam.mu_dec = 0.8;
% net_cbir.trainParam.mu_inc = 1.5;
%net.trainParam.mu_max

net_cbir2.divideFcn='dividerand';
net_cbir2.divideParam.trainRatio = 90/100;
net_cbir2.divideParam.valRatio = 0/100;
net_cbir2.divideParam.testRatio = 10/100;

[net_cbir2,tr] = train(net_cbir2,lbp_pix,target);

save net_cbir2 net_cbir2


 y = round(sim(net_cbir2,lbp_pix));




