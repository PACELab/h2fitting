
function lsq = calc_lsq_err(para, k,unqs, cdf_vals, dist)
%desc:
%calculated the least square error between the cdf of hyperexponential
%distribution and the cdf of data
%input:
%para: para: 1 x 2k array of probabilities and lambdas for hyper exponential
%distribution
%k: scalar integer indicating the number of exponentials in the
%hyper-exponential
%unqs: n x 1 vector of distinct normalized data points
%cdf_vals: n x 1vector  cdf of data at each point in unqs
%output:
%lsq: least square error between the cdf of hyperexponential
%distribution and the cdf of databew
        cdf_th = cdf_all(para, k, unqs, dist);
        lsq = sum((cdf_th - cdf_vals).^2);
end