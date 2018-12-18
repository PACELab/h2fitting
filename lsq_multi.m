function lsq_multi()
fid = fopen('I:\study\Graduate\Summer\TraceAnalysis\traces\MSNStorageCFS\IAT\new_filenames.txt');
    ln = fgetl(fid);
    mat=[];
    while ischar(ln)
        disp(ln);
        [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_lsq(ln) ;
        fnl_para = fnl_para';
        mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para(1) 1-fnl_para(1) fnl_para(2) fnl_para(3)];
        ln = fgetl(fid);                       
    end
    fclose(fid);
    csvwrite('output_lsq_multi.csv',mat);
    fclose('all');
%     [para, fval, ks_stat, r_sq] =  min_jsd('I:\study\Graduate\Summer\TraceAnalysis\1100-1149_readlink_sorted.txt',2)
end

function [para, jsd, ks_stat, r_sq] = min_lsq(fp)
    data1 = load(fp);
    [cdf_vals, pdf_vals, unqs] = init_data(data1);
    x0 = [rand(1,1), randi(10000,1, 2)];    
    x0 = x0';
    f = @(x)calc_lsq(x, unqs, cdf_vals);
    lb = [0;0;0];    
    ub = [1;inf;inf];
    problem = createOptimProblem('lsqnonlin', 'objective', f,'x0', x0, 'lb', lb, 'ub', ub);
    %gs = GlobalSearch('Display', 'iter');
    ms  = MultiStart('Display', 'iter');
    [para, resnorm, residual] = run(ms, problem, 50);
    
    %calculate final cdf    
    prob = [para(1) 1-para(1)];
    lmbd = [para(2) para(3)];    
    cdf_th = calc_hyp_cdf(unqs, prob, lmbd);
    
    %calculate jsd
    delta = 10^(-9);        
    intv_p = unqs + delta; 
    intv_n = unqs - delta;
    intv_n(intv_n<0) = 0;   
    cdf_p = calc_hyp_cdf(intv_p, prob, lmbd);
    cdf_n = calc_hyp_cdf(intv_n, prob, lmbd);
    pdf_calc = cdf_p - cdf_n;
    jsd = calc_jsd(pdf_vals, pdf_calc);    
    
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);
    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);
    
    %
    %plot cdfs
   % plot_cdf(unqs, cdf_vals, cdf_th);
end

function lsq = calc_lsq(para, unqs, cdf_vals)
    prob = [para(1) 1-para(1)];
    lmbd = [para(2) para(3)];  
    cdf_th = calc_hyp_cdf(unqs, prob, lmbd);
    lsq = cdf_th - cdf_vals;    
end