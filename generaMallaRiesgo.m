%#######Generación de malla#######
subsetT = entrenamientoDrastic;
nit = nt2006;
nit2 = nt2010;
%actY2 = xlsread ('results.xlsx', 2, 'I107821:I154028');
%actY2 = find(actY2);
%actY2 = resultsS1; %SFL
%actY2 = resultsS2; %NF
%actY2 = resultsS3; %ANN
actY2 = resultsSCMAI; %SCMAI
nit = transpose(nit);
nit = reshape(nit,[], 1);
%nit2 = xlsread('Mallas\nt2010.xlsx', 1, 'A1:WQ684');
nit2 = transpose(nit2);
nit2 = reshape(nit2,[], 1);

subsetT(:,7) = ((subsetT(:, 7)).*nit)/145;
subsetT = [subsetT nit zeros(420660,1)];
subsetT(:,9) = -9999;
[subset, ia, ic] = unique(subsetT,'rows','stable');
rng('default');
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(subset,1),'HoldOut',0.30);
idx = cv.test;


cont = 1; c=1;
for j=1:size(ia,1)
    if idx(j) == 1
        subsetT(ia(j),9) = abs(actY2(cont));
        nit2_unic(cont) = nit2(ia(j),1);
        cont = cont + 1;
        nit_unic(c) = nit(ia(j),1);
        c = c + 1;
    end
    nit2_train_test(j) = nit2(ia(j),1);
end

%###### Almacenamiento de nt2010 #####
%filename = 'riesgoSFL.xlsx';
%filename = 'riesgoSFL.xlsx';
%filename = 'riesgoANN.xlsx';
%filename = 'riesgoSCMAI.xlsx';
sheet = 1;
xlRange = 'A1';
riesgo = transpose(reshape(subsetT(:,9), [615, 684]));
%xlswrite(filename,riesgo,sheet,xlRange);

nit2_unic = transpose(nit2_unic);
%###### Calculo correlaciones #######
[rho,pval] = corr(actY2,nit2_unic,'Type','Spearman')
[rho,pval] = corr(resultsS2,nit2_unic,'Type','Spearman')

[rho,pval] = corr(resultsS1,transpose(nit_unic),'Type','Spearman')
[rho,pval] = corr(resultsS2,transpose(nit_unic),'Type','Spearman')
[rho,pval] = corr(resultsS3,transpose(nit_unic),'Type','Spearman')

[rho,pval] = corr(nit,nit2,'Type','Spearman')
[rho,pval] = corr(transpose(nit_unic),nit2_unic,'Type','Spearman')
[rho,pval] = corr(transpose(nit2_train_test),subset(:,8),'Type','Spearman')




