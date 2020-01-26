clear variables;


dn = {'exponential', 'normal', 'weibull', 'beta', 'birnbaumsaunders', 'burr', 'extreme value', ...
    'gamma', 'generalized extreme value', 'generalized pareto', 'half normal', 'inversegaussian', 'logistic', ...
    'loglogistic', 'lognormal', 'nakagami', 'rayleigh', 'rician', 'tlocationscale'};

nln=cell(size(dn));
direct_name = 'cache_physics\';
files=[dir(strcat(direct_name,'iat_*.csv'))];
% dir('Nexus5_Kernel_BIOTracer_traces/Trace_files/iat_write*.txt'); dir('Nexus5_Kernel_BIOTracer_traces/Trace_files/iat_read*.txt')];
M=containers.Map(dn,nln,'UniformValues',false);
dists=M.keys();
first=1;
count=0;

params={};
for file = files'
    I=load(strcat(direct_name,file.name));
    disp(file.name);
    count=count+1;
    %     disp([mean(I), prctile(I,50), prctile(I,90)]);
    [D,PD]=allfitdist(I);
    dn={D.DistName};
    nln={D.NLogL};
    tmpM=containers.Map(dn,nln,'UniformValues',false);
    paraM=containers.Map(dn,{D.Params},'UniformValues',false);
    pdM=containers.Map(dn,PD,'UniformValues',false);
    
    tau_guesses = abs(randn(3,2)*std(I)+mean(I));
    tau_guesses=[1, 10; 10, 100; tau_guesses];
    NlogLike=Inf;
    weightshat=-1*ones(1,2);
    taushat=-1*ones(1,2);
    for run=1:5
        tau_guess = tau_guesses(run,:);
        weight_guess = rand(1,2); weight_guess = weight_guess/norm(weight_guess, 1);
        try
            [cur_taus, cur_weights, cur_like] = emdistfit(I, tau_guess, weight_guess);
        catch
            warning('Could not fit EM.');
            cur_like=Inf;
        end
        if cur_like<NlogLike
            NlogLike=cur_like;
            weightshat=cur_weights;
            taushat=cur_taus;
%             val_like=emlikelihood([cur_taus, cur_weights],I_val,length(cur_taus));
        end
        disp(cur_like);
    end
    
    if first
        for i = 1:length(dists)
            try
                if isKey(tmpM,dists{i})
                    M(dists{i})=tmpM(dists{i});
                else
                    PD=fitdist(I,dists{i});
                    PD_like=PD.NLogL;
                    paraM(dists{i})=PD.ParameterValues;
                    M(dists{i})=PD_like;
                end
%                 validation_nloglike(dists{i})=[sum(log(pdf(pdM(dists{i}),I_val)))];
            catch e
                %                 fprintf(2,'The identifier was:\n%s',e.identifier);
                %                 fprintf(2,'There was an error! The message was:\n%s',e.message);
                warning('Problem. Assigning a value of -1.');
                M(dists{i})=-1;
%                 validation_nloglike(dists{i})=-1;
            end
        end
%         validation_nloglike('hyperexponential')=val_like;
        first=0;
    else
        for i = 1:length(dists)
            try
                if isKey(tmpM,dists{i})
                    M(dists{i})=[M(dists{i}) tmpM(dists{i})];
                else
                    PD=fitdist(I,dists{i});
                    PD_like=PD.NLogL;
                    paraM(dists{i})=PD.ParameterValues;
                    M(dists{i})=[M(dists{i}) PD_like];
                end
                
%                 validation_nloglike(dists{i})=[validation_nloglike(dists{i}) sum(log(pdf(pdM(dists{i}),I_val)))];
            catch e
                %                 fprintf(2,'The identifier was:\n%s',e.identifier);
                %                 fprintf(2,'There was an error! The message was:\n%s',e.message);
                warning('Problem. Assigning a value of -1.');
                M(dists{i})=[M(dists{i}) -1];
%                 validation_nloglike(dists{i})=[validation_nloglike(dists{i}) -1];
            end
        end
%         validation_nloglike('hyperexponential')=[validation_nloglike('hyperexponential') val_like];
    end
    try
        M('hyperexponential')=[M('hyperexponential') NlogLike];
        disp(NlogLike);
    catch e
        warning('hyperexponential not present.');
        M('hyperexponential')=NlogLike;
    end
