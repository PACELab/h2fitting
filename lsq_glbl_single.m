function lsq_glbl_single()
    %type of optz global = 0, multi = 1
    opt = 0;
    if opt == 0
        str = 'st_output_lsq_glbl_single.csv';
    elseif opt ==1
        str = 'output_lsq_multi_single.csv';
    end
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\IAT\file_names.txt'
    %'I:\study\Graduate\Summer\TraceAnalysis\traces\MSNStorageCFS\IAT\file_names.txt'
    fid = fopen('I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\ST\new_filenames.txt');
    ln = fgetl(fid);
    mat=[];
    while ischar(ln)
        disp(ln);
        [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_lsq(ln, opt) ;
        fnl_para = fnl_para';
        mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
        ln = fgetl(fid);                       
    end
    fclose(fid);
    csvwrite(str,mat);
    fclose('all');
end

function [para, jsd, ks_stat, r_sq] = min_lsq(fp, opt)
    data1 = load(fp);
%     data1 = data1(1:end-1);
    [cdf_vals, pdf_vals, unqs] = init_data(data1);   
    x0 = randi(100);
    lb = [eps];
    ub = [inf];    
    A=[];
    b=[];
    Aeq = [];
    beq = [];
    nonlcon = [];
    f = @(x)calc_lsq_err([x], 1,unqs, cdf_vals, 'Exponential');
    %options = optimoptions('fmincon','Display','iter');
    %[para, fval] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);    
    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0, 'Aeq', Aeq, 'beq', beq, 'lb', lb, 'ub', ub);
    if(opt == 0)
        disp("GlobalSearch");
        gs = GlobalSearch('Display', 'iter');
        [para, fval] = run(gs, problem);
    elseif(opt ==1)
        disp("Multistart");
        ms =  MultiStart('Display', 'iter');
        [para, fval] = run(ms, problem, 50);            
    end    
        
    %calculate final cdf    
    prob = [1];
    lmbd = para;    
    cdf_th = cdf_all(para, 1, unqs, 'Exponential');% calc_hyp_cdf(unqs, prob, lmbd);
    
    %calculate jsd
    delta = 10^(-7);        
    intv_p = unqs + delta; 
    intv_n = unqs - delta;
    intv_n(intv_n<0) = 0;   
    cdf_p = cdf_all(para, 1, intv_p, 'Exponential');%calc_hyp_cdf(intv_p, prob, lmbd);
    cdf_n = cdf_all(para, 1, intv_n, 'Exponential');%calc_hyp_cdf(intv_n, prob, lmbd);
    pdf_calc = cdf_p - cdf_n;
    jsd = calc_jsd(pdf_vals, pdf_calc)    
    
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);
    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);
    
    %plot cdfs
%     plot_cdf(unqs, cdf_vals, cdf_th);

end