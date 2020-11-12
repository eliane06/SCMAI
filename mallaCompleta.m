
% %#########################################################################
% % %......................PRUEBAS POR MALLAS.................................
subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
nit = transpose(nit);
nit = reshape(nit,[], 1);

subset(:,7) = ((subset(:, 7)).*nit)/145;
subset = [subset nit];
[subset, ia, ic] = unique(subset,'rows', 'stable');
 % Find out how many times each number occurs.
%data = rand(154027,8);
rng('default');
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(subset,1),'HoldOut',0.3);
% cv = cvpartition(size(subset, 1),'Kfold',3);
% idx = training(cv, 1);
idx = cv.test;
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
%showrule(fis)
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))

nit = test(:,8);
%nit = train(:,8);
%[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
actY1 = evalfis(train_input,fis)
actY2 = evalfis(test_input,fis)
% Calculate RMSE 
del = abs(actY2 - test_output);
%del = abs(actY - train_output);
rmse = sqrt(mean(del.^2))
[rho,pval] = corr(nit,actY2,'Type','Spearman')
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
filename = 'results.xlsx';
sheet = 2;
xlRange = 'A1';
train = [train actY1];
xlswrite(filename,train,sheet,xlRange);
xlRange = 'A107821';
test = [test actY2];
xlswrite(filename,test,sheet,xlRange);

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
%.........................PRUEBAS POR MALLAS..............................
% subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% nit = transpose(nit);
% nit = reshape(nit,[], 1);
% 
% subset(:,7) = ((subset(:, 7)).*nit)/145;
% subset = [subset nit];
% %[subset, ia, ic] = unique(subset,'rows', 'stable') si para que ande
% 
% [subset, ia, ic] = unique(subset,'rows', 'stable');
%  % Find out how many times each number occurs.
% 
% %rng('default');
% % Cross varidation (train: 70%, test: 30%)
% %cv = cvpartition(size(subset,1),'HoldOut',0.3);
% cv = cvpartition(size(subset, 1),'Kfold',3);
% rmse, r  = [0, 0, 0];
% sub = [];
% for i=1:3
% idx = training(cv, i);
% %idx = cv.test;
% % Separate to training and test data
% train = subset(~idx,:);
% test  = subset(idx,:);
% train_input = train(:, 1:6)
% train_output = train(:,7)
% test_input = test(:, 1:6)
% test_output = test(:, 7)
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
% showrule(fis)
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % Evaluate FIS
% nit = test(:,8);
% actY = evalfis(test_input,fis);
% sub = [sub test actY];
% % Calculate RMSE 
% del = actY - test_output;
% rmse(i) = sqrt(mean(del.^2));
% [rho,pval] = corr(nit,actY,'Type','Spearman');
% r(i)=rho;
% 
% end
