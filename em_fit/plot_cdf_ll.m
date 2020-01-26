clear all;
format compact;

fiu_ll=dlmread('cdf_fiu_IAT_AIC.csv',',',1);
fiu_iat_h2=fiu_ll(:,3);
fiu_iat_gp=fiu_ll(:,2);
fiu_iat_exp=fiu_ll(:,1);

% %Nexus ST
% fid=fopen('summary_results\likelihood\cdf_nexus_ST.csv');
% nexus_st_data=textscan(fid,'%f %f %f', 'delimiter', ',', 'HeaderLines', 1);
% fclose(fid);
% nexus_st_h2=-nexus_st_data{1};
% nexus_st_exp=-nexus_st_data{3};
% nexus_st_gev=-nexus_st_data{2};

%MSN IAT
fid=fopen('cdf_msn_IAT_BIC.csv');
msn_data=textscan(fid,'%f %f %f %f %f', 'delimiter', ',', 'HeaderLines', 1);
fclose(fid);
% msn_h2=-msn_data{4};
% msn_exp=-msn_data{5};
% msn_ll=-msn_data{1};
% msn_gp=-msn_data{2};
msn_h2=msn_data{1};
msn_exp=msn_data{2};
msn_ll=msn_data{4};
msn_gp=msn_data{3};


%Nexus IAT
fid=fopen('cdf_nexus_IAT_BIC.csv');
nexus_data=textscan(fid,'%f %f %f %f %f', 'delimiter', ',', 'HeaderLines', 1);
fclose(fid);
% nexus_h2=-nexus_data{4};
% nexus_exp=-nexus_data{5};
% nexus_gp=-nexus_data{2};
% nexus_burr=-nexus_data{1};
nexus_h2=nexus_data{1};
nexus_exp=nexus_data{2};
nexus_gp=nexus_data{3};
nexus_burr=nexus_data{4};

%Systor IAT
fid=fopen('cdf_systor_IAT_BIC.csv');
systor_data=textscan(fid,'%f %f %f %f %f', 'delimiter', ',', 'HeaderLines', 1);
fclose(fid);
systor_h2=systor_data{1};
systor_exp=systor_data{2};
systor_gp=systor_data{3};

C={[      0    0.4470    0.7410],    
    [0.8500    0.3250    0.0980], 
    [0.9290    0.6940    0.1250],
    [0.4940    0.1840    0.5560],
    [0.4660    0.6740    0.1880]
    [0.3010    0.7450    0.9330],
    [0.6350    0.0780    0.1840]};


% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fiu_iat_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fiu_iat_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gp=cdfplot(fiu_iat_gp);
% set(f_gp,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('BIC \rightarrow');
% ylabel('CDF, Pr(BIC \leq x) \rightarrow');
% set(gca,'FontSize',16);
% % xlim([-1.15e6 -1e5]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','SE');


% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(nexus_st_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(nexus_st_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gev=cdfplot(nexus_st_gev);
% set(f_gev,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('Log-likelihood (LL) \rightarrow');
% ylabel('CDF, Pr(LL \leq x) \rightarrow');
% set(gca,'FontSize',16);
% % xlim([-1.15e6 -1e5]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GEV','Location','SE');

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fb_st_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fb_st_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% % f_gp=cdfplot(fb_st_gp);
% % set(f_gp,'Color',C{2},'LineWidth',3,'LineStyle','-');
% f_tloc=cdfplot(fb_st_tloc);
% set(f_tloc,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('Log-likelihood (LL) \rightarrow');
% ylabel('CDF, Pr(LL \leq x) \rightarrow');
% set(gca,'FontSize',16);
% % xlim([-1.15e6 -1e5]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','t-location','Location','SE');


% figure('Position',[100 100 400 300]);
% hold on;
% plot(x_h2, cmf_h2, '-k', 'LineWidth',5);
% plot(x_exp, cmf_exp, '-', 'Color', C{1}, 'LineWidth',3);
% plot(x_gp, cmf_gp, '-', 'Color', C{2}, 'LineWidth',3);
% xlabel('Log-likelihood (LL) \rightarrow');
% ylabel('CDF, Pr(LL \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','SE');
% 
% 
% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fb_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fb_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gp=cdfplot(fb_gp);
% set(f_gp,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('Log-likelihood (LL) \rightarrow');
% ylabel('CDF, Pr(LL \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','SE');

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(msn_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(msn_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gp=cdfplot(msn_gp);
% set(f_gp,'Color',C{2},'LineWidth',2.5,'LineStyle','-');
% % f_ll=cdfplot(msn_ll);
% % set(f_ll,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% % xlabel('Log-likelihood (LL) \rightarrow');
% % ylabel('CDF, Pr(LL \leq x) \rightarrow');
% xlabel('BIC \rightarrow');
% ylabel('CDF, Pr(BIC \leq x) \rightarrow');
% set(gca,'FontSize',16);
% % xlim([-1.15e6 -1e5]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','Best');


figure('Position',[100 100 400 300]);
hold on;
f_h2=cdfplot(nexus_h2);
set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
f_exp=cdfplot(nexus_exp);
set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
f_gp=cdfplot(nexus_gp);
set(f_gp,'Color',C{2},'LineWidth',3,'LineStyle','-');
% f_burr=cdfplot(nexus_burr);
% set(f_burr,'Color',C{2},'LineWidth',3,'LineStyle','-');
title('');
xlabel('BIC \rightarrow');
ylabel('CDF, Pr(BIC \leq x) \rightarrow');
% xlabel('Log-likelihood (LL) \rightarrow');
% xlabel('Log-likelihood (LL) \rightarrow','HorizontalAlignment','right');
% ylabel('CDF, Pr(LL \leq x) \rightarrow');
set(gca,'FontSize',16);
% xlim([0 inf]);
xlim([-2e5 0]);
% set(gca,'XTick',0:0.1:1);
set(gca,'YTick',0:0.5:1);
ylim([0 1]);
box on;
legend('Hyperexp','Exp','GPareto','Location','Best');

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(systor_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(systor_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gp=cdfplot(systor_gp);
% set(f_gp,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('BIC \rightarrow');
% ylabel('CDF, Pr(BIC \leq x) \rightarrow');
% set(gca,'FontSize',16);
% % xlim([0 inf]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','Best');