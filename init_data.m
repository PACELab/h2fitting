function [cdf_vals, pdf_vals, unqs] = init_data(x)
    %desc:
    %normalizes the data, calculates pdf, cdf and unique data points
    %input:
    %x: n x 1 vector of discrete data where n is size of data
    %output:
    %cdf_vals: m x 1 vector of cdf values at the i^th point where i is a point
    %among the m distinct points in data x
    %pdf_vals: m x 1 vector containing the probability at the i^th point where
    %is a point among the m distinct points in data x
    %unqs: m x 1 vector containing normalized distinct data points
    %get cdf and unique points
    [cdf_vals, unq_tmp] = ecdf(x);    
    %first two values returned by ecdf are same, so remove the duplicates    
    unq_tmp = unq_tmp(2:end);
    cdf_vals = cdf_vals(2:end);
    
    %calculate pdf
    ttl = size(x, 1);
    v = unq_tmp;    
    v = vertcat(v, v(end) + 1);        
    cnts = histcounts(x, v);    
    pdf_vals = cnts./ttl;
    pdf_vals = pdf_vals';
    
    %normalize unique points
      unqs = unq_tmp;
%     if(max(unq_tmp)< 1)
%          unqs = unq_tmp   ;  
%     else
%     unq_min = min(unq_tmp);
%     unq_max = max(unq_tmp);
%     diff = unq_max - unq_min;
%     unqs = (unq_tmp - unq_min)./diff;
%     end    
end