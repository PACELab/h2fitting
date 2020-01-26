results={};
for i=1:length(dists)
    disp(dists(i));
    results=[results;[dists{i} num2cell(M(dists{i})) ]];
end
results=results';