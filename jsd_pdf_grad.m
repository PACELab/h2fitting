
function jsd = jsd_pdf_grad(para, k, unqs, pdf_vals, dist)
    %desc:
    %discretizes the hyperexponential distribution and calculates the jsd between
    %data and hyperexponential distribution
    %input:
    %para: 1 x 2k array of probabilities and lambdas for hyper exponential
    %distribution
    %k: scalar integer indicating the number of exponentials in the
    %hyper-exponential
    %unqs: n x 1 vector of distinct normalized data points
    %pdf_vals: n x 1 pdf of data at each point in unqs
    %output:
    %jsd: jensen shannon divergence value between pdf of data and
    %hyperexponential distribution
    delta = 10^(-7);        
    intv_n = unqs - delta;
    %intv_n(intv_n<0) = 0;
    intv_p = unqs + delta;        
    cdf_p = cdf_all(para, k, intv_p, dist);
    cdf_n = cdf_all(para, k, intv_n, dist);    
    pdf_calc = cdf_p - cdf_n;
%     if(strcmp(dist, 'hyp'))        
%         prob = para(1:k);
%         lmbd = para(k+1:2*k);                       
%         %discretize hyperexponential distirbution
%         intv_n = unqs - delta;
%         intv_n(intv_n<0) = 0;
%         intv_p = unqs + delta;        
%         %     size(intv_n)
%         %     size(intv_p)
%         %     size(prob)
%         %     size(lmbd)
%     
%         cdf_p = calc_hyp_cdf(intv_p, prob, lmbd);
%         cdf_n = calc_hyp_cdf(intv_n, prob, lmbd);    
%         pdf_calc = cdf_p - cdf_n;
%         para;
%         cdf_p(end-5:end);
%     %     cdf_n(end-5:end)
%     %     pdf_calc(end-5:end)
%     elseif(strcmp(dist, 'nrml'))
%         intv_p = unqs + delta; 
%         intv_n = unqs - delta;        
%         intv_n(intv_n<0) = 0;         
%         cdf_p = normcdf(intv_p, para(1), para(2));    
%         cdf_n = normcdf(intv_n, para(1), para(2));    
%         pdf_calc = cdf_p - cdf_n;
%     end    
    if(pdf_calc == 0)
        jsd=1;
    else
        pdf_calc(1:10);
        jsd = calc_jsd(pdf_vals, pdf_calc);
        if(jsd == 0)
            jsd = 1;
        end    
    end
end
