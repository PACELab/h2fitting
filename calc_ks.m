function ks_stat = calc_ks(cdf1, cdf2)
    %desc:
    %calculates the Kolmogorov�Smirnov test statistic between two cdfs
    %input:
    %cdf1: n x 1 vector of cdf of the first probability distribution
    %cdf2: n x 1 vector of cdf of the second probability distribution
    diff = cdf1 - cdf2;
    ks_stat = max(abs(diff));
end
