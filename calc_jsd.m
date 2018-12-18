function jsd = calc_jsd(P, Q)                     
    %desc:
    %calculates the Jensen-Shannon divergence between two discrete probability
    %distributions
    %input:
    %P: n x 1 vector containing pmf of first distribution
    %Q: n x 1 vector containing pmf of second distribution
    %normalize P and Q
    if(sum(Q)~=1)
        Q = Q./sum(Q);
    end
    if(sum(P)~=1)
        P = P./sum(P);
    end    
    M = P+Q;
    M=M./2;        
    val = (nansum(P.*log(P./M)) + nansum(Q.*log(Q./M)));
    jsd = val/(2*log(2)) ;%+ ((1-nansum(Q))/2);
end