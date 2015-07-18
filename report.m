function fname = report(fname,flag,s)

if flag ==1
    chemin='/ufs/fortes/Desktop/tomo_m_files/Wfunctions/';
    fname=sprintf('%sreport.txt',chemin);
    fid=fopen(fname,'a+');
    
%     fprintf(fid,'\\documentclass[oneside]{article}\n');
%     fprintf(fid,'\\usepackage [brazil]{babel}\n');
%     fprintf(fid,'\\usepackage {amsthm,amsfonts}\n');
%     fprintf(fid,'\\usepackage {amsmath,amssymb}\n');
%     fprintf(fid,'\\usepackage[latin1]{inputenc}\n');
%     fprintf(fid,'\\pagestyle{myheadings} \\marginparwidth = 20pt \\evensidemargin = 38pt\n');
%     fprintf(fid,'\\oddsidemargin = 38pt \\textheight = 595pt \\textwidth = 420pt\n');
%     fprintf(fid,'\\linespread{1.3}\n\n');
%     
%     fprintf(fid,'\\begin{document}\n\n');
    fclose(fid);
elseif flag == 2
    fid=fopen(fname,'a');
    
% img = num2str(s.img_index);
% rat = num2str(s.ratio);
% sz = num2str(s.img_sz);

fprintf(fid,'%s \t Im %d \t ratio=%d \t sz=%d \n',s.type,s.img_index,s.ratio,s.img_sz);    
fprintf(fid,'ubxls=%g \t uxls=%g \t lxls=%g \t fracbls=%g \t R1=%g \t R2=%g \t fracR=%g \t NR=%g \n\n',s.ubxls,s.uxls,s.lxls,s.fracbls,s.R1,s.R2,s.fracR,s.NR);    
%     fprintf(fid,'Number of Projections: %d \t N of image: %d\n',s.N_proj,s.image_index);
%     fprintf(fid,'$\n|\\|sol\\|_2^2-\\frac{\\|Q\\|_1}{N_p}|=%s$\n',s.normPQ);
%     fprintf(fid,'\n$\\|p-Wx^*\\|_2=%s\\qquad\\frac{\\|p-Wx^*\\|_2}{\\|p\\|_2}=%s$\n',s.residual,s.relres);
%     fprintf(fid,'\n$\\|sol-x^*\\|_2=%s\\qquad\\frac{\\|sol-x^*\\|_2}{\\|sol\\|_2}=%s$\n',s.error,s.relerror);
%     fprintf(fid,'\n Checking orthogonality:\n');
%     fprintf(fid,'\n$\\|v_1\\|^2_2=\\|sol-x^*\\|^2_2=%s\\qquad\\|v\\|^2_2=\\frac{|\\|p\\|_1}{N_p}-\\|x^*\\|^2_2|=%s$\n',s.normV1,s.normV);
%     fprintf(fid,'\n$|\\|v\\|^2_2-\\|v_1\\|^2_2|=%s\\qquad\\frac{|\\|v\\|^2_2-\\|v_1\\|^2_2|}{\\|v_1\\|_2^2}=%s\\quad$ if it make sense\n\n',s.dV1V,s.reldV1V);
%     fprintf(fid,'\n The radius is $\\|v\\|_2$=%s\n',s.radius);
%     fprintf(fid,'\n$\\|sol-y\\|_2\\leq\\|sol-x^*\\|_2+\\|y-x^*\\|_2=2\\|v_2\\|_2$=%s (diameter)\n',s.diameter);
%     fprintf(fid,'\n$d(y)=\\sum_j(sol_j-y_j)^2=\\|sol-y\\|^2_2\\leq4\\|v\\|_2^2$=%s\n',s.upperror);
%     fprintf(fid,'\n variability: $\\frac{4\\|v\\|_2^2}{n}$=%s\n',s.variability);
%     fprintf(fid,'\n \\paragraph{}\n');
    fclose(fid);
elseif flag == 3
    fid=fopen(fname,'a');
    fprintf(fid,'\n\\end{document}');
    fclose(fid);
end