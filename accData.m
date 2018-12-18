function accData()
%helper function :
%context: The data for different distributions processed is stored in files with file format type_distName_obj_glbl.csv
%where type is "iat" or "st"
%distName is anyone of the following {'InverseGaussian','Rayleigh', 'Rician', 'tLocationScale','Logistic','Nakagami','Lognormal'}%{'Beta', 'BirnbaumSaunders', 'Extreme Value', 'Gamma', 'Generalized Extreme Value', 'Generalized Pareto', 'HalfNormal', 'Normal', 'hyp', 'Exponential', 'Weibull', 'Burr'}
%This functions accumulates data from the files of same type and obj and places ti in a new file which is useful for finding collective stats

    path = "I:\study\Graduate\Summer\TraceAnalysis\weekly results\last\systorlsq\";
    trace = "Sys";%trace name e.g Sys for Systor
    type = 'iat';
    obj = 'lsq';
    limit = 8 %number of traces
    mat = [];
    if(strcmp(obj, 'lsq'))
        colu = 3
    else 
        colu=1
    end
    %, 
    for dist = {'InverseGaussian','Rayleigh', 'Rician', 'tLocationScale','Logistic','Nakagami','Lognormal'}%{'Beta', 'BirnbaumSaunders', 'Extreme Value', 'Gamma', 'Generalized Extreme Value', 'Generalized Pareto', 'HalfNormal', 'Normal', 'hyp', 'Exponential', 'Weibull', 'Burr'}
%         dist
        s = strcat(path, trace, '_', type, '_', dist, '_',obj,'_glbl','.csv')
        fp = csvread(char(s));
        req_col = fp(1:limit, colu);
        size(req_col);
        mat = [mat, req_col];        
    end 
    csvwrite(char(strcat(path, trace,'_', type, '_',obj,'_count2.csv')),mat);
end

