function nrml_jsd_glbl()
    %type of optz global = 0, multi = 1
    str = 'iat_nrml_jsd_glbl.csv';    
    fid = fopen('I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\IAT\new_filenames.txt');
    ln = fgetl(fid);
    mat=[];
    while ischar(ln)
        disp(ln);
        [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_jsd(ln) ;
        fnl_para = fnl_para';
        mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
        ln = fgetl(fid);                       
    end
    fclose(fid);
    csvwrite(str,mat);
    fclose('all');
end

function [para, jsd, ks_stat, r_sq] = min_jsd(fp)
    data1 = load(fp);
    %data1 = data1(1:end-1);
    %data1=data1*1000;
    [cdf_vals, pdf_vals, unqs] = init_data(data1);
    %cdfplot(data1)
    %%%%%%%%%%%%% generate random data%%%%%%    
    x0 = [randi(100) randi(100)];              
    x0 = x0';
    %calc_lsq_err(x0, 0, unqs, cdf_vals, 'nrml');
    %exit(code)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    f = @(x)jsd_pdf_grad(x',0, unqs, pdf_vals, 'nrml');          
    lb = [-inf eps];
    ub = [inf inf];        
    lb=lb'; %2k x 1
    ub = ub'; %2k x 1
    A=[];
    b=[];
    Aeq = [];
    beq = [];
    nonlcon = [];
    
    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0, 'lb', lb, 'ub', ub);
    gs = GlobalSearch('Display', 'iter');    
    [para, jsd] = run(gs, problem);    
    
    %calculate final cdf      
    cdf_th = normcdf(unqs, para(1), para(2));    
      
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);
    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);
      
    %plot cdfs
    %plot_cdf(unqs, cdf_vals, cdf_th);
end
