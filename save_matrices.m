% to store matrices
clear all
% path(path,'/ufs/fortes/Desktop/PhD_m_files/tomography')
a='started'

img_sz_set = 610;%[32,64,128,256,512];
type_set = 1;%[0,1];%[1,2,3];
[dir_a,dir_b]=mkdirvecs(20);
rand_v = [];

for img_sz = img_sz_set
    
    if img_sz==32
        N_proj_set = [1,2,4,6,8,10,12,14,16];
    elseif img_sz==64
        N_proj_set = [2,4,8,12,16,20,24,28,32];
    elseif img_sz==128
        N_proj_set = [4,8,16,20,24,28,32,40,48,56,64];
    elseif img_sz==256
        N_proj_set = [8,16,32,40,48,56,64,72,80,88,96,104];
    elseif img_sz==512
        N_proj_set = 168;%[8,16,32,48,64,72,80,88,96,104,112,120,136,152,168];%,184,200];
        elseif img_sz==610
        N_proj_set = [4,8,16,32,48,64,72,80];
    end
    
    for typecod = type_set
        if typecod == 0
            type = 'grid';
        elseif typecod == 1
            type = 'strip';
        elseif typecod == 2
            type = 'line';
        elseif typecod == 3
            type = 'linear';
        end
        
        for N_proj = N_proj_set
                        if ~strcmp(type,'grid')
                            proj_geom = astra_create_proj_geom('parallel',1.0,img_sz,linspace2(0,7*pi/8,N_proj));%(0,pi,N_proj));
%                             proj_geom = astra_create_proj_geom('parallel',1.0,img_sz,atan(dir_b(1:N_proj)./dir_a(1:N_proj)));
                            vol_geom = astra_create_vol_geom(img_sz,img_sz);
            
                            proj_id = astra_create_projector(type, proj_geom, vol_geom);
                            matrix_id = astra_mex_projector('matrix', proj_id);
            
                            M = astra_mex_matrix('get',matrix_id);
                            astra_mex_matrix('delete',matrix_id);
                            astra_mex_projector('delete',proj_id);
                        else
                            M = mkmatrix(img_sz,img_sz,dir_a(1:N_proj),dir_b(1:N_proj)); % taking the
                        end
            
            
%             address = '/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
%             M = loadmatrix(address,img_sz,N_proj,type,'matrix');
            
            sz = num2str(img_sz);
            proj = num2str(N_proj);
            %
            %------------- save matrix M
            %
            chemin='/export/scratch1/fortes/PhD_files/Load/gaussian_noise/matrix_angle_eq_distr/';
%             chemin='/export/scratch1/fortes/PhD_files/Load/gaussian_noise/matrix_conserve_angles/';
                        varname = 'M';
                        filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
                        save(filename,varname,'-v7.3');
                        clear M
            %
            %------------- create and save singular values of M
            %
%             sv = svds(M);
%             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
%             varname = 'sv';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname);
            %
            %------------- create and save random factor
            %
            %             randfactor = -1+2.*rand(size(M,1),1);
            %             randfactor = [rand_v;randfactor(length(rand_v)+1:length(randfactor))];
            %             rand_v = randfactor;
            %
            %             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
            %             varname = strcat('randfactor');
            %             filename = strcat(chemin,varname,'-sz',sz,'-proj',proj);
            %             save(filename,varname);
            %
            %------------- create and save Moore-Penrose pseudo-inverse
            %
            %             pinvM = pinv(full(M));
            %             clear M
            %
            %             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
            %             varname = 'pinvM';
            %             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
            %             save(filename,varname);
            %
            %------------- create and save singular values of the pseudo-inverse
            %
%             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
%             pinvM = loadmatrix(address,img_sz,N_proj,type,'pinvM');
%             sv_pinv = svd(pinvM);
%             address = '/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
% %             sv_pinv = loadmatrix(address,img_sz,N_proj,type,'sv_pinv');
%             
%             varname = 'sv_pinv';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname);
%             
%             clear pinvM
            %------------- create and save singular values 
            
%             [U,S,V] = svd(full(M));
%             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
%             varname = 'U';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname,'-v7.3');
%             varname = 'V';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname,'-v7.3');
%             varname = 'S';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname,'-v7.3');

%------------- create and save

%             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
%             S = loadmatrix(address,img_sz,N_proj,type,'S');
%             pinvS = pinv(S);
%             address = '/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
%             
%             varname = 'pinvS';
%             filename = strcat(chemin,varname,'-',type,'-sz',sz,'-proj',proj);
%             save(filename,varname);
%             
%             clear pinvM
        end
    end
    rand_v = [];
end

a ='finished'
%%
% 
% clear all
% % path(path,'/ufs/fortes/Desktop/PhD_m_files/tomography')
% a='started'
% 
% img_index_set = [1,2,3,5];
% img_sz_set = [32,64,128,256,512];
% vari_set = [1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7];
% type_set = [0,1];%[1,2,3];
% rand_v = [];
% 
% for img_index = img_index_set
%     for img_sz = img_sz_set
%         
%         if img_sz==32
%             N_proj = 16;
%         elseif img_sz==64
%             N_proj = 32;
%         elseif img_sz==128
%             N_proj = 64;
%         elseif img_sz==256
%             N_proj = 104;
%         elseif img_sz==512
%             N_proj = 200;
%         end
%         
%         for typecod = type_set
%             if typecod == 0
%                 type = 'grid';
%             elseif typecod == 1
%                 type = 'strip';
%             elseif typecod == 2
%                 type = 'line';
%             elseif typecod == 3
%                 type = 'linear';
%             end
%             
%             for vari = vari_set
%                 
%                 address = '/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
%                 M = loadmatrix(address,img_sz,N_proj,type,'matrix');
%                                
%                 P = img_read(img_index,img_sz);
%                 P = reshape(P,img_sz^2,1);
%                 P = double(P);
%                 P = P/norm(P,inf); % only for binary images
%                 
%                 Q = M*P;
%                 gaussian_noise = zeros(length(Q),1);
%                 noise = 0;
%                 
%                 for i = 1:length(Q)
%                     if Q(i)==0
%                         noise = noise + imnoise(0,'gaussian',0,vari);
%                     else
%                     for j = 1:Q(i)
%                         noise = noise + imnoise(0.5,'gaussian',0,vari);
%                     end
%                     end
%                     gaussian_noise(i) = 2*noise;
%                     noise = 0;
%                 end
%                 
%                 PQ = gaussian_noise;
%                 
%                 idx = num2str(img_index);
%                 sz = num2str(img_sz);
%                 var = num2str(vari);
%                 
%                 chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/Load/matrix/';
%                 varname = 'PQ';
%                 filename = strcat(chemin,varname,'-',type,'-img',idx,'-sz',sz,'-var',var,'.mat');
%                 save(filename,varname);
%             end
%         end
%     end
% end
% a ='finished'