% filename = 'NT2006_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: N72' ;
% subset = xlsread (filename, hoja, xlRange);
% input = subset(:,1:9);
% output = subset(:,10); 
% opt = genfisOptions('FCMClustering', 'FISType', 'sugeno');
% trnData = [];
% trnData = [trnData subset(:,1:10)];
% 
% filename = 'NT2010_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'F2: O25' ;
% subset = xlsread (filename, hoja, xlRange);
% chkData = [];
% chkData = [chkData subset(:,1:10)];
% 
% opt.NumClusters = 'auto';
% opt.Verbose = 0;
% fismat = genfis(trnData(:,1:end-1),trnData(:,end), opt);
%  
% % figure(2)
% % subplot(2,2,1)
% % plotmf(fismat,'input',1)
% % subplot(2,2,2)
% % plotmf(fismat,'input',2)
% % subplot(2,2,3)
% % plotmf(fismat,'input',3)
% % subplot(2,2,4)
% % plotmf(fismat,'input',4)
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',chkData);
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% [fis1,error1,ss,fis2,error2] = anfis(trnData,opt);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData,opt);
% 
% % figure(3)
% % subplot(2,2,1)
% % plotmf(fis2,'input',1)
% % subplot(2,2,2)
% % plotmf(fis2,'input',2)
% % subplot(2,2,3)
% % plotmf(fis2,'input',3)
% % subplot(2,2,4)
% % plotmf(fis2,'input',4)
% 
% figure(4)
% plot([error1 error2])
% hold on
% plot([error1 error2],'o')
% legend('Train Error','Validation error')
% xlabel('Epochs')
% ylabel('RMSE (Root Mean Squared Error)')
% title('Error Curves')
% 
% %figure(5)
% anfis_output = evalfis(chkData(:,1:9), fis1)
% %disp(anfis_output)

% index = 125:1124;
% subplot(2,1,1)
% plot(time(index),[x(index) anfis_output])
% xlabel('Time (sec)')
% title('MG Time Series and ANFIS Prediction')
% 
% subplot(2,1,2)
% plot(time(index),x(index) - anfis_output)
% xlabel('Time (sec)')
% title('Prediction Errors')



%#################################################################

% filename = 'NT-completo.xls' ;
% hoja = 2;
% xlRange = 'E4: K74' ;
% subset = xlsread (filename, hoja, xlRange);
% input = subset(:,1:7);
% output = subset(:,7); 
% trnData = [];
% trnData = [trnData subset(:,1:7)];
% 
% 
% filename = 'NT-completo.xls' ;
% hoja = 2;
% xlRange =  'D75: K98';
% subset = xlsread (filename, hoja, xlRange);
% chkData = [];
% chkData = [chkData subset(:,2:8)];
% 
% %opt = genfisOptions('FCMClustering', 'FISType', 'sugeno');
% %opt.NumClusters = 8;
% %opt.Verbose = 0;
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.2;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% fismat = genfis(trnData(:,1:end-1),trnData(:,end), opt);
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',chkData);
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% %fis = anfis(trnData);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% [fis1,error1,ss,fis2,error2] = anfis(trnData,opt);
% 
% 
% %  figure(4)
% %  plot([error1 error2])
% %  hold on
% %  plot([error1 error2],'o')
% %  legend('Train Error','Validation error')
% %  xlabel('Epochs')
% %  ylabel('RMSE (Root Mean Squared Error)')
% %  title('Error Curves')
% 
% %figure(5)
% %anfis_output = evalfis(chkData(:,2:10), fis2);
% %disp(anfis_output)
% inputs = chkData(:,1:6);
% plotActualAndExpectedResultsWithRMSE(fis2,inputs,subset(:,8),subset(:,1))