%     try
%         burr=fitdist(I,'burr');
%         burr_like=burr.NLogL;
%         paraM('burr')=burr.ParameterValues;
%     catch
%         warning('Burr could not be fitted');
%         burr_like=Inf;
%     end
%     try
%         hn=fitdist(I,'hn');
%         hn_like=hn.NLogL;
%         paraM('hn')=hn.ParameterValues;
%     catch
%         warning('Half normal could not be fitted');
%         hn_like=Inf;
%     end
%     try
%         M('burr')=[M('burr') burr_like];
%     catch e
%         warning('Burr not present.');
%         M('burr')=burr_like;
%     end
%     try
%         M('hn')=[M('hn') hn_like];
%     catch e
%         warning('half normal not present.');
%         M('hn')=hn_like;
%     end

    % add CV log likelihoods
       
    try
        genp=paraM('generalized pareto');
    catch e
        warning('GP not present.');
        genp=[-1 -1 -1];
    end
    try
        gev=paraM('generalized extreme value');
    catch e
        warning('GEV not present.');
        gev=[-1 -1 -1];
    end
    
    try
        lg=paraM('logistic');
        lgm=mean(pdM('logistic'));
        lgv=var(pdM('logistic'));
    catch e
        warning('loglogistic not present.');
        lg=[-1 -1];
        lgm=-1;
        lgv=-1;
    end
    try
        tloc=paraM('tlocationscale');
        tlocm=mean(pdM('tlocationscale'));
        tlocv=var(pdM('tlocationscale'));
    catch e
        warning('Burr not present.');
        tloc=[-1 -1 -1];
        tlocm=-1;
        tlocv=-1;
    end
    params=[params {file.name;mean(I);var(I);paraM('exponential');weightshat(1);weightshat(2); taushat(1);taushat(2);genp(1);genp(2);genp(3);mean(pdM('generalized pareto'));var(pdM('generalized pareto'));gev(1);gev(2);gev(3);mean(pdM('generalized extreme value'));var(pdM('generalized extreme value'));lg(1);lg(2);lgm;lgv;tloc(1);tloc(2);tloc(3);tlocm;tlocv}];
end
disp(count)
params=params';
%% SAVE PARAMS
fid = fopen('params_EM_CP.csv','w');
% params=params';
fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n','trace','mean','var','exp(lambda)','p1','p2','lambda1','lambda2','gp-shape','gp-scale','gp-thresh','gp-mean','gp-var','gev-shape','gev-scale','gev-loc','gev-mean','gev-var','lg-location','lg-scale','lg-mean','lg-var','tloc-loc','tloc-scale','tloc-dof','tloc-mean','tloc-var');
for i=1:size(params,1)
    fprintf(fid,'%s, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f, %.25f\n',params{i,:});
end
fclose(fid);
%% SAVE
results={};
dists2=[dists 'hyperexponential'];
for i=1:length(dists2)
    results=[results;[dists2{i} num2cell(M(dists2{i})) ]];
end
results=results';
%%
% validation_results={};
% dists2=[dists 'hyperexponential'];
% for i=1:length(dists2)
%     validation_results=[validation_results;[dists2{i} num2cell(validation_nloglike(dists2{i})) ]];
% end
% validation_results=validation_results';
%% plot CDF
% figure; hold on;
% for i=1:length(dists)
%     h=cdfplot(-1*M(dists{i}));
%     if any(M(dists{i})==-1)
%         h.LineStyle='--';
%     end
%     h.LineWidth=1.6;
% end
% legend(dists,'Location','southeast');
% xlabel('Log Likelihood');
% xlim([-1e5 3e5]);
%% plot CDF of top 4
% figure; hold on;
% chosen = {'generalized pareto','loglogistic','lognormal','generalized extreme value','weibull' };
% legdists={};
% for i=1:length(dists)
%     if any(strcmp(chosen,dists{i}))
%         h=cdfplot(-1*M(dists{i}));
%         if any(M(dists{i})==-1)
%             h.LineStyle='--';
%         end
%         h.LineWidth=1.5;
%         legdists=[legdists dists{i}];
%     end
% end
% legend(legdists,'Location','southeast');
% xlabel('Log Likelihood');
% xlim([0 2e5]);
%% K Phases exponential mixture
% filename='fiu-iodedup-interarrival-times/sorted_home2_ext3_writes.txt';
% I=load(filename);
% times=cell(5,10);
% LogLikes=cell(5,10);
% for j=1:5
%     for k=1:10
%         tau_guess = abs(randn(1,k)*std(I)+mean(I));
%         weight_guess = rand(1,k); weight_guess=weight_guess/norm(weight_guess,1);
%         disp(k);
%         tic;
%         try
%             [cur_taus, cur_weights, cur_like] = emdistfit(I, tau_guess, weight_guess);
%         catch
%             warning('Could not fit EM.');
%             cur_like=Inf;
%         end
%         et=toc;
%         times{j,k}=et;
%         LogLikes{j,k}=cur_like;
%     end
% end

