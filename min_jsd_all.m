function [para, jsd, ks_stat, r_sq] = min_jsd_all(fp, dist, k, x0, lb, ub, A, b, Aeq, beq, nonlcon)
    data1 = load(fp);
    data1 = data1(1:end-1);
%     data1=data1*1000;
    [cdf_vals, pdf_vals, unqs] = init_data(data1);
    %cdfplot(data1)
    %%%%%%%%%%%%% generate random data%%%%%%    
%     x0 = [randi(100) randi(100)];              
%     x0 = x0';
    %calc_lsq_err(x0, 0, unqs, cdf_vals, 'nrml');
    %exit(code)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    f = @(x)jsd_pdf_grad(x,k, unqs, pdf_vals, dist);                      
    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0,'Aineq',A, 'bineq', b, 'Aeq', Aeq, 'beq', beq, 'nonlcon', nonlcon, 'lb', lb, 'ub', ub);
    gs = GlobalSearch('Display', 'iter');    
    [para, jsd] = run(gs, problem);        
    %calculate final cdf      
    cdf_th = cdf_all(para, k, unqs, dist);          
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);      
    %plot cdfs
    %plot_cdf(unqs, cdf_vals, cdf_th);
end