%########################################################################
%......................PRUEBAS POR MALLAS.................................
% % subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% % nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% % nit = transpose(nit);
% % nit = reshape(nit,[], 1);
% % 
% % subset(:,7) = ((subset(:, 7)).*nit)/145;
% % subset = [subset nit];
% % [subset, ia, ic] = unique(subset,'rows', 'stable');
% % 
% % rng('default');
% % % Cross varidation (train: 70%, test: 30%)
% % cv = cvpartition(size(subset,1),'HoldOut',0.3);
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
% % opt.AcceptRatio = 0.3;
% % opt.RejectRatio = 0.2;
% % fismat = genfis(train_input,train_output, opt);
% % 
% % opt = anfisOptions('InitialFIS',fismat,'ValidationData',test(:, 1:7));
% % 
% % opt.DisplayANFISInformation = 1;
% % opt.DisplayErrorValues = 1;
% % opt.DisplayStepSize = 1;
% % opt.DisplayFinalResults = 1;
% % 
% % %fis = anfis(trnData);
% % %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% % [fis1,error1,ss,fis2,error2] = anfis(train(:,1:7),opt);
% % 
% % %figure(5)
% % %anfis_output = evalfis(chkData(:,2:10), fis2);
% % %disp(anfis_output)
% % %plotActualAndExpectedResultsWithRMSE(fis2,test_input,test_output,test(:,8))
% % nit = test(:,8);
% % %nit = train(:,8);
% % %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% % actY1 = evalfis(train_input,fis1)
% % actY2 = evalfis(test_input,fis2)
% % % Calculate RMSE 
% % del = abs(actY2 - test_output);
% % %del = abs(actY - train_output);
% % rmse = sqrt(mean(del.^2))
% % [rho,pval] = corr(nit,actY2,'Type','Spearman')
% % %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% % %#### Almacenamiento de resultado ######
% % filename = 'results.xlsx';
% % sheet = 3;
% % xlRange = 'A1';
% % train = [train actY1];
% % xlswrite(filename,train,sheet,xlRange);
% % xlRange = 'A107821';
% % test = [test actY2];
% % xlswrite(filename,test,sheet,xlRange);

%#### 

%#########################################################################
%........................PRUEBAS POR MALLAS(2)...............................
% subset = mallas()
% train_input = subset(:, 1:6);
% train_output = subset(:,7);
% 
% subsett = xlsread ('point extraction_iniciales.xlsx', 1, 'A3:H51344');
% test_input = subsett(:,2:7);
% test_output = subsett(:,8);
% 
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.2;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% fismat = genfis(train_input,train_output, opt);
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',test(:, 1:7));
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% %fis = anfis(trnData);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% [fis1,error1,ss,fis2,error2] = anfis(train(:,1:7),opt);
% 
% %figure(5)
% %anfis_output = evalfis(chkData(:,2:10), fis2);
% %disp(anfis_output)
% plotActualAndExpectedResultsWithRMSE(fis2,test_input,test_output,subsett(:,1))


%#########################################################################
% filename = 'Pozos061018_union_NT2006.xlsx' ;
% hoja = 1;
% xlRange = 'G4:Q164' ;
% subset = xlsread(filename, hoja, xlRange);
% 
% rng('default');
% cv = cvpartition(size(subset,1),'HoldOut',0.30);
% % cv = cvpartition(size(subset, 1),'Kfold',3);
% %rng('default');
% % idx = training(cv, 1);
% idx = cv.test;
% % % Separate to training and test data
% train = subset(~idx,:);
% test = subset(idx,:);
% %opt = genfisOptions('FCMClustering', 'FISType', 'sugeno');
% %opt.NumClusters = 8;
% %opt.Verbose = 0;
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.5;
% opt.SquashFactor = 1.15;
% opt.AcceptRatio = 0.35;
% opt.RejectRatio = 0.1;
% opt.DataScale = [2.572120	4.763780	8.000000	1.000000	0.000000	0.165810	0.098730;
% 26.366600	7.746770	9.000000	5.000000	14.672300	1.674560	17.493886];
% 
% fismat = genfis(train(:,1:6),train(:,10), opt);
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',[test(:,1:6) test(:,10)]);
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% %fis = anfis(trnData);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% [fis1,error1,ss,fis2,error2] = anfis(train(:,1:7),opt);
% 
% plotActualAndExpectedResultsWithRMSE(fis2,test(:,1:6),test(:,10),test(:,11))


