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

filename = 'NT2006_Datos_Iniciales.xlsx' ;
hoja = 1;
xlRange = 'E2: N72' ;
subset = xlsread (filename, hoja, xlRange);
input = subset(:,1:9);
output = subset(:,10); 
trnData = [];
trnData = [trnData subset(:,1:10)];

figure(1)
subplot(2,2,1)
plotmf(fis,'input',1)
subplot(2,2,2)
plotmf(fis,'input',2)
subplot(2,2,3)
plotmf(fis,'input',3)
subplot(2,2,4)
plotmf(fis,'input',4)

figure(2)
subplot(2,2,1)
plotmf(fis,'input',5)
subplot(2,2,2)
plotmf(fis,'input',6)
subplot(2,2,3)
plotmf(fis,'input',7)
subplot(2,2,4)
plotmf(fis,'input',8)

filename = 'NT2010_Datos_Iniciales.xlsx' ;
hoja = 1;
xlRange = 'E2: O25' ;
subset = xlsread (filename, hoja, xlRange);
chkData = [];
chkData = [chkData subset(:,2:11)];

opt = genfisOptions('FCMClustering', 'FISType', 'sugeno');
opt.NumClusters = 8;
opt.Verbose = 0;
fismat = genfis(trnData(:,1:end-1),trnData(:,end), opt);
 
% figure(2)
% subplot(2,2,1)
% plotmf(fismat,'input',1)
% subplot(2,2,2)
% plotmf(fismat,'input',2)
% subplot(2,2,3)
% plotmf(fismat,'input',3)
% subplot(2,2,4)
% plotmf(fismat,'input',4)

opt = anfisOptions('InitialFIS',fismat,'ValidationData',chkData);

opt.DisplayANFISInformation = 1;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 1;
opt.DisplayFinalResults = 1;

%fis = anfis(trnData);
%[fis,trainError,stepSize,chkFIS,chkError] = anfis(trnData, opt);
[fis1,error1,ss,fis2,error2] = anfis(trnData,opt);
% figure(3)
% subplot(2,2,1)
% plotmf(fis2,'input',1)
% subplot(2,2,2)
% plotmf(fis2,'input',2)
% subplot(2,2,3)
% plotmf(fis2,'input',3)
% subplot(2,2,4)
% plotmf(fis2,'input',4)

 figure(4)
 plot([error1 error2])
 hold on
 plot([error1 error2],'o')
 legend('Train Error','Validation error')
 xlabel('Epochs')
 ylabel('RMSE (Root Mean Squared Error)')
 title('Error Curves')

%figure(5)
%anfis_output = evalfis(chkData(:,2:10), fis2);
%disp(anfis_output)
inputs = chkData(:,1:9);
plotActualAndExpectedResultsWithRMSE(fis1,inputs,subset(:,11),subset(:,1))

showrule(fis1)
ruleview(fis1) 