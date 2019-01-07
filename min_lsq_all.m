function [para, jsd, ks_stat, r_sq] = min_lsq_all(fp, dist, k, x0, lb, ub, A, b, Aeq, beq, nonlcon)    
    data1 = load(fp);    
%     data1 = data1(1:end);
    data1 = sort(data1);
    [cdf_vals, pdf_vals, unqs] = init_data(data1);    
%     calc_lsq_err(x0, 0, unqs, cdf_vals, dist)
%     exit(code)
    %cdfplot(data1)            
    f = @(x)calc_lsq_err(x, k, unqs, cdf_vals, dist);                

    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0,'Aineq',A, 'bineq', b, 'Aeq', Aeq, 'beq', beq, 'nonlcon', nonlcon, 'lb', lb, 'ub', ub);
    gs = GlobalSearch('Display', 'iter');    
    [para, fval] = run(gs, problem);    
       
    %calculate final cdf      
    cdf_th = cdf_all(para, k, unqs, dist);    
    %calculate jsd
    delta = 10^(-9);        
    
    intv_p = unqs + delta;
    intv_n = unqs - delta;
    %intv_n(intv_n<0) = 0;   
    cdf_p = cdf_all(para, k, intv_p, dist);    
    cdf_n = cdf_all(para, k, intv_n, dist);    
%     unqs(1:10)
%     intv_p(1:10)
%     intv_n(1:10)
%     cdf_p(1:10)
%     cdf_n(1:10)
%     tmp=(cdf_p~=cdf_n)
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
      
    %plot cdfs
    %plot_cdf(unqs, cdf_vals, cdf_th);
end
