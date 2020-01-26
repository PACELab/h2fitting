validation_results={};
dists2=[dists 'hyperexponential'];
for i=1:length(dists2)
    if strcmp('rician',dists2(i))
        continue
    end
    validation_results=[validation_results;[dists2{i} num2cell(validation_nloglike(dists2{i})) ]];
end
validation_results=validation_results';