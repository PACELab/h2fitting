function lsq_glbl()
    fid = fopen('I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\ST\file_names.txt');
    ln = fgetl(fid);
    mat=[];
    while ischar(ln)
        disp(ln);
        [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_lsq(ln, 2) ;
        fnl_para = fnl_para';
        mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
        ln = fgetl(fid);                       
    end
    fclose(fid);
    csvwrite('tmp_st_output_lsq_glbl.csv',mat);
    fclose('all');
end


function [para, jsd, ks_stat, r_sq] = min_lsq(fp, k)
    data1 = load(fp);
%     data1 = data1(1:end-1);
    %data1=data1*1000;
    [cdf_vals, pdf_vals, unqs] = init_data(data1);
    %cdfplot(data1)
    %%%%%%%%%%%%% generate k random data%%%%%%    
    r = rand();
%     r = r./sum(r);
    l = randi(100,1, 2);
    x0 = [r, l];
    x0=x0'; %3x1       
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    f = @(x)calc_lsq_err(x', k, unqs, cdf_vals, 'hyp');    
    lb_pb = 0;
    lb_lmbd = ones(1,k)*eps;
    ub_pb = 1;
    ub_lmbd = inf(1,k);
    lb = [lb_pb lb_lmbd];
    ub = [ub_pb ub_lmbd];        
    lb=lb'; %2k x 1
    ub = ub'; %2k x 1
    A=[];
    b=[];
    Aeq = [];%[ones(1,k) zeros(1,k)];
    beq = [];%;
    nonlcon = [];
    
    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0, 'Aeq', Aeq, 'beq', beq, 'lb', lb, 'ub', ub);
    gs = GlobalSearch('Display', 'iter');    
    [para, fval] = run(gs, problem);
%     para(1)
%     para(2)
    %calculate final cdf    
%     prob = para(1:k);
%     lmbd = para(k+1:2*k);   
    cdf_th = cdf_all(para, k, unqs, 'hyp');%calc_hyp_cdf(unqs, prob', lmbd');
    
    %calculate jsd
    delta = 10^(-7);        
    intv_p = unqs + delta; 
    intv_n = unqs - delta;
%     intv_n(intv_n<0) = 0;   
    cdf_p = calc_hyp_cdf(intv_p, prob', lmbd');
    cdf_n = calc_hyp_cdf(intv_n, prob', lmbd');
    pdf_calc = cdf_p - cdf_n;
    jsd = calc_jsd(pdf_vals, pdf_calc);    
    
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);
    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);
      
    %plot cdfs
    %plot_cdf(unqs, cdf_vals, cdf_th);
end
