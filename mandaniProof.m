%············PRUEBAS PUNTOS POR POZOS.......................................
% filename = 'NT-completo.xlsx' ;
% hoja = 2;
% xlRange = 'E4:K74' ;
% subset = xlsread(filename, hoja, xlRange);
% input = subset(:,1:6);
% output = subset(:,7);
% 
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 9;
% opt.Exponent = 2.5;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 200;
% opt.MinImprovement = 1e-5;
% 
% fis = genfis(input, output, opt);
% 
% %showrule(fis)
% %ruleview(fis) 
% 
% % figure(1)
% % subplot(2,2,1)
% % plotmf(fis,'input',1)
% % subplot(2,2,2)
% % plotmf(fis,'input',2)
% % subplot(2,2,3)
% % plotmf(fis,'input',3)
% % subplot(2,2,4)
% % plotmf(fis,'input',4)
% 
% filename = 'NT-completo(2).xls' ;
% hoja = 2;
% xlRange =  'D75.K98' ;
% subset = xlsread (filename, hoja, xlRange);
% inputs = subset(:,2:7);
% plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,8), subset(:,1))


%#########################################################################
......................PRUEBAS POR MALLAS (Holdout)........................
%subsetT = csvread('entrenamientoDrastic.csv');
%[numbers, texts, raw] = xlsread('entrenamientoDrastic.csv');
%subsetT = entrenamiento('entrenamientoDrastic.csv',1,420660)
%nit = xlsread('Mallas\nt2006.csv');

% nit = transpose(nit);
% nit = reshape(nit,[], 1);
% %nit2 = xlsread('Mallas\nt2010.xlsx', 1, 'A1:WQ684');
% nit2 = transpose(nit2);
% nit2 = reshape(nit2,[], 1);
% 
% subsetT(:,7) = ((subsetT(:, 7)).*nit)/145;
% subsetT = [subsetT nit zeros(420660,1)];
% subsetT(:,9) = -9999;
% [subset, ia, ic] = unique(subsetT,'rows','stable');
% rng('default');
% % Cross varidation (train: 70%, test: 30%)
% cv = cvpartition(size(subset,1),'HoldOut',0.30);
% idx = cv.test;
% % Separate to training and test data
% train = subset(~idx,:);
% test  = subset(idx,:);
% train_input = train(:, 1:6);
% train_output = train(:,7);
% test_input = test(:, 1:6);
% test_output = test(:, 7);
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 22;
% opt.Exponent = 2.1;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 100;
% opt.MinImprovement = 2e-5;
% fis = genfis(train_input,train_output,opt);
% %showrule(fis) %ruleview(fis)
% % Evaluate FIS
% nit = test(:,8);  %nit = train(:,8);
% actY1 = evalfis(train_input,fis)
% actY2 = evalfis(test_input,fis)
% % Calculate RMSE 
% del = abs(actY2 - test_output); %del = abs(actY - train_output);
% rmse = sqrt(mean(del.^2))
% [rho,pval] = corr(nit,actY2,'Type','Spearman')
% 
% %#######Generación de malla#######
% cont = 1;
% for j=1:size(ia,1)
%     if idx(j) == 1
%         %subsetT(ia(j),9) = actY2(cont);
%         nit2_unic(cont) = nit2(ia(j),1);
%         cont = cont + 1;
%     end
% end
% %###### Almacenamiento de nt2010 #####
% nit2_unic = transpose(nit2_unic);
% filename = 'results.xlsx';
% sheet = 8;
% xlRange = 'A1';
% %riesgo = transpose(reshape(subsetT(:,9), [615, 684]));
% %xlswrite(filename,nit2_unic,sheet,xlRange);
% 
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% %######Almacenamiento de resultado
% %filename = 'results.xlsx';
% %sheet = 1;
% %xlRange = 'A1';
% %train = [train actY1];
% %xlswrite(filename,train,sheet,xlRange);
% %xlRange = 'A107821';
% %test = [test actY2];
% %xlswrite(filename,test,sheet,xlRange);

%#########################################################################
%......... ........PRUEBAS POR MALLAS (cv partition).......................
% subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
subset = entrenamientoDrastic;
nit = nt2006;
nit = transpose(nit);
nit = reshape(nit,[], 1);

