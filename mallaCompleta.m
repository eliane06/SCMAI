
% %#########################################################################
% % %......................PRUEBAS POR MALLAS.................................
% % subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% % nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% % nit = transpose(nit);
% % nit = reshape(nit,[], 1);
% % 
% % subset(:,7) = ((subset(:, 7)).*nit)/145;
% % subset = [subset nit];
% % [subset, ia, ic] = unique(subset,'rows', 'stable');
% %  % Find out how many times each number occurs.
% % %data = rand(154027,8);
% % rng('default');
% % % Cross varidation (train: 70%, test: 30%)
% % cv = cvpartition(size(subset,1),'HoldOut',0.3);
% % % cv = cvpartition(size(subset, 1),'Kfold',3);
% % % idx = training(cv, 1);
% % idx = cv.test;
% % % Separate to training and test data
% % train = subset(~idx,:);
% % test  = subset(idx,:);
% % train_input = train(:, 1:6)
% % train_output = train(:,7)
% % test_input = test(:, 1:6)
% % test_output = test(:, 7)
% % 
% % opt = genfisOptions('SubtractiveClustering');
% % opt.ClusterInfluenceRange = 0.2;
% % %opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
% % %opt.DataScale = dataScale;
% % opt.SquashFactor = 1.25;
% % opt.AcceptRatio = 0.3;
% % opt.RejectRatio = 0.2;
% % %opt.Verbose = true;
% % %opt.CustomClusterCenters = ;
% % 
% % fis = genfis(train_input,train_output,opt);
% % %showrule(fis)
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % 
% % nit = test(:,8);
% % %nit = train(:,8);
% % %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% % actY1 = evalfis(train_input,fis)
% % actY2 = evalfis(test_input,fis)
% % % Calculate RMSE 
% % del = abs(actY2 - test_output);
% % %del = abs(actY - train_output);
% % rmse = sqrt(mean(del.^2))
% % [rho,pval] = corr(nit,actY2,'Type','Spearman')
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % filename = 'results.xlsx';
% % sheet = 2;
% % xlRange = 'A1';
% % train = [train actY1];
% % xlswrite(filename,train,sheet,xlRange);
% % xlRange = 'A107821';
% % test = [test actY2];
% % xlswrite(filename,test,sheet,xlRange);

%#########################################################################
%......................PRUEBAS MALLA 2006 Y PUNTOS 2010....................
% Separate to training and test data
% subset = mallas()
% train_input = subset(:, 1:6);
% train_output = subset(:,7);
% 
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.3;
% %opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
% %opt.DataScale = dataScale;
% opt.SquashFactor = 1.25;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% %opt.Verbose = true;
% %opt.CustomClusterCenters = ;
% 
% fis = genfis(train_input,train_output,opt);
% showrule(fis)
% 
% subsett = xlsread ('point extraction_iniciales.xlsx', 1, 'A3:H51344');
% test_input = subsett(:,2:7);
% test_output = subsett(:,8);
% plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, subsett(:, 1))

%#########################################################################
%...................PRUEBAS POR MALLAS (  )..............................
%subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
%nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
subset = entrenamientoDrastic;
nit = nt2006;
nit = transpose(nit);
nit = reshape(nit,[], 1);

subset(:,7) = ((subset(:, 7)).*nit)/145;
subset = [subset nit];
%[subset, ia, ic] = unique(subset,'rows', 'stable') si para que ande

[subset, ia, ic] = unique(subset,'rows', 'stable');
 % Find out how many times each number occurs.
subset(1,:) = [];
%rng('default');
% Cross varidation (train: 70%, test: 30%)
%cv = cvpartition(size(subset,1),'HoldOut',0.3);
cv = cvpartition(size(subset, 1),'Kfold',3);
rmse=[0, 0, 0]; r=[0, 0, 0];
sub = [];
for i=1:3
idx = training(cv, i);
%idx = cv.test;
% Separate to training and test data
train = subset(~idx,:);
test  = subset(idx,:);
train_input = train(:, 1:6)
train_output = train(:,7)
test_input = test(:, 1:6)
test_output = test(:, 7)

opt = genfisOptions('SubtractiveClustering');
opt.ClusterInfluenceRange = 0.2;
%opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
%opt.DataScale = dataScale;
opt.SquashFactor = 1.25;
opt.AcceptRatio = 0.3;
opt.RejectRatio = 0.2;
%opt.Verbose = true;
%opt.CustomClusterCenters = ;

fis = genfis(train_input,train_output,opt);
showrule(fis)
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% Evaluate FIS
nit = test(:,8);  %nit = train(:,8);
actY1 = evalfis(train_input,fis);
actY2 = evalfis(test_input,fis);
% Calculate RMSE 
del2 = abs(actY2 - test_output); del1 = abs(actY1 - train_output);
rmse1 = sqrt(mean(del1.^2)); rmse2 = sqrt(mean(del2.^2));
[rho,pval] = corr(nit,actY2,'Type','Spearman')
rmse(i) = rmse2;
sub = [sub actY2];
r(i)=rho;
%#### Almacenamiento de resultado ######
filename = 'resultsSFLK3.xlsx';
sheet = i;
xlRange = 'A1';
train = [train actY1];
xlswrite(filename,train,sheet,xlRange);
xlRange = 'A107821';
test = [test actY2];
xlswrite(filename,test,sheet,xlRange);
end;

