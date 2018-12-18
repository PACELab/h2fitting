function cdf_th = calc_hyp_cdf(x, prob, lmbd)
    %desc:
    %calculate the cdf of hyper exponential distribution
    %input:
    %x: n x 1 vector of data points
    %let k be the number of exponential distributions in the hyper-exponential
    %prob: 1 x k array of probabilities of each individual exponential distribution
    %lmbd: 1 x k array of lmbds(1/mean) of each individual exponential distribution
    %output:
    %cdf_th: n x 1 vector containing values of the cdf at each point in x
    cdf_th = prob(1).*cdf('Exponential', x, 1/lmbd(1)) + prob(2).*cdf('Exponential', x, 1/lmbd(2));
end