clear all;
format compact;

fiu_jsd=dlmread('cdf_fiu_IAT_JSD.csv',',',1);
fiu_h2=fiu_jsd(:,1);
fiu_gp=fiu_jsd(:,3);
fiu_exp=fiu_jsd(:,2);

vdi_jsd=dlmread('cdf_systor_IAT_JSD.csv',',',1);
vdi_h2=vdi_jsd(:,1);
vdi_b=vdi_jsd(:,3);
vdi_exp=vdi_jsd(:,2);
vdi_b(vdi_b==0)=[];

% fb_st_bt=load('summary_results\fb_st\jsd\Filebench_st_beta_jsd.csv');
% fb_st_exp=load('summary_results\fb_st\jsd\Filebench_st_exp_jsd.csv');
% fb_st_h2=load('summary_results\fb_st\jsd\Filebench_st_hyp_jsd.csv');
% 
% nexus_st_bs=load('summary_results\nexus_st\jsd\Nexus_st_birnbaumsaunders_jsd.csv');
% nexus_st_exp=load('summary_results\nexus_st\jsd\nexus_st_exp_jsd.csv');
% nexus_st_h2=load('summary_results\nexus_st\jsd\nexus_st_hyp_jsd.csv');
% 
% sys_st_br=load('summary_results\sys\jsd\sys_iat_burr_jsd.csv');
% sys_st_exp=load('summary_results\sys\jsd\sys_iat_exp_jsd.csv');
% sys_st_h2=load('summary_results\sys\jsd\sys_iat_hyp_jsd.csv');
% 
% fb_burr=load('summary_results\Filebench_iat\jsd\Filebench_iat_Burr_jsd.csv');
% fb_ln=load('summary_results\Filebench_iat\jsd\Filebench_iat_Lognormal_jsd.csv');
% fb_weibull=load('summary_results\Filebench_iat\jsd\Filebench_iat_Weibull_jsd.csv');
% fb_exp=load('summary_results\Filebench_iat\jsd\Filebench_iat_exp_jsd.csv');
% fb_h2=load('summary_results\Filebench_iat\jsd\Filebench_iat_hyp_jsd.csv');
% 
% msn_burr=load('summary_results\MSN_iat\jsd\MSN_iat_burr_jsd.csv');
% msn_loglogistic=load('summary_results\MSN_iat\jsd\MSN_iat_loglogistic_jsd.csv');
% msn_lognormal=load('summary_results\MSN_iat\jsd\MSN_iat_lognormal_jsd.csv');
% msn_exp=load('summary_results\MSN_iat\jsd\MSN_iat_exp_jsd.csv');
% msn_h2=load('summary_results\MSN_iat\jsd\MSN_iat_hyp_jsd.csv');
% 
% nexus_gev=load('summary_results\nexus_iat\jsd\nexus_iat_gev_jsd.csv');
% nexus_halfnormal=load('summary_results\nexus_iat\jsd\nexus_iat_halfnorm_jsd.csv');
% nexus_tloc=load('summary_results\nexus_iat\jsd\nexus_iat_tloc_jsd.csv');
% nexus_exp=load('summary_results\nexus_iat\jsd\nexus_iat_exp_jsd.csv');
% nexus_h2=load('summary_results\nexus_iat\jsd\nexus_iat_hyp_jsd.csv');

C={[      0    0.4470    0.7410],    
    [0.8500    0.3250    0.0980], 
    [0.9290    0.6940    0.1250],
    [0.4940    0.1840    0.5560],
    [0.4660    0.6740    0.1880]
    [0.3010    0.7450    0.9330],
    [0.6350    0.0780    0.1840]};

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fiu_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fiu_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_bs=cdfplot(fiu_gp);
% set(f_bs,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('JSD \rightarrow');
% ylabel('CDF, Pr(JSD \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 .8]);
% % set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GPareto','Location','SE');

figure('Position',[100 100 400 300]);
hold on;
f_h2=cdfplot(vdi_h2);
set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
f_exp=cdfplot(vdi_exp);
set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
f_bs=cdfplot(vdi_b);
set(f_bs,'Color',C{2},'LineWidth',3,'LineStyle','-');
title('');
xlabel('JSD \rightarrow');
ylabel('CDF, Pr(JSD \leq x) \rightarrow');
set(gca,'FontSize',16);
xlim([0 .4]);
set(gca,'XTick',0:0.1:1);
set(gca,'YTick',0:0.5:1);
ylim([0 1]);
box on;
legend('Hyperexp','Exp','Burr','Location','SE');


% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(nexus_st_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(nexus_st_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_bs=cdfplot(nexus_st_bs);
% set(f_bs,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('JSD \rightarrow');
% ylabel('CDF, Pr(JSD \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 .5]);
% set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Birnbaum-Saunders','Location','SE');


% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fb_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fb_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_burr=cdfplot(fb_burr);
% set(f_burr,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('JSD \rightarrow');
% ylabel('CDF, Pr(JSD \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 inf]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Burr','Location','SE');
% 
% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(msn_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(msn_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_burr=cdfplot(msn_burr);
% set(f_burr,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('JSD \rightarrow');
% ylabel('CDF, Pr(JSD \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 .3]);
% set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Burr','Location','SE');
% 
% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(nexus_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(nexus_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_gev=cdfplot(nexus_gev);
% set(f_gev,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('JSD \rightarrow');
% ylabel('CDF, Pr(JSD \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 .5]);
% set(gca,'XTick',0:0.1:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','GEV','Location','SE');