% %....................PRUEBAS POR MALLAS (DRASTCPLUVP)......................
% %subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% %nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% %nit = transpose(nit);
% %nit = reshape(nit,[], 1);
% 
% %subset(:,7) = ((subset(:, 7)).*nit)/145;
% %subset = [subset nit];
% %[subset, ia, ic] = unique(subset,'rows', 'stable');
% 
% %rng('default');
% % Cross varidation (train: 70%, test: 30%)
% %cv = cvpartition(size(subset,1),'HoldOut',0.3);
% %idx = cv.test;
% % Separate to training and test data
% %train = subset(~idx,:);
% %test  = subset(idx,:);
% train_input = train(:, 1:9)
% train_output = train(:,10)
% test_input = test(:, 1:9)
% test_output = test(:, 10)
% 
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.2;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% fismat = genfis(train_input,train_output, opt);
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',test(:, 1:10));
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% %fis = anfis(trnData);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% [fis1,error1,ss,fis2,error2] = anfis(train(:,1:10),opt);
% 
% %figure(5)
% %anfis_output = evalfis(chkData(:,2:10), fis2);
% %disp(anfis_output)
% %plotActualAndExpectedResultsWithRMSE(fis2,test_input,test_output,test(:,8))
% nit_tr = train(:,11);
% nit_ts = test(:,11);
% nit2_ts = test(:,12);
% %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% actY1 = evalfis(train_input,fis1)
% actY2 = evalfis(test_input,fis2)
% % Calculate RMSE 
% del1 = abs(actY1 - train_output);
% del2 = abs(actY2 - test_output);
% rmse1 = sqrt(mean(del1.^2))
% rmse2 = sqrt(mean(del2.^2))
% [rho1,pval] = corr(nit_tr,actY1,'Type','Spearman')
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
% %#### Almacenamiento de resultado ######
% filename = 'results3.xlsx';
% sheet = 3;
% xlRange = 'A1';
% train = [train actY1];
% xlswrite(filename,train,sheet,xlRange);
% xlRange = 'A107796';
% test = [test actY2];
% xlswrite(filename,test,sheet,xlRange);

%....................PRUEBAS POR MALLAS (DRASTCPLUVPxy)......................
%subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
%nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
%nit = transpose(nit);
%nit = reshape(nit,[], 1);

%subset(:,7) = ((subset(:, 7)).*nit)/145;
%subset = [subset nit];
%[subset, ia, ic] = unique(subset,'rows', 'stable');