% %##################################################################
% % % %......................PRUEBAS POR MALLAS.................................
% %subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% %nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% %nit = transpose(nit);
% %nit = reshape(nit,[], 1);
% 
% %subset(:,7) = ((subset(:, 7)).*nit)/145;
% %subset = [subset nit];
% %[subset, ia, ic] = unique(subset,'rows', 'stable');
%  % Find out how many times each number occurs.
% %data = rand(154027,8);
% %rng('default');
% % Cross varidation (train: 70%, test: 30%)
% %cv = cvpartition(size(subset,1),'HoldOut',0.3);
% %idx = cv.test;
% % Separate to training and test data
% %train = subset(~idx,:);
% %test  = subset(idx,:);
% train_input = train(:, 1:9);
% train_output = train(:,10);
% test_input = test(:, 1:9);
% test_output = test(:, 10);
% 
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.2;
% %opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
% %opt.DataScale = dataScale;
% opt.SquashFactor = 1.25;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% %opt.Verbose = true;
% %opt.CustomClusterCenters = ;
% 
% fis = genfis(train_input,train_output,opt);
% %showrule(fis)
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% nit_tr = train(:,11);
% nit_ts = test(:,11);
% nit2_ts = test(:,12);
% %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% actY1 = evalfis(train_input,fis);
% actY2 = evalfis(test_input,fis);
% % Calculate RMSE 
% del1 = abs(actY1 - train_output);
% del2 = abs(actY2 - test_output);
% rmse1 = sqrt(mean(del1.^2)) %rmse train
% rmse2 = sqrt(mean(del2.^2)) 
% [rho1,pval] = corr(nit_tr,actY1,'Type','Spearman') %rho NT2006 (train)
% [rho2,pval] = corr(nit_ts,actY2,'Type','Spearman') %rho NT2006
% [rho3,pval] = corr(nit2_ts,actY2,'Type','Spearman') %rho NT2010
% 
% in1 = find(test(:,14)); %2006
% in2 = find(test(:,15)); %2010
% in3 = find(test(:,13)==2018); %2018
% 
% [rho4,pval] = corr(test(in1,14),actY2(in1),'Type','Spearman')
% [rho5,pval] = corr(test(in2,15),actY2(in2),'Type','Spearman')
% [rho6,pval] = corr(NT18,actY2(in3),'Type','Spearman')
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% filename = 'results3.xlsx';
% sheet = 2;
% xlRange = 'A1';
% train = [train actY1];
% xlswrite(filename,train,sheet,xlRange);
% xlRange = 'A107796';
% test = [test actY2];
% xlswrite(filename,test,sheet,xlRange);



%##################################################################
%..................PRUEBAS POR MALLAS (DRASTCLUPVPxy)......................
%subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
%nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
%nit = transpose(nit);
%nit = reshape(nit,[], 1);

%subset(:,7) = ((subset(:, 7)).*nit)/145;
%subset = [subset nit];
%[subset, ia, ic] = unique(subset,'rows', 'stable');
 % Find out how many times each number occurs.
%data = rand(154027,8);
%rng('default');
% Cross varidation (train: 70%, test: 30%)
%cv = cvpartition(size(subset,1),'HoldOut',0.3);
%idx = cv.test;
% Separate to training and test data
%train = subset(~idx,:);
%test  = subset(idx,:);
% % train_input = train(:, 1:11);
% % train_output = train(:,12);
% % test_input = test(:, 1:11);
% % test_output = test(:, 12);
% % 
% % opt = genfisOptions('SubtractiveClustering');
% % opt.ClusterInfluenceRange = 0.2;
% % %opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
% % %opt.DataScale = dataScale;
% % opt.SquashFactor = 1.25;
% % opt.AcceptRatio = 0.3;
% % opt.RejectRatio = 0.2;
% % %opt.Verbose = true;
% % %opt.CustomClusterCenters = ;
% % 
% % fis = genfis(train_input,train_output,opt);
% % %showrule(fis)
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % nit_tr = train(:,13);
% % nit_ts = test(:,13);
% % nit2_ts = test(:,14);
% % %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% % actY1 = evalfis(train_input,fis);
% % actY2 = evalfis(test_input,fis);
% % % Calculate RMSE 
% % del1 = abs(actY1 - train_output);
% % del2 = abs(actY2 - test_output);
% % rmse1 = sqrt(mean(del1.^2)) %rmse train
% % rmse2 = sqrt(mean(del2.^2)) 
% % [rho1,pval] = corr(nit_tr,actY1,'Type','Spearman') %rho NT2006 (train)
% % [rho2,pval] = corr(nit_ts,actY2,'Type','Spearman') %rho NT2006
% % [rho3,pval] = corr(nit2_ts,actY2,'Type','Spearman') %rho NT2010
% % 
% % in1 = find(test(:,16)); %2006
% % in2 = find(test(:,17)); %2010
% % in3 = find(test(:,15)==2018); %2018
% % 
% % [rho4,pval] = corr(test(in1,16),actY2(in1),'Type','Spearman')
% % [rho5,pval] = corr(test(in2,17),actY2(in2),'Type','Spearman')
% % [rho6,pval] = corr(NT18,actY2(in3),'Type','Spearman')
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % filename = 'results4.xlsx';
% % sheet = 2;
% % xlRange = 'A1';
% % train = [train actY1];
% % xlswrite(filename,train,sheet,xlRange);
% % xlRange = 'A107928';
% % test = [test actY2];
% % xlswrite(filename,test,sheet,xlRange);

