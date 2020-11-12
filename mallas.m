%function [subset] = mallas()
%Valores reales 
%d = xlsread ('Mallas\profundidad_m.csv', 1, 'A1:WQ684');
%r = xlsread ('Mallas\recarga_pulg.csv', 1, 'A1:WQ684');
%a = xlsread ('Mallas\acuifero.csv', 1, 'A1:WQ684');
% s = xlsread ('Mallas\suelo.csv', 1, 'A1:WQ684');
% t = xlsread ('Mallas\topografia_porcentaje.csv', 1, 'A1:WQ684');
% c = xlsread ('Mallas\conductividad_hid_md.csv', 1, 'A1:WQ684');
% vul = xlsread ('Mallas\iv_inicial_drastic.csv', 1, 'A1:WQ684');
% nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% nit2 = xlsread('Mallas\nt2010.csv', 1, 'A1:WQ684');
% vul = transpose(vul);
% vul = reshape(vul,[], 1);
% nit = transpose(nit);
% nit = reshape(nit,[], 1);
% nit2 = transpose(nit2);
% nit2 = reshape(nit2,[], 1);
% d = transpose(d);
% d = reshape(d,[], 1);
% r = transpose(r);
% r = reshape(r,[], 1);
% a = transpose(a);
% a = reshape(a,[], 1);
% s = transpose(s);
% s = reshape(s,[], 1);
% t = transpose(t);
% t = reshape(t,[], 1);
% c = transpose(c);
% c = reshape(c,[], 1);
% risk = (vul.*nit)/145;
% subset = [];
% subset = [subset d r a s t c risk nit];
%subset(:,7) = ((subset(:, 7)).*nit)/145;
%subset = [subset nit];
%[subsett, ia, ic] = unique(subset,'rows','stable'); %si para que ande
%[rho,pval] = corr(nit,nit2,'Type','Spearman');
%disp(rho)
%end
%sub = subsett(ic,:); 
%sub2 = subset(ia,:); %es el conjunto unique
%filename = 'results.xlsx';
%hoja = 2;
%xlRange = 'A1:I154028' ;
%unicos = xlsread(filename, hoja, xlRange);
%### nit2010 para test ###
% cont = 1;
% for j=1:size(ia,1)
%     if idx(j) == 1
%         %subsetT(ia(j),9) = actY2(cont);
%         nit2_unic = nit2(ia(j),1);
%         cont = cont + 1;
%     end
% end
%sub = [sub zeros(154029,1)];
%filename = 'results.xlsx';
%sheet = 6;
%xlRange = 'A1';
%train = [train actY1];
%xlswrite(filename,sub,sheet,xlRange);

%riesgo = transpose(reshape(sub(:,8), [615, 684]));
%#########################Mallas de calificaciones#########################
% function [subset] = mallas()
%d_c = xlsread ('C:\Users\ElianeHaidee\Downloads\pruebasDt\Mallas\Nova pasta\csv 26-12-2019\DRASTC\d_.csv', 1, 'A1:WQ684');
%r_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\DRASTC\r_.csv', 1, 'A1:WQ684');
%a_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\DRASTC\a.csv', 1, 'A1:WQ684');
%s_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\DRASTC\s.csv', 1, 'A1:WQ684');
%t_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\DRASTC\t.csv', 1, 'A1:WQ684');
%c_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\DRASTC\reclas_c_.csv', 1, 'A1:WQ684');
%p_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\L-VP-P\Pozos ciegos\reclass_22_p.csv', 1, 'A1:WQ684');
%l_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\L-VP-P\Uso del Suelo\rec_l_sinwil.csv', 1, 'A1:WQ684');
%vp_c = xlsread ('Mallas\Nova pasta\csv 26-12-2019\L-VP-P\Vias Principales\rr_1000_100_clip.csv', 1, 'A1:WQ684');
% 
% vul = xlsread ('Mallas\iv_inicial_drastic.csv', 1, 'A1:WQ684');
% nit = xlsread('nt2006.csv', 1, 'A1:WQ684');
% nit2 = xlsread('Mallas\nt2010.csv', 1, 'A1:WQ684');
% vul = transpose(vul);
% vul = reshape(vul,[], 1);
% nit = transpose(nit);
% nit = reshape(nit,[], 1);
% nit2 = transpose(nit2);
% nit2 = reshape(nit2,[], 1);
% d = transpose(d);
% d = reshape(d,[], 1);
% r = transpose(r);
% r = reshape(r,[], 1);
% a = transpose(a);
% a = reshape(a,[], 1);
% s = transpose(s);
% s = reshape(s,[], 1);
% t = transpose(t);
% t = reshape(t,[], 1);
% c = transpose(c);
% c = reshape(c,[], 1);
% risk = (vul.*nit)/145;
% subset = [];
% subset = [subset d r a s t c l p vp risk nit];
% %subset(:,7) = ((subset(:, 7)).*nit)/145;
% %subset = [subset nit];
% [subset, ia, ic] = unique(subset,'rows', 'stable'); %si para que ande
% [rho,pval] = corr(nit,nit2,'Type','Spearman');
% disp(rho);
% end

%############### MALLA DE CALIFICICACIONES(importando datos)###############
%Creación malla de vulnerabilidad nueva
vul = 5.*d_c + 4.*r_c + 3.*a_c + 2.*s_c + 1.*t_c + 3.*c_c + 5.*p_c + 5.*lu + 5.*vp_c;
vul = transpose(vul);
vul = reshape(vul, [], 1);
max(vul)
nit = transpose(nt2006);
nit = reshape(nit, [], 1);
d = transpose(d);
d = reshape(d,[], 1);
r = transpose(r);
r = reshape(r,[], 1);
a = transpose(a);
a = reshape(a,[], 1);
s = transpose(s);
s = reshape(s,[], 1);
t = transpose(t);
t = reshape(t,[], 1);
c = transpose(c);
c = reshape(c,[], 1);
lu = transpose(lu);
lu = reshape(lu,[], 1);
p = transpose(p);
p = reshape(p,[], 1);
vp = transpose(vp);
vp = reshape(vp,[], 1);
risk = (vul.*nit)/(max(vul));
%Creación de matriz de entrada y salida
subset = [];
subset = [subset d r a s t c lu vp risk zeros(420660,1) zeros(420660,1)];
%subset(:,7) = ((subset(:, 7)).*nit)/145;
%subset = [subset nit];
%[subsett, ia, ic] = unique(subset,'rows','stable'); %si para que ande



