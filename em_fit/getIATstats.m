clear all;
format compact;

% filename='2600-2649_getattr.csv';
% A=load(filename);
% I=A(:,2);
% filename='sorted_PDL_95.txt';
filename='2700-2712_readlink_sorted.txt';
I=load(filename);

disp([mean(I), prctile(I,50), prctile(I,90)]);
disp(size(I));
%allfitdist(I,'CDF');

% fid=fopen('res_2700-2712_readlink_crop');
% tline=fgetl(fid);
% 
% i=0;
% 
% while ~isempty(tline)
%     if(~isempty(str2num(tline)))
%         P(i+1)=str2num(tline);
%         i=i+1;
%     end
%     tline=fgetl(fid);
% end
% n=i;
% i=0;
% 
% while isempty(tline)
%     tline=fgetl(fid);
% end
% 
% while ~isempty(tline)
%     if(~isempty(str2num(tline)))
%         MU(i+1)=str2num(tline);
%         i=i+1;
%     end
%     tline=fgetl(fid);
% end
% m=i;
% [n m]

% fclose(fid);
P=[0.5 0.5];MU=[100 10];
Px=num2cell(P);
MUx=num2cell(MU);
[h,p,ksstat,cv]=kstest(I,[(0:max(I));hyperexpxcdf((0:max(I)), Px{:}, MUx{:})]')

figure;
h=cdfplot(I);
hold on;
set(h,'LineWidth',3);
xlabel('Inter-arrival time (\musecs)');
title(filename,'interpreter','none')
set(gca,'FontSize',16);
plot((0:max(I)),hyperexpxcdf((0:max(I)), Px{:}, MUx{:}),'-r','LineWidth',2);
legend('Empirical','Modeled');