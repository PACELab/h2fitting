function loglik = emlikelihood(x,datatofit,ntaus)
    t=x(1:ntaus);
    w=x((ntaus+1):end);

    pdf = emdistpdfc(datatofit, t, w);
    disp(sum(pdf==0));
    pdf=pdf(pdf~=0);

    loglik = sum(log(pdf));
end