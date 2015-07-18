function [x, res, sol] = cgne(A, b, m_iter, eps)

r = b;
p = A'*r;
x = zeros(size(A,2),1);
sol(1:size(x,1),1) = x; %intro by Wagner in may 10th 2010
res(1) = norm(r);
it = 1;
gamma1 = dot(r,r);

while (res(it) > eps*res(1) & it < m_iter+1)
   alpha = gamma1/dot(p,p);

   x = x + alpha*p;
   r = r - alpha*A*p;
   
   gamma2 = dot(r,r);
   beta = gamma2/gamma1;
   gamma1 = gamma2;

   p = A'*r + beta*p;
   it = it +1;
   res(it) = norm(r); % z \in espaco sol, deviamos medir residuo, certo?
   sol(1:size(x,1),it) = x; %intro by Wagner in may 10th 2010
end