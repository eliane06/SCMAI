filename = 'NT2006_Datos_Iniciales.xlsx' ;
hoja = 1;
xlRange = 'E2: N72' ;
subset = xlsread (filename, hoja, xlRange)
input = subset(:,1:9);
output = subset(:,10);

opt = genfisOptions('FCMClustering','FISType','mamdani');
opt.NumClusters = 'auto';
%opt.Verbose = 0;
fis = genfis(input, output, opt);
%showrule(fis)

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

filename = 'NT2010_Datos_Iniciales.xlsx' ;
hoja = 1;
xlRange = 'E2: O25' ;
subset = xlsread (filename, hoja, xlRange);
inputs = subset(:,2:10);
plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,11), subset(:,1))


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
