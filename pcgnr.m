function [x, res, rez, sol] = pcgnr(A,b,m_iter,aps,P)
% CGNR 
% non-optimized to measure the residual
[m,n]=size(A);
r= b;
res(1) = norm(r); % to measure the residual

r1= A'*r;
z=r1; % z=R'\r1; z=R\z;
p=z;

x = zeros(n,1);
rez(1) = norm(z);
sol(1:size(x,1),1) = x; %intro by Wagner in may 10th 2010
it = 1;
gamma = dot(z,r1);

while (rez(it) > eps*rez(1) & it < m_iter+1)
    w = A*p;
    alpha = gamma/dot(w,w);
    
    x = x+alpha*p;
    r = r-alpha*w;
    
    r1=A'*r; 
    z=r1; % z1=R'\r11; z1=R\z1;
    
    beta=1/gamma;
    gamma = dot(z,r1);
    beta = gamma*beta;
    
    p = z+beta*p;
    it = it +1;
    rez(it) = norm(z); % z \in espaco sol, deviamos medir residuo, certo?
    res(it) = norm(b-A*x); % to measure the residual
    sol(1:size(x,1),it) = x; %intro by Wagner in may 10th 2010
end


% [m,n]=size(A);
% if(isempty(R))
%     R=eye(n);
% end
% if(isempty(x))
%     x=spalloc(n,1,0);
% end
% if(isempty(tol))
%     tol = 1e-6;
% end
% if(isempty(maxit))
%     if(m>n)
%         n=m;
%     end
%     maxit = min(n,20);
% end