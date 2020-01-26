function [varargout] = hyperexpxcdf(x,varargin)

temp=0;
nargin

for i = 1:((nargin-1)/2)
    p=varargin{i}
    mu=varargin{((nargin-1)/2)+i}
    temp=temp+p*exp(-x*mu);
end

[varargout{1:max(1,nargout)}] = 1-temp;

end
% 
% 
% function [p] = localhyperexpxcdf(x,p1,mu1,p2,mu2,p3,mu3,p4,mu4)
% 
% p2=1-p1;
% mean2=(mean-p1*mean1)/p2;
% 
% if(p2 < 0)
%     disp('p2 is negative!');
% end
% if(mean2 < 0)
%     disp('mean2 is negative!');
% end
% 
% p=1-(p1*exp(-x*mean1)+p2*exp(-x*mean2));
% end
