%desc
%plots the actual and calculated cdfs
%input:
%unqs: n x 1 vector of distinct data points
%cdf_vals: n x 1 vector of cdf of data
%cdf_th: n x 1 vector of calculated cdf
function plot_cdf(unqs, cdf_vals, cdf_th)
    plot(unqs, cdf_vals);
    hold on
    plot(unqs, cdf_th);
    legend('cdf data', 'cdf calc');
    title('Actual vs Calculated');
    xlabel('Points');
    ylabel('Probability');

end