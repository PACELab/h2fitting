function jsd_pdf_glbl()
%type of optz global = 0, multi = 1
    opt = 0;
    if opt == 0
        str = 'iat_output_jsd_glbl.csv';
    elseif opt ==1
        str = 'output_jsd_multi.csv';
    end
    fid = fopen('I:\study\Graduate\Summer\TraceAnalysis\traces\Nexus\Nexus5_Kernel_BIOTracer_traces\Trace_files\IAT\new_filenames.txt');
    ln = fgetl(fid);
    mat=[];
    while ischar(ln)
        disp(ln);
        [fnl_para, fnl_jsd, fnl_ks, fnl_rsq] = min_jsd(ln, 2, opt) ;
        fnl_para = fnl_para';
        mat=[mat;fnl_jsd, fnl_ks, fnl_rsq, fnl_para ];
        ln = fgetl(fid);                       
    end
    fclose(fid);
    csvwrite(str,mat);
    fclose('all');
%     [para, fval, ks_stat, r_sq] =  min_jsd('I:\study\Graduate\Summer\TraceAnalysis\1100-1149_readlink_sorted.txt',2)
end

function [para, fval, ks_stat, r_sq] = min_jsd(fp, k, opt)
    data1 = load(fp);
    data1 = data1(1:end-1);
    [cdf_vals, pdf_vals, unqs] = init_data(data1);
    %unqs(1:10)
    %%%%%%%%%%%%% generate k random data%%%%%%    
    r = randi(10, 1, k);
    r = r./sum(r);
    l = randi(100,1, k);
    x0 = [r, l];
    x0=x0'; %2k x 1   
    %jsd_pdf_grad(x0', k, unqs, pdf_vals);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    lb_pb = zeros(1,k);
    lb_lmbd = ones(1,k)*eps;
    ub_pb = ones(1,k);
    ub_lmbd = inf(1,k);
    lb = [lb_pb lb_lmbd];
    ub = [ub_pb ub_lmbd];        
    lb=lb'; %2k x 1
    ub = ub'; %2k x 1
    A=[];
    b=[];
    Aeq = [ones(1,k) zeros(1,k)];
    beq = 1;
    nonlcon = [];
    f = @(x)jsd_pdf_grad(x',k, unqs, pdf_vals,'hyp');
     
   % options = optimoptions('fmincon','SpecifyObjectiveGradient',true);
    
     %options = optimoptions('fmincon','Display','iter');
    problem = createOptimProblem('fmincon', 'objective', f,'x0', x0, 'Aeq', Aeq, 'beq', beq, 'lb', lb, 'ub', ub);
% [para, fval] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);    
    if(opt == 0)
        disp("GlobalSearch");
        gs = GlobalSearch('Display', 'iter');
        [para, fval] = run(gs, problem);
    elseif(opt ==1)
        disp("Multistart");
        ms =  MultiStart('Display', 'iter');
        [para, fval] = run(ms, problem, 50);            
    end    
    
    %calculate final cdf     
    prob = para(1:k);
    lmbd = para(k+1:2*k);    
    cdf_th = calc_hyp_cdf(unqs, prob', lmbd');
    
    %calculate ks stat
    ks_stat = calc_ks(cdf_th, cdf_vals);
    
    %calculate r_sq
    r_sq = calc_rsq(cdf_vals, cdf_th);
    
    %plot cdfs
    %plot_cdf(unqs, cdf_vals, cdf_th);
%     cdf_th(end-5:end);
end