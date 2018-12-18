function jsd = jsd_glbl_grad_single(x, unqs, pdf_vals)
    %desc:
    %calculate the the jsd for a single exponential distribution
    size(unqs);
    size(pdf_vals);           
    delta = 10^(-7);    
    intv_p = unqs + delta;
    intv_n = unqs - delta;
    intv_n(intv_n<0) = 0;        
%     intv_p(1) = 0;
    prob=[1];    
    cdf_p = cdf_all(x, 1, intv_p, 'Exponential');%;calc_hyp_cdf(intv_p, prob, x);
    cdf_n = cdf_all(x, 1, intv_n, 'Exponential');%calc_hyp_cdf(intv_n, prob, x);        
    pdf_calc = cdf_p - cdf_n;
    f = calc_jsd(pdf_vals, pdf_calc);            
    if f == 0
        jsd=1;
    else
        jsd=f;
    end
end