subset(:,7) = ((subset(:, 7)).*nit)/145;
subset = [subset nit];
[subset, ia, ic] = unique(subset,'rows','stable');
subset(1,:) = [];
cv = cvpartition(size(subset, 1),'Kfold',3);
rmse=[0, 0, 0]; r  = [0,0,0];
sub = [];
for i=1:3
idx = training(cv, i);
% Separate to training and test data
train = subset(idx,:);
test  = subset(~idx,:);
train_input = train(:, 1:6);
train_output = train(:,7);
test_input = test(:, 1:6);
test_output = test(:, 7);
opt = genfisOptions('FCMClustering','FISType','mamdani');
opt.NumClusters = 10;
opt.Exponent = 8.5;
%opt.Verbose = 2.1;
opt.MaxNumIteration = 100;
opt.MinImprovement = 1e-5;

fis = genfis(train_input,train_output,opt);
showrule(fis)
%ruleview(fis)
% Evaluate FIS
 nit = test(:,8);  %nit = train(:,8);
 actY1 = evalfis(train_input,fis);
 actY2 = evalfis(test_input,fis);
% Calculate RMSE 
 del2 = abs(actY2 - test_output); del1 = abs(actY1 - train_output);
 rmse1 = sqrt(mean(del1.^2));
 rmse2 = sqrt(mean(del2.^2));
 [rho,pval] = corr(nit,actY2,'Type','Spearman')
% 

rmse(i) = rmse2;
sub = [sub actY2];
r(i)=rho;
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
end

%#########################################################################
%......................PRUEBAS POR MALLAS (2).................................
% subset = xlsread ('entrenamientoDrastic.csv', 1, 'A1:G420660');
% nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% nit = transpose(nit);
% nit = reshape(nit,[], 1); 
% subset(:,7) = ((subset(:, 7)).*nit)/145;
% subset = [subset nit];
% [subset, ia, ic] = unique(subset,'rows', 'stable'); %si para que ande

% subset = mallas()
% train_input = subset(:, 1:6);
% train_output = subset(:,7);
% 
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 7;
% opt.Exponent = 2.5;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 100;
% opt.MinImprovement = 1e-5;
% 
% fis = genfis(train_input,train_output,opt);
% showrule(fis)
% 
% subsett = xlsread ('point extraction_iniciales.xlsx', 1, 'A3:H51344');
% test_input = subsett(:,2:7);
% test_output = subsett(:,8);
% % Evaluate FIS
% nit = subsett(:,1);
% actY = evalfis(test_input,fis);
% 
% % Calculate RMSE 
% del = actY - test_output;
% rmse = sqrt(mean(del.^2))
% 
% [rho,pval] = corr(nit,actY,'Type','Spearman')
%plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))


%#########################################################################
%············PRUEBAS PUNTOS POR POZOS(2010,2016,2018)......................
% filename = 'Pozos061018_union_NT2006.xlsx' ;
% hoja = 1;
% xlRange = 'G4:Q164' ;
% subset = xlsread(filename, hoja, xlRange);
% 
% rng('default');
% % % Cross varidation (train: 70%, test: 30%)
% cv = cvpartition(size(subset,1),'HoldOut',0.30);
% % cv = cvpartition(size(subset, 1),'Kfold',3);
% % idx = training(cv, 1);
% %idx = cv.test;
% % % Separate to training and test data
% train = subset(~idx,:);
% test  = subset(idx,:);
% %train = subset(1:126,:);
% %test  = subset(127:end,:);
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 9;
% opt.Exponent = 2.1;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 200;
% opt.MinImprovement = 1e-5;
% fis = genfis(train(:,1:6), train(:,10), opt);
% %showrule(fis)
% %ruleview(fis) 
% plotActualAndExpectedResultsWithRMSE(fis,test(:,1:6),test(:,10), test(:,11))

%#########################################################################

