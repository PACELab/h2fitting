function r_sq = calc_rsq(y, y_calc)
    %desc:
    %calculates the r^2 metric between the calculated and actual cdf
    %input:
    %y: n x 1 vector of actual cdf of data
    %y_calc: n x 1 vector of calculated cdf of data
    r_sq = 1 - (sum((y - y_calc).^2)/sum((y - mean(y)).^2));
end