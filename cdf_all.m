function cdf_th = cdf_all(para, k, unqs, dist)
%desc:
%calculates the cdf of all the distributions 
%input:
% para: the parameters of the distribution, 
%k: k is the number of phases for the hyperexponential distribution
%dist: name of the distribution
%returns: cdf of the specified distribution
    if(strcmp(dist, 'hyp'))
        cdf_th = para(1).*cdf('Exponential', unqs, 1/para(2)) + (1-para(1)).*cdf('Exponential', unqs, 1/para(3));%calc_hyp_cdf(unqs, prob, lmbd);
    elseif(strcmp(dist, 'Normal'))
        cdf_th = normcdf(unqs, para(1), para(2));        
    elseif(strcmp(dist, 'Weibull'))
        cdf_th = cdf('Weibull', unqs, para(1), para(2));
    elseif(strcmp(dist, 'Poisson'))
        cdf_th = cdf('Poisson', unqs, para(1));        
    elseif(strcmp(dist, 'Beta'))        
        cdf_th = cdf('Beta', unqs, para(1), para(2));
    elseif(strcmp(dist, 'BirnbaumSaunders'))        
        cdf_th = cdf('BirnbaumSaunders', unqs, para(1), para(2));
    elseif(strcmp(dist, 'Burr'))        
        cdf_th = cdf('Burr', unqs, para(1), para(2), para(3));
    elseif(strcmp(dist, 'Extreme Value'))        
        cdf_th = cdf('Extreme Value', unqs, para(1), para(2));
    elseif(strcmp(dist, 'Gamma'))        
        cdf_th = cdf('Gamma', unqs, para(1), para(2));
    elseif(strcmp(dist, 'Generalized Extreme Value'))        
        cdf_th = cdf('Generalized Extreme Value', unqs, para(1), para(2), para(3));
    elseif(strcmp(dist, 'Generalized Pareto'))        
        cdf_th = cdf('Generalized Pareto', unqs, para(1), para(2), para(3));
    elseif(strcmp(dist, 'HalfNormal'))        
        cdf_th = cdf('HalfNormal', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'InverseGaussian'))        
        cdf_th = cdf('InverseGaussian', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'Logistic'))        
        cdf_th = cdf('Logistic', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'LogLogistic'))        
        cdf_th = cdf('LogLogistic', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'Lognormal'))        
        cdf_th = cdf('Lognormal', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'Nakagami'))        
        cdf_th = cdf('Nakagami', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'Rayleigh'))        
        cdf_th = cdf('Rayleigh', unqs, para(1));    
    elseif(strcmp(dist, 'Rician'))        
        cdf_th = cdf('Rician', unqs, para(1), para(2));    
    elseif(strcmp(dist, 'Stable'))        
        cdf_th = cdf('Stable', unqs, para(1), para(2), para(3), para(4));    
    elseif(strcmp(dist, 'tLocationScale'))        
        cdf_th = cdf('tLocationScale', unqs, para(1), para(2), para(3));        
    elseif(strcmp(dist, 'Exponential'))        
        cdf_th = cdf('Exponential', unqs, 1/para(1));    
        %cdf_th = 1 - exp(-1*para(1).*unqs);
    end            
end