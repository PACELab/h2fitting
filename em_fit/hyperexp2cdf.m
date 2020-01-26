function [varargout] = hyperexp2cdf(x,p1,mean1,mean)

[varargout{1:max(1,nargout)}] = localhyperexp2cdf(x,p1,mean1,mean);

end


function [p] = localhyperexp2cdf(x,p1,mean1,mean) 

p2=1-p1;
mean2=(mean-p1*mean1)/p2;

if(p2 < 0)
    disp('p2 is negative!');
end
if(mean2 < 0)
    disp('mean2 is negative!');
end

p=1-(p1*exp(-x*mean1)+p2*exp(-x*mean2));
end
