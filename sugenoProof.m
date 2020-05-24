filename = 'NT2006_Datos_Iniciales.xlsx' ;
hoja = 1;
xlRange = 'E2: N72' ;
subset = xlsread (filename, hoja, xlRange);
input = subset(:,1:9);
output = subset(:,10);

opt = genfisOptions('FCMClustering','FISType','sugeno');
opt.NumClusters = 8;
opt.Verbose = 0;
fis = genfis(input, output, opt);

ruleview(fis) 

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
inputs = subset(:,2:10);
%outputs = evalfis(inputs, fis);
%disp(outputs)

plotActualAndExpectedResultsWithRMSE(fis,inputs,subset(:,11), subset(:,1))
