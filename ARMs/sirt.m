function f_new = sirt(W,f_in,p,no_it)
%--------------------------------------------------------------------------
% f_new = sirt(W,f_in,p,no_it)
%               
% Performs no_it SIRT iterations on the system Wf=p with initial guess f_in
%
% Input:
% W         The projection matrix;
% f_in      The initial guess;
% p         The right-hand-side;
% no_it     Number of iterations to be performed.
%
% Output:
% f_new     The approximate solution for Wf=p after no_it iterations.
%--------------------------------------------------------------------------

% Determine scaling matrices
C = diag(sparse(1./sum(W)));
R = diag(sparse(1./sum(W,2)));

% Remove appearances of inf
C(isinf(C)) = 0;
R(isinf(R)) = 0;

% Start SIRT
f_new = f_in;

for i = 1:no_it
    
    f_old = f_new;
    r = p - W*f_old;
    
    f_new = f_old + (C*(W'*(R*r)));
    
end

end
