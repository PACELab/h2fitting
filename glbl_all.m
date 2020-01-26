function glbl_all()
    % desc:
    %calculate the best fitting parameters with jsd, k-s stat and r^2 values using the value('lsq' or 'jsd') assigned to obj    
    type='iat';    %interarrival time(iat) service time(st)
    obj = 'lsq';
    trace_name='SO';
    %{'Normal', 'Weibull', 'Poisson', 'Beta', 'BirnbaumSaunders', 'Burr', 'Extreme Value', 'Gamma', 'Generalized Extreme Value', 'Generalized Pareto', 'HalfNormal', 'InverseGaussian', 'Logistic', 'LogLogistic', 'Lognormal', 'Nakagami', 'Rayleigh', 'Rician', 'Stable', 'tLocationScale', 'Binomial', 'Negative Binomial'}    
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\MSNStorageCFS\IAT\file_names.txt'
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\'
    % 'Normal', 'Weibull', 'Poisson', 'Beta', 'BirnbaumSaunders', 'Burr', 'Extreme Value', 'Gamma', 'Generalized Extreme Value', ...
    %        'Generalized Pareto', 'HalfNormal', 'InverseGaussian', 'Logistic', 'LogLogistic', 'Lognormal', 'Nakagami', 'Rayleigh',
    for dist = { 'Exponential', 'hyp', 'tLocationScale', 'Rician'}
        fn = '/users/Jasim9/working/file_names.txt';
        fid = fopen(fn);
        ln = fgetl(fid);
        mat=[];
        while ischar(ln)
            disp(ln);
            disp(dist);
            [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_all(ln, dist, obj) ;
            fnl_para = fnl_para';
            mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
            ln = fgetl(fid);                       
        end
        fclose(fid);        
        csvwrite(char(strcat(trace_name,'_',type,'_',dist,'_',obj,'_','glbl.csv')),mat);
        fclose('all');
    end
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