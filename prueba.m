%#########################################################################
%......................PRUEBAS PUNTOS POR POZOS...........................
% filename = 'NT-completo.xls' ;
% hoja = 2;
% xlRange = 'E4: K74';
% subset = xlsread (filename, hoja, xlRange)
% input = subset(:,1:6);
% output = subset(:,7);
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
% fis = genfis(input,output,opt);
% showrule(fis)
% % figure(2)
% % subplot(2,2,1)
% % plotmf(fis,'input',1)
% % subplot(2,2,2)
% % plotmf(fis,'input',2)
% % subplot(2,2,3)
% % plotmf(fis,'input',3)
% % subplot(2,2,4)
% % plotmf(fis,'input',4)
% 
% filename = 'NT-completo.xls' ;
% %xlRange = 'F2: P25' ;
% xlRange = 'D75: K98' ;
% subset = xlsread (filename, 2, xlRange);
% inputs = subset(:,2:7);
% plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,8), subset(:,1))

%######################################################################

% filename = 'NT2006_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: N72' ;
% subset = xlsread (filename, hoja, xlRange)
% input = subset(:,1:9);
% output = subset(:,10);
% 
% opt = genfisOptions('FCMClustering','FISType','mamdani');
% opt.NumClusters = 'auto';
% %opt.Verbose = 0;
% fis = genfis(input, output, opt);
% %showrule(fis)

% for i=1:9
%  for j=1:30
%   %fis.input(i).mf(j).type='trapmf';
%   %fiss = setfis(fiss,'input',i,'mf',j,'type','trampf');
%  end
% end
%%setfis(fis)
%mfedit(fis)

% [x,mf] = plotmf(fis,'input',1);
% subplot(5,1,1)
% plot(x,mf)
% xlabel('input 1 (gaussmf)')
% [x,mf] = plotmf(fis,'input',2);
% subplot(5,1,2)
% plot(x,mf)
% xlabel('input 2 (gaussmf)')

% filename = 'NT2010_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: O25' ;
% subset = xlsread (filename, hoja, xlRange);
% inputs = subset(:,2:10);
% plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,11), subset(:,1))


%###################################################################

% filename = 'NT2006_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: N72' ;
% subset = xlsread (filename, hoja, xlRange)
% input = subset(:,1:9);
% output = subset(:,10);
% 
% opt = genfisOptions('FCMClustering','FISType','sugeno');
% opt.NumClusters = 'auto';
% opt.Verbose = 0;
% fis = genfis(input, output, opt);
% 
% showrule(fis)
% %%setfis(fis)
% %mfedit(fis)
% 
% [x,mf] = plotmf(fis,'input',1);
% subplot(2,1,1)
% plot(x,mf)
% xlabel('input 1 (gaussmf)')
% [x,mf] = plotmf(fis,'input',2);
% subplot(2,1,2)
% plot(x,mf)
% xlabel('input 2 (gaussmf)')
% 
% filename = 'NT2010_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: O25' ;
% subset = xlsread (filename, hoja, xlRange)
% inputs = subset(:,2:10);
% %outputs = evalfis(inputs, fis);
% %disp(outputs)
% 
% plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,11), subset(:,1))


% ###################################################################
% 
% filename = 'NT2006_Datos_Iniciales.xlsx' ;
% hoja = 1;
% xlRange = 'E2: N72' ;
% subset = xlsread (filename, hoja, xlRange)
% input = subset(:,1:9);
% output = subset(:,10); 
% opt = genfisOptions('FCMClustering', 'FISType', 'sugeno');
% trnData = [];
% trnData = [trnData subset(1:49,1:9)];
% trnData = [trnData subset(1:49,10)];
% chkData = [];
% chkData = [chkData subset(50:end,1:9)];
% chkData = [chkData subset(50:end,10)];
% 
% opt.NumClusters = 'auto';
% opt.Verbose = 0;
% fismat = genfis(trnData(:,1:end-1),trnData(:,end), opt);
%  
% figure(2)
% subplot(2,2,1)
% plotmf(fismat,'input',1)
% subplot(2,2,2)
% plotmf(fismat,'input',2)
% subplot(2,2,3)
% plotmf(fismat,'input',3)
% subplot(2,2,4)
% plotmf(fismat,'input',4)
% 
% opt = anfisOptions('InitialFIS',fismat,'ValidationData',chkData);
% 
% opt.DisplayANFISInformation = 1;
% opt.DisplayErrorValues = 1;
% opt.DisplayStepSize = 1;
% opt.DisplayFinalResults = 1;
% 
% [fis1,error1,ss,fis2,error2] = anfis(trnData,opt);
% [fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData,opt);
% 
% figure(3)
% subplot(2,2,1)
% plotmf(fis2,'input',1)
% subplot(2,2,2)
% plotmf(fis2,'input',2)
% subplot(2,2,3)
% plotmf(fis2,'input',3)
% subplot(2,2,4)
% plotmf(fis2,'input',4)
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
% figure(5)
% anfis_output = evalfis(chkData(:,1:9), fis2);
% disp(anfis_output)
% 
% 
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
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% %opt.ClusterInfluenceRange = [0.1 0.3 0.9 0.9 0.5 0.4 1 0.7 0.7 0.4];
% opt.DataScale = [2.572120	4.763780	8.000000	1.000000	0.000000	0.165810	0.098730;
% 26.366600	7.746770	9.000000	5.000000	14.672300	1.674560	17.493886];
% opt.SquashFactor = 1.15;
% opt.AcceptRatio = 0.35;
% opt.RejectRatio = 0.25;
% %opt.Verbose = true;
% %opt.CustomClusterCenters = ;
% 
% fis = genfis(train(:,1:6),train(:,10), opt);
% 
% plotActualAndExpectedResultsWithRMSE(fis,test(:,1:6),test(:,10), test(:,11))
% 
