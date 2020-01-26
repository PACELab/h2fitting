clear all;
format compact;

fiu_lsq=dlmread('summary_results\fiu_iat\cdf_fiu_IAT_LSQ.csv',',',1);
fiu_iat_h2=fiu_lsq(:,1);
fiu_iat_burr=fiu_lsq(:,2);
fiu_iat_exp=fiu_lsq(:,3);

fb_st_burr=load('summary_results\fb_st\lsq\Filebench_st_Burr_lsq.csv');
fb_st_exp=load('summary_results\fb_st\lsq\Filebench_st_exp_lsq.csv');
fb_st_h2=load('summary_results\fb_st\lsq\Filebench_st_hyp_lsq.csv');

nexus_st_lognormal=load('summary_results\nexus_st\lsq\nexus_st_lognormal_lsq.csv');
nexus_st_exp=load('summary_results\nexus_st\lsq\nexus_st_exp_lsq.csv');
nexus_st_h2=load('summary_results\nexus_st\lsq\nexus_st_hyp_lsq.csv');

sys_ln=load('summary_results\sys\lsq\Sys_iat_lognormal_lsq.csv');
sys_exp=load('summary_results\sys\lsq\Sys_iat_exp_lsq.csv');
sys_h2=load('summary_results\sys\lsq\Sys_iat_hyp_lsq.csv');

fb_tloc=load('summary_results\Filebench_iat\lsq\Filebench_iat_tloc_lsq.csv');
fb_beta=load('summary_results\Filebench_iat\lsq\Filebench_iat_beta_lsq.csv');
fb_gamma=load('summary_results\Filebench_iat\lsq\Filebench_iat_gamma_lsq.csv');
fb_exp=load('summary_results\Filebench_iat\lsq\Filebench_iat_exp_lsq.csv');
fb_h2=load('summary_results\Filebench_iat\lsq\Filebench_iat_hyp_lsq.csv');

msn_tloc=load('summary_results\MSN_iat\lsq\MSN_iat_tloc_lsq.csv');
msn_beta=load('summary_results\MSN_iat\lsq\MSN_iat_lognormal_lsq.csv');
msn_gamma=load('summary_results\MSN_iat\lsq\MSN_iat_burr_lsq.csv');
msn_exp=load('summary_results\MSN_iat\lsq\MSN_iat_exp_lsq.csv');
msn_h2=load('summary_results\MSN_iat\lsq\MSN_iat_hyp_lsq.csv');

nexus_burr=load('summary_results\nexus_iat\lsq\nexus_iat_burr_lsq.csv');
nexus_lognormal=load('summary_results\nexus_iat\lsq\nexus_iat_lognormal_lsq.csv');
nexus_tloc=load('summary_results\nexus_iat\lsq\nexus_iat_tloc_lsq.csv');
nexus_exp=load('summary_results\nexus_iat\lsq\nexus_iat_exp_lsq.csv');
nexus_h2=load('summary_results\nexus_iat\lsq\nexus_iat_hyp_lsq.csv');

C={[      0    0.4470    0.7410],    
    [0.8500    0.3250    0.0980], 
    [0.9290    0.6940    0.1250],
    [0.4940    0.1840    0.5560],
    [0.4660    0.6740    0.1880]
    [0.3010    0.7450    0.9330],
    [0.6350    0.0780    0.1840]};


figure('Position',[100 100 400 300]);
hold on;
f_h2=cdfplot(fiu_iat_h2);
set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
f_exp=cdfplot(fiu_iat_exp);
set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
f_ln=cdfplot(fiu_iat_burr);
set(f_ln,'Color',C{2},'LineWidth',3,'LineStyle','-');
title('');
xlabel('R^2 (goodness of fit) \rightarrow');
ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
set(gca,'FontSize',16);
xlim([0.25 1]);
set(gca,'XTick',0:0.25:1);
set(gca,'YTick',0:0.5:1);
ylim([0 1]);
box on;
legend('Hyperexp','Exp','Burr','Location','NW');

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(sys_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(sys_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_ln=cdfplot(sys_ln);
% set(f_ln,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0.25 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Lognormal','Location','NW');

% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fb_st_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fb_st_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_burr=cdfplot(fb_st_burr);
% set(f_burr,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Burr','Location','NW');


% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(nexus_st_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(nexus_st_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_ln=cdfplot(nexus_st_lognormal);
% set(f_ln,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Lognormal','Location','NW');



% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(fb_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(fb_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_tloc=cdfplot(fb_tloc);
% set(f_tloc,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0 1]);
% set(gca,'XTick',0:0.25:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','t location','Location','NW');
% 
% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(msn_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(msn_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_tloc=cdfplot(msn_tloc);
% set(f_tloc,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0.6 1]);
% set(gca,'XTick',0:0.2:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','t location','Location','NW');
% 
% figure('Position',[100 100 400 300]);
% hold on;
% f_h2=cdfplot(nexus_h2);
% set(f_h2,'Color','k','LineWidth',5,'LineStyle','-');
% f_exp=cdfplot(nexus_exp);
% set(f_exp,'Color',C{1},'LineWidth',3,'LineStyle','-');
% f_tloc=cdfplot(nexus_burr);
% set(f_tloc,'Color',C{2},'LineWidth',3,'LineStyle','-');
% title('');
% xlabel('R^2 (goodness of fit) \rightarrow');
% ylabel('CDF, Pr(R^2 \leq x) \rightarrow');
% set(gca,'FontSize',16);
% xlim([0.6 1]);
% set(gca,'XTick',0:0.2:1);
% set(gca,'YTick',0:0.5:1);
% ylim([0 1]);
% box on;
% legend('Hyperexp','Exp','Burr','Location','NW');