%% PDF Plots
%% Nexus
% I=load(strcat('Nexus5_Kernel_BIOTracer_traces/Trace_files/','iat_read_log132_radio.txt'));
% I=load(strcat('Nexus5_Kernel_BIOTracer_traces/Trace_files/','iat_read_log111_email.txt'));
% h2weights=[0.674897277, 0.325102723];
% h2taus=[8.72189E-06, 2.128845264];
% p_exp=0.860617953;
% b=[3.8141E-06,39.09977225,0.007004616];

% h2weights=[0.747431187	0.252568813];
% h2taus=[0.002458081	207.338212];
% p_exp=46.55747547;
% b=[1.35021E-05	3.468862236	0.046124719];
% emhist_custom_nexus(I,h2taus,h2weights,p_exp,b(1),b(2),b(3));
%% MSN
% I=load('MSNtraces/CFS.2008-03-10.01-36.trace.csv.csv_DiskRead.iat');
% h2weights=[0.975984409	0.024015591];
% h2taus=[4649.659619	28764.42016];
% p_exp=5229.06708;
% b=[7.941418123	0.786532507];
% emhist_custom_msn(I,h2taus,h2weights,p_exp,b(1),b(2));%,'pdfmin',min(I(I>0)),'npts',50);
%% Filebench
% I=load('event_times/traces/dbserver_ext4_ST.csv');
% h2weights=[0.99982078	0.00017922];
% h2taus=[0.002057439	10.06824347];
% p_exp=0.002086052;
% b=[0.007753404	0.002058231	-2.22E-15];
% emhist_custom_GP(I,h2taus,h2weights,p_exp,b(1),b(2),b(3),'pdfmin',min(I(I>0)),'npts',50);
%% Systor
% I=load('Systor/comb_iat_R_LUN1.csv');
% h2weights=[0.996756781	0.003243219];
% h2taus=[0.002187296	3.158383084];
% p_exp=0.003544656;
% b=[1.758612646	0.000301779	-2.2E-15];
% emhist_custom_GP(I,h2taus,h2weights,p_exp,b(1),b(2),b(3));
%% FIU
% I=load('fiu-iodedup-interarrival-times/sorted_home4_ext3_reads.txt');
% h2weights=[0.971695401	0.028304599];
% h2taus=[0.008391221	346.5547631];
% p_exp=1/11.76649539;
% b=[2.37385914	0.00088054	4.16196E-06];
% % I=load('fiu-iodedup-interarrival-times/sorted_web2-webmail_ext3_writes.txt');
% % h2weights=[0.875911449	0.124088551];	 	
% % h2taus=[4.85716E-05	2.129250552];
% % p_exp=1/0.271324824;
% % b=[1.672907443	4.89542E-05	4.00178E-09];
% emhist_custom_GP(I,h2taus,h2weights,p_exp,b(1),b(2),b(3),'pdfmin',min(I(I>0)));
% % export_fig(strcat('PDFcomp_','web2-webmail_ext3_writes','.pdf'),'-p0.02','-transparent');
%% Plot CDF from File
% filenames={'top3_cdf_jsd.csv','top3_cdf_lsq.csv','top3_cdf_ll.csv','top3_cdf_ll_norm.csv'};
% names={'JSD','LSQ','LogLikelihood','Normalized Neg LL'};
% colors=[0.9 0 0; 0 0 0.9; 0 0.7 0; 0 0 0];
% for fn=1:length(filenames)
%     [data,hdr,~] = xlsread(filenames{fn});
%     figure; hold on;
%     
%     for i=1:length(hdr)
%         h=cdfplot(data(:,i));
%         h.LineWidth=2;
%         set(h,'Color',colors(i,:));
%     end
%     title(names{fn});
%     legend(hdr);
%     export_fig(strcat(filenames{fn},'.pdf'),'-p0.02','-transparent');
% end