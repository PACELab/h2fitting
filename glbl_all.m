function glbl_all()
    % desc:
    %calculate the best fitting parameters with jsd, k-s stat and r^2 values using the value('lsq' or 'jsd') assigned to obj    
    type='iat';    %interarrival time(iat) service time(st)
    obj = 'jsd';
    trace_name='FIU';
    %{'Normal', 'Weibull', 'Poisson', 'Beta', 'BirnbaumSaunders', 'Burr', 'Extreme Value', 'Gamma', 'Generalized Extreme Value', 'Generalized Pareto', 'HalfNormal', 'InverseGaussian', 'Logistic', 'LogLogistic', 'Lognormal', 'Nakagami', 'Rayleigh', 'Rician', 'Stable', 'tLocationScale', 'Binomial', 'Negative Binomial'}    
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\MSNStorageCFS\IAT\file_names.txt'
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\'
%     for dist = {'Exponential'}
% %         path = 'I:\study\Graduate\Summer\TraceAnalysis\traces\MSNStorageC\';
%         fid = fopen('fiu_traces.txt');
%         ln = fgetl(fid);
%         mat=[];
%         while ischar(ln)
%             disp(ln);
%             disp(dist);
%             [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_all(ln, dist, obj);
%             fnl_para = fnl_para';
%             mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
%             ln = fgetl(fid);                       
%         end
%         fclose(fid);        
%         csvwrite(char(strcat(trace_name,'_',type,'_',dist,'_',obj,'_','glbl.csv')),mat);
%         fclose('all');
%     end

     [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_hyp_K('fiu-iodedup-interarrival-times/sorted_home3_ext3_reads.txt', obj);
end

function [para, jsd, ks_stat, r_sq] = min_all(fp, dist, obj)
%minimize for ezch distribution
    if(strcmp(dist, 'Normal'))
        x0 = [randi(100); randi(10)];                  
        lb = [-inf; eps];
        ub = [inf; inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Weibull'))
        %[scale shape]
        x0 = [randi(10); randi(10)];                  
        lb = [eps; eps];
        ub = [inf; inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Poisson'))
        x0 = [randi(10)];
        lb = [eps];
        ub = [inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Beta'))        
        x0 = [randi(10);randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'BirnbaumSaunders'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Burr'))
        %scale shape
        x0 = [randi(10); randi(10); randi(10)];
        lb = [eps;eps;eps];
        ub = [inf;inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Extreme Value'))
        x0 = [randi(10); randi(10)];
        lb = [-inf;eps];
        ub = [inf;inf];
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Gamma'))
        x0 = [randi(10); randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Generalized Extreme Value'))
        %scale shape
        x0 = [randi(10); randi(10); randi(10)];
        lb = [-inf;eps;-inf];
        ub = [inf;inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Generalized Pareto'))
        %scale shape
        x0 = [randi(10); randi(10); randi(10)];
        lb = [-inf;eps;-inf];
        ub = [inf;inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'HalfNormal'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [-inf;0];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'InverseGaussian'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Logistic'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [-inf;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'LogLogistic'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Lognormal'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [-inf;0];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Nakagami'))
        %scale shape
        x0 = [randi(10); randi(10)];
        lb = [eps;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Rayleigh'))
        %scale shape
        x0 = [randi(10)];
        lb = [eps];
        ub = [inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Rician'))
        %scale shape
        x0 = [randi(10);randi(10)];
        lb = [0;eps];
        ub = [inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Stable'))
        %scale shape
        x0 = [2*rand+eps;rand-randi([0,1]);randi(10);randi(10)];
        lb = [eps;-1;eps;-inf];
        ub = [2;1;inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'tLocationScale'))
        %scale shape
        x0 = [randi([-10,10]);randi(10); randi(10)];
        lb = [-inf;eps;eps];
        ub = [inf;inf;inf]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Negative Binomial'))
        %scale shape
        x0 = [randi(10);rand];
        lb = [1;0];
        ub = [inf;1]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'Binomial'))
        %scale shape
        x0 = [randi(10);rand];
        lb = [1;0];
        ub = [inf;1]; 
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);        
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
        end
    elseif(strcmp(dist, 'hyp'))
        x0 = [rand();randi(10);randi(10)];
        lb = [0;eps;eps];
        ub = [1;inf;inf];
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
            para =[para(1);1-para(1);para(2);para(3)];            
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
            para = [para(1);1-para(1);para(2);para(3)];
        end
    elseif(strcmp(dist, 'Exponential'))
        x0 = [randi(10)];
        lb = [eps];
        ub = [inf];
        if(strcmp(obj, 'lsq'))
            [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
%             para =[para(1);1-para(1);para(2);para(3)];            
        elseif(strcmp(obj, 'jsd'))
            [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, 0, x0, lb, ub, [], [], [], [], []);
%             para = [para(1);1-para(1);para(2);para(3)];
        end
    end
    
end

function [para, jsd, ks_stat, r_sq] = min_hyp_K(fp, obj)
    if(strcmp(obj, 'lsq'))
        [para, jsd, ks_stat, r_sq] = min_lsq_Hyp(fp);
        para =[para(1);1-para(1);para(2);para(3)];
    elseif(strcmp(obj, 'jsd'))
        [para, jsd, ks_stat, r_sq] = min_jsd_hyp(fp);
        para = [para(1);1-para(1);para(2);para(3)];
    end
end

function [para, jsd, ks_stat, r_sq] = min_lsq_Hyp(fp)    
    data1 = load(fp);    
    data1 = sort(data1);
    times=ones(5,10);
    rsquared=ones(5,10);
    for r=1:5
        fprintf(1,'Run number %d',r);
        for k=1:10
            fprintf(1,'Now running for %d',k);
            p0=rand(k,1);
            p0=p0./norm(p0,1);
            x0 = [p0;randi(10,k,1)];
            lb = [zeros(k,1);eps*ones(k,1)];
            ub = [ones(k,1);inf*ones(k,1)];

            if k>1
                beq=1;
                Aeq=[ones(1,k) zeros(1,k)];
                dist='hyp';
            else
                Aeq=[];
                beq=[];
                x0 = randi(10);
                lb = eps;
                ub = inf;
                dist='Exponential';
            end
            [cdf_vals, pdf_vals, unqs] = init_data(data1);    
            f = @(x)calc_lsq_err(x, k, unqs, cdf_vals, dist);
            tic;
            problem = createOptimProblem('fmincon', 'objective', f,'x0', x0,'Aineq',[], 'bineq', [], 'Aeq', Aeq, 'beq', beq, 'nonlcon', [], 'lb', lb, 'ub', ub);
            gs = GlobalSearch('Display', 'iter');    
            [para, fval] = run(gs, problem);    
            times(r,k)=toc;
            %calculate final cdf
            cdf_th = cdf_all(para, k, unqs, dist);    
            %calculate jsd
            delta = 10^(-9);        

            intv_p = unqs + delta;
            intv_n = unqs - delta;
            %intv_n(intv_n<0) = 0;   
            cdf_p = cdf_all(para, k, intv_p, dist);    
            cdf_n = cdf_all(para, k, intv_n, dist);    

            pdf_calc = cdf_p - cdf_n;
        %     pdf_calc(1:10)
            if(pdf_calc == 0)
                jsd=1;
            else
                jsd = calc_jsd(pdf_vals, pdf_calc);        
            end
            %calculate ks stat
            ks_stat = calc_ks(cdf_th, cdf_vals);

            %calculate r_sq
            r_sq = calc_rsq(cdf_vals, cdf_th);
            rsquared(r,k)=r_sq;

        end
    end
    csvwrite('times_lsq_runs.csv',times);
    csvwrite('rsquared_runs.csv',rsquared);

end

function [para, jsd, ks_stat, r_sq] = min_jsd_hyp(fp)
    data1 = load(fp);
    data1 = data1(1:end-1);
    times=ones(5,10);
    jsds=ones(5,10);
    for r=1:5
        fprintf(1,'Run number %d',r);
        for k=1:10
            fprintf(1,'Now running for %d',k);
            p0=rand(k,1);
            p0=p0./norm(p0,1);
            x0 = [p0;randi(10,k,1)];
            lb = [zeros(k,1);eps*ones(k,1)];
            ub = [ones(k,1);inf*ones(k,1)];
            
            if k>1
                beq=1;
                Aeq=[ones(1,k) zeros(1,k)];
                dist='hyp';
            else
                Aeq=[];
                beq=[];
                x0 = randi(10);
                lb = eps;
                ub = inf;
                dist='Exponential';
            end
            [cdf_vals, pdf_vals, unqs] = init_data(data1);
            f = @(x)jsd_pdf_grad(x,k, unqs, pdf_vals, dist);
            tic;
            problem = createOptimProblem('fmincon', 'objective', f,'x0', x0,'Aineq',[], 'bineq', [], 'Aeq', Aeq, 'beq', beq, 'nonlcon', [], 'lb', lb, 'ub', ub);
            gs = GlobalSearch('Display', 'iter');    
            [para, jsd] = run(gs, problem);     
            times(r,k)=toc;
            %calculate final cdf      
            cdf_th = cdf_all(para, k, unqs, dist);          
            %calculate ks stat
            ks_stat = calc_ks(cdf_th, cdf_vals);    
            %calculate r_sq
            r_sq = calc_rsq(cdf_vals, cdf_th);   
            jsds(r,k)=jsd;
        end
    end
    csvwrite('times_jsd_runs_home3reads.csv',times);
    csvwrite('jsds_runs_homes3reads.csv',jsds);
end
