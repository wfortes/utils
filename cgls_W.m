function [x, res, sol] = cgls_W(A, b, m_iter, eps)
[m,n] = size(A);
r = b;
z = A'*b;
p = z;
x = zeros(n,1);
sol(1:size(x,1),1) = x; %intro by Wagner in may 10th 2010
res(1) = norm(z);
it = 1;
gamma = dot(z,z);

while (res(it) > eps*res(1) & it < m_iter+1)
   w = A*p;
   alpha = gamma/dot(w,w);

   x = x + alpha*p;
   r = r - alpha*w;
   
   z = A'*r;
   beta = 1/gamma;
   gamma = dot(z,z);
   beta = gamma*beta;

   p = z + beta*p;
   it = it +1;
   res(it) = norm(z); % z \in espaco sol, deviamos medir residuo, certo?
   sol(1:size(x,1),it) = x; %intro by Wagner in may 10th 2010
end
