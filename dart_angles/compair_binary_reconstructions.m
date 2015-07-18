clear all
img_sz_set = 512;
img_index_set = [1,2,3];%,5];
type_set = 1;
for img_sz = img_sz_set
    for typecod = type_set
        if typecod==0
            type = 'grid';
        else
            type = 'strip';
        end
        for img_index = img_index_set;
            if img_index==1
                N_proj_set = [1:8];
            elseif img_index==2
                N_proj_set = [1:10];
            elseif img_index==3
                N_proj_set = [1:25];
            elseif img_index==5
                N_proj_set = [1:40];
            end
            P = img_read(img_index,img_sz);
            P = reshape(P,img_sz^2,1);
            P = double(P);
            
            P = P/norm(P,inf); % only for binary images
            
            aux = 1;
            for N_proj = N_proj_set
                address = '/export/scratch1/PhD_files/Load/angles_eq_distr/';
                M = loadmatrix(address,img_sz,N_proj,type,'matrix');
                
                v = dart_img_read(img_index,N_proj);
                v = reshape(v,img_sz^2,1);
                v = double(v);
                v = v/norm(v,inf);
                
                Q = M*P;
                [R, res, sol] = cgls_W(M, Q, 100, 1e-10);
                npix = length(P);
                
                % computing norm(x) from its projection
                normPbyQ = norm(Q,1)/N_proj;
                
                % square of radius
                sqradius = normPbyQ-dot(R,R);
                
                [r, b, ordb, Ix, alpha] = round2binary(R);
                
                Rr(aux,1) = norm(P-r,1)/npix;
                parameter = sqradius - dot(alpha,alpha);
                
                [s_aux ixs] = bnwpixr(ordb,parameter,Ix,normPbyQ,r,'notlimited');
                s(aux,1) = s_aux/npix;
                
                %                 [d1 d2 V d3 d4] = variability(npix,sqradius,s_aux,ordb,parameter,Ix,normPbyQ,r,'notlimited');
                
                s_aux2 = norm(v-r,1)/npix;
                Dist1(aux,1) = s_aux/npix + s_aux2;
                
                
                dif = r-v;
                indxrv = find(dif==0);
                b = b(indxrv);
                [ordb1,Ix] = sort(b);
                
                lim = 'notlimited'; % limited or notlimited
                [s_aux ixs] = bnwpixr(ordb1,parameter,Ix,normPbyQ,r(indxrv),lim);
                
                Dist2(aux,1) = (s_aux+dot(r-v,r-v))/npix;
                %                 rs = r;
                %                 rs(ixs) = imcomplement(rs(ixs)); % pixels differ r and rs
                %                 v_rs = norm(v(ixs)-rs(ixs),1); % # pixels differ v and rs which differ r
                %                 Dist2(aux,1) = Dist1(aux,1) - (length(ixs) - v_rs)/npix;
                %                 if sqradius-dot(R-r,R-r) > 0
                %                     Dist_aux = v_rs/npix + V;
                %                     Dist2(aux,1) = min(Dist2(aux,1),Dist_aux);
                %                 elseif str.sqradius-dot(R-r,R-r) == 0
                %                     Dist_aux = V;
                %                     Dist2(aux,1) = min(Dist2(aux,1),Distaux);
                %                 end
                
                Dist3(aux,1) = (sqrt(sqradius)+norm(v-R))^2/npix;
                
                Dist4(aux,1) = norm(v-P,1)/npix;
                
                %                 lb = zeros(length(P),1);
                %                 ub = ones(length(P),1);
                %                 H = 2*eye(length(P),length(P));
                %                 f = -2*(~v); % complement
                %                 % f = -2*v;
                %                 X0 = R;
                %                 %                     options = optimset('MaxIter',2*(length(R)-length(Q)));
                %                 options = optimset('MaxIter',(length(R)-length(Q)));
                %                 x = quadprog(H,f,[M;-M],[Q+1e-5;1e-5-Q],[],[],lb,ub,X0,options);
                %                 Dist3(aux,1) = norm(x-v,1)/npix;
                %---------------------
                [s6_aux ixs] = bnwpixr(ordb1,parameter,Ix,normPbyQ,r(indxrv),'limited');
                s6(aux,1) = s6_aux/npix;
                
                Dist5(aux,1) = s6_aux/npix + s_aux2;
                
                %                 [d1 d2 V d3 d4] = variability(npix,sqradius,s6_aux,ordb,parameter,Ix,normPbyQ,r,'limited');
                %                 rs = r;
                %                 rs(ixs) = imcomplement(rs(ixs)); % pixels differ r and rs
                %                 v_rs = norm(v(ixs)-rs(ixs),1); % # pixels differ v and rs which differ r
                %
                %                 Dist6(aux,1) = s6_aux/npix + norm(v-r,1)/npix - (length(ixs) - v_rs)/npix;
                aux = aux+1;
            end
            it = N_proj_set;
            %             figura = semilogy(it,s,'k-x','LineWidth',2,'MarkerSize',8);
            figura = semilogy(it,Dist3,'g-s','LineWidth',2,'MarkerSize',8);
            hold on
            %             semilogy(it,Dist3,'g-s','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist1,'m-+','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist2,'b-o','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist5,'c-d','LineWidth',2,'MarkerSize',8);
            %             semilogy(it,Dist6,'k-x','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist4,'r-','LineWidth',2,'MarkerSize',8);
            
            legend('U_a(1)','U_a(2)','U_a(3)','U_a(4)','E_a')
            hold off;
            set(gca,'fontsize',15)
            xlabel('Number of projections','fontsize',20)
            ylabel('Fraction of pixels','fontsize',20)
            %
            img = num2str(img_index);
            sz = num2str(img_sz);
            proj = num2str(N_proj);
            
            chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/dart_angles/graphs/';
            filename = strcat(chemin,'UE-DART-',type,'-Im',img,'-sz',sz,'p',proj,'.fig');
            saveas(figura,filename);
            clear figura
            %
        end
    end
end

