function [x, res, rez, sol] = pcgne(A, b, m_iter, eps, P)
% CGNE
% non-optimsed to measure the residual
[m,n] = size(A);
r = b;
% 
res(1) = norm(r); % to measure the residual

z=r;% z=P\r;

p = A'*z;
x = zeros(n,1);
rez(1) = norm(z);
sol(1:size(x,1),1) = x; %intro by Wagner in may 10th 2010
it = 1;
gamma = dot(z,r);

while (rez(it) > eps*rez(1) & it < m_iter+1)
%    w = A*p; % this is strange
   alpha = gamma/dot(p,p);

   x = x + alpha*p;
   r = r - alpha*A*p; %  r = r - alpha*w;
   
   z=r;%    z=P\r;
   
   beta = 1/gamma;
   gamma = dot(z,r);
   beta = gamma*beta;

   p = A'*z + beta*p;
   it = it +1;
   rez(it) = norm(z);
%    res=rez; % IN CGNE THEY ARE EQUAL %
   res(it) = norm(b-A*x); % to measure the residual
   sol(1:size(x,1),it) = x; %intro by Wagner in may 10th 2010
end
