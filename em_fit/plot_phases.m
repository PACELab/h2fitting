clear all;
format compact;

% fid=fopen('phases_vs_obj.csv');
% cdata=textscan(fid,'%*f %f %f %f %f %f %f', 'delimiter', ',', 'HeaderLines', 1);
% fclose(fid);

% JSD=cdata{1};
% R2=cdata{2};
% LL=cdata{3};
% JSD_time=cdata{4};
% R2_time=cdata{5};
% LL_time=cdata{6};

C={[      0    0.4470    0.7410],    
    [0.8500    0.3250    0.0980], 
    [0.9290    0.6940    0.1250],
    [0.4940    0.1840    0.5560],
    [0.4660    0.6740    0.1880]
    [0.3010    0.7450    0.9330],
    [0.6350    0.0780    0.1840]};

JSD=[0.00608776	0.00586238	0.00599088	0.00602172	0.0059977	0.00614106	0.00599046	0.0060182	0.00600304	0.00622364];
JSD_time=[2.03502	2.81082	7.3948	7.4497	21.5321	26.33025	30.01664	34.1844	70.908	86.255];
R2=[0.72198	0.98858	0.989038	0.990902	0.990936	0.990918	0.990918	0.990902	0.990918	0.990902];
R2_time=[1.69454	1.31648	5.13702	11.67402	13.53892	27.5234	40.0386	52.3976	81.0946	102.6366];
LL=[0.0254922	0.9121994	0.979895	0.9883862	0.9972986	0.9952026	0.999332	0.9990346	0.999722	0.9992776];
LL_time=[0.185268	0.258384	0.520782	1.517222	1.93392	3.66874	3.51162	4.479	4.71302	4.5402];
AIC=[-4074994	-5188194	-5213794	-5221394	-5228394	-5223994	-5217394	-5217394	-5217394	-5228794];
BIC=[-4074972.637	-5188172.637	-5213772.637	-5221372.637	-5228372.637	-5223972.637	-5217372.637	-5217372.637	-5217372.637	-5228772.637];
normAIC = AIC - min(AIC(:));
normAIC = normAIC ./ max(normAIC(:));
normBIC = BIC - min(BIC(:));
normBIC = normBIC ./ max(normBIC(:));
range=1:10;

% figure('Position',[100 100 350 250]);
% hold on;
% plot(range,R2(range),'-kx','LineWidth',3,'MarkerSize',8);
% plot(range,JSD(range),'-ro','LineWidth',3,'MarkerSize',8);
% plot(range,LL(range)./max(LL(range)),'-b+','LineWidth',3,'MarkerSize',8);
% plot(range,normAIC,'-d','LineWidth',3,'MarkerSize',8,'Color',C{4});
% plot(range,normBIC,'-+','LineWidth',3,'MarkerSize',8,'Color',C{5});
% xlabel('# Phases \rightarrow');
% ylabel('Objective/metric \rightarrow');
% set(gca,'FontSize',16);
% xlim([1 10]);
% set(gca,'XTick',[1,2,4,6,8,10]);
% set(gca,'XTickLabel',{'    1\newline  Exp','    2\newline    H_2','4','6','8','10'});
% % set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('R^2','JSD','LL (normalized)','Location','SE');

figure('Position',[100 100 350 250]);
hold on;
plot(range,R2_time(range),'-kx','LineWidth',3,'MarkerSize',8);
plot(range,JSD_time(range),'-ro','LineWidth',3,'MarkerSize',8);
plot(range,LL_time(range),'-b+','LineWidth',3,'MarkerSize',8);
plot(range,LL_time(range),'-d','LineWidth',3,'MarkerSize',8,'Color',C{4});
plot(range,LL_time(range),'-+','LineWidth',3,'MarkerSize',8,'Color',C{5});
xlabel('# Phases \rightarrow');
ylabel('Computation time (s) \rightarrow');
set(gca,'FontSize',16);
xlim([1 10]);
set(gca,'XTick',[1,2,4,6,8,10]);
set(gca,'XTickLabel',{'    1\newline  Exp','    2\newline    H_2','4','6','8','10'});
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
box on;
lgd=legend('R^2','JSD','LL','AIC','BIC','Location','Best');
lgd.FontSize=12;