%rng('default');
% Cross varidation (train: 70%, test: 30%)
%cv = cvpartition(size(subset,1),'HoldOut',0.3);
%idx = cv.test;
% Separate to training and test data
%train = subset(~idx,:);
%test  = subset(idx,:);
% train_input = train(:, 1:11)
% train_output = train(:,12)
% test_input = test(:, 1:11)
% test_output = test(:, 12)
% 
% opt = genfisOptions('SubtractiveClustering');
% opt.ClusterInfluenceRange = 0.2;
% opt.AcceptRatio = 0.3;
% opt.RejectRatio = 0.2;
% fismat = genfis(train_input,train_output, opt);
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',test(:, 1:12));
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% %fis = anfis(trnData);
% %[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
% [fis1,error1,ss,fis2,error2] = anfis(train(:,1:12),opt);
% 
% %figure(5)
% %anfis_output = evalfis(chkData(:,2:10), fis2);
% %disp(anfis_output)
% %plotActualAndExpectedResultsWithRMSE(fis2,test_input,test_output,test(:,8))
% nit_tr = train(:,13);
% nit_ts = test(:,13);
% nit2_ts = test(:,14);
% %[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% actY1 = evalfis(train_input,fis1)
% actY2 = evalfis(test_input,fis2)
% % Calculate RMSE 
% del1 = abs(actY1 - train_output);
% del2 = abs(actY2 - test_output);
% rmse1 = sqrt(mean(del1.^2))
% rmse2 = sqrt(mean(del2.^2))
% [rho1,pval] = corr(nit_tr,actY1,'Type','Spearman')
% [rho2,pval] = corr(nit_ts,actY2,'Type','Spearman') %rho NT2006
% [rho3,pval] = corr(nit2_ts,actY2,'Type','Spearman') %rho NT2010
% 
% in1 = find(test(:,16)); %2006
% in2 = find(test(:,17)); %2010
% in3 = find(test(:,15)==2018); %2018
% 
% [rho4,pval] = corr(test(in1,16),actY2(in1),'Type','Spearman')
% [rho5,pval] = corr(test(in2,17),actY2(in2),'Type','Spearman')
% [rho6,pval] = corr(NT18,actY2(in3),'Type','Spearman')
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% %#### Almacenamiento de resultado ######
% filename = 'results4.xlsx';
% sheet = 3;
% xlRange = 'A1';
% train = [train actY1];
% xlswrite(filename,train,sheet,xlRange);
% xlRange = 'A107928';
% test = [test actY2];
% xlswrite(filename,test,sheet,xlRange);


%################%########################################################################
%.............PRUEBAS POR MALLAS (CV Partitio).............................
subset = entrenamientoDrastic;
nit = nt2006;
nit = transpose(nit);
nit = reshape(nit,[], 1);

subset(:,7) = ((subset(:, 7)).*nit)/145;
subset = [subset nit];
[subset, ia, ic] = unique(subset,'rows','stable');
subset(1,:) = [];
cv = cvpartition(size(subset, 1),'Kfold',3);
rmse=[0, 0, 0]; r  = [0,0,0]; sub = [];
for i=1:3
idx = training(cv, i);
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(subset,1),'HoldOut',0.3);
idx = cv.test;
% Separate to training and test data
train = subset(~idx,:);
test  = subset(idx,:);
train_input = train(:, 1:6);
train_output = train(:,7);
test_input = test(:, 1:6);
test_output = test(:, 7);

opt = genfisOptions('SubtractiveClustering');
opt.ClusterInfluenceRange = 0.2;
opt.AcceptRatio = 0.3;
opt.RejectRatio = 0.2;
fismat = genfis(train_input,train_output, opt);

opt = anfisOptions('InitialFIS',fismat,'ValidationData',test(:, 1:7));

opt.DisplayANFISInformation = 1;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 1;
opt.DisplayFinalResults = 1;

%[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
[fis1,error1,ss,fis2,error2] = anfis(train(:,1:7),opt);

%[actY,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(test_input,fis);
% Evaluate FIS
nit = test(:,8);  %nit = train(:,8);
actY1 = evalfis(train_input,fis1);
actY2 = evalfis(test_input,fis2);
% Calculate RMSE 
del2 = abs(actY2 - test_output); del1 = abs(actY1 - train_output);
rmse1 = sqrt(mean(del1.^2)); rmse2 = sqrt(mean(del2.^2));
[rho,pval] = corr(nit,actY2,'Type','Spearman')
 
rmse(i) = rmse2;
sub = [sub actY2];
r(i)=rho;

%#### Almacenamiento de resultado ######
filename = 'results4.xlsx';
sheet = i;
xlRange = 'A1';
train = [train actY1];
xlswrite(filename,train,sheet,xlRange);
xlRange = 'A107821';
test = [test actY2];
xlswrite(filename,test,sheet,xlRange);

end;
%#### 