% %#########################################################################
% ......................PRUEBAS POR MALLAS (PLUVP)(Holdout)........................
% %subsetT = csvread('entrenamientoDrastic.csv');
% %[numbers, texts, raw] = xlsread('entrenamientoDrastic.csv');
% %subsetT = entrenamiento('entrenamientoDrastic.csv',1,420660)
% %nit = xlsread('Mallas\nt2006.csv');
% 
% %nit = transpose(nit);
% %nit = reshape(nit,[], 1);
% %nit2 = xlsread('Mallas\nt2010.xlsx', 1, 'A1:WQ684');
% %nit2 = transpose(nit2);
% %nit2 = reshape(nit2,[], 1);
% 
% %subsetT(:,7) = ((subsetT(:, 7)).*nit)/145;
% %subsetT = [subsetT nit zeros(420660,1)];
% %subsetT(:,9) = -9999;
% %[subset, ia, ic] = unique(subsetT,'rows','stable');
% rng('default');
% % Cross varidation (train: 70%, test: 30%)
% cv = cvpartition(size(subset,1),'HoldOut',0.30);
% idx = cv.test;
% % Separate to training and test data
% train = subset(~idx,:);
% test  = subset(idx,:);
% train_input = train(:, 1:9);
% train_output = train(:,10);
% test_input = test(:, 1:9);
% test_output = test(:, 10);
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 5;
% opt.Exponent = 2.1;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 100;
% opt.MinImprovement = 2e-5;
% fis = genfis(train_input,train_output,opt);
% %showrule(fis) %ruleview(fis)
% % Evaluate FIS
% nit = test(:,11);  %nit = train(:,8);
% actY1 = evalfis(train_input,fis)
% actY2 = evalfis(test_input,fis)
% % Calculate RMSE 
% del = abs(actY2 - test_output); %del = abs(actY - train_output);
% rmse = sqrt(mean(del.^2))
% [rho,pval] = corr(nit,actY2,'Type','Spearman')
% 
% %#######Generación de malla#######
% cont = 1;
% for j=1:size(ia,1)
%     if idx(j) == 1
%         %subsetT(ia(j),9) = actY2(cont);
%         nit2_unic(cont) = nit2(ia(j),1);
%         cont = cont + 1;
%     end
% end
% %###### Almacenamiento de nt2010 #####
% %nit2_unic = transpose(nit2_unic);
% %filename = 'results.xlsx';
% %sheet = 8;
% %xlRange = 'A1';
% %riesgo = transpose(reshape(subsetT(:,9), [615, 684]));
% %xlswrite(filename,nit2_unic,sheet,xlRange);
% 
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% %######Almacenamiento de resultado
% filename = 'results2.xlsx';
% sheet = 1;
% xlRange = 'A1';
% train = [train actY1];
% xlswrite(filename,train,sheet,xlRange);
% xlRange = 'A107904';
% test = [test actY2];
% xlswrite(filename,test,sheet,xlRange);




% %#########################################################################
% ................PRUEBAS POR MALLAS (PLUVP)(Holdout)(P061018)........................
% 
% train_input = train(:, 1:9);
% train_output = train(:,10);
% test_input = test(:, 1:9);
% test_output = test(:, 10);
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 5;
% opt.Exponent = 2.1;
% %opt.Verbose = 2.1;
% opt.MaxNumIteration = 100;
% opt.MinImprovement = 2e-5;
% fis = genfis(train_input,train_output,opt);
% %showrule(fis) %ruleview(fis)
% % Evaluate FIS
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
% [rho5,pval] = corr(test(in1,15),actY2(in2),'Type','Spearman')
% [rho6,pval] = corr(NT18,actY2(in3),'Type','Spearman')
% 
% 
% % %#######Generación de malla#######
% % cont = 1;
% % for j=1:size(ia,1)
% %     if idx(j) == 1
% %         %subsetT(ia(j),9) = actY2(cont);
% %         nit2_unic(cont) = nit2(ia(j),1);
% %         cont = cont + 1;
% %     end
% % end
% %###### Almacenamiento de nt2010 #####
% %nit2_unic = transpose(nit2_unic);
% %filename = 'results.xlsx';
% %sheet = 8;
% %xlRange = 'A1';
% %riesgo = transpose(reshape(subsetT(:,9), [615, 684]));
% %xlswrite(filename,nit2_unic,sheet,xlRange);
% 
% %plotActualAndExpectedResultsWithRMSE(fis,test_input,test_output, test(:, 8))
% %######Almacenamiento de resultado
% filename = 'results3.xlsx';
% sheet = 1;
% xlRange = 'A1';
% train = [train actY1];
% xlswrite(filename,train,sheet,xlRange);
% xlRange = 'A107795';
% test = [test actY2];
% xlswrite(filename,test,sheet,xlRange);