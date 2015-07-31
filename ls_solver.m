function xls = ls_solver(A, b, solver, maxit, tol)
%LS_METHOD finds the least squares solution for AX = B
%   XLS = LS_SOLVER(A, B, SOLVER) tries to solve the system A*X = B for the
%   unkowns X. The chosen solver as passed in the string SOLVER is used. 
%   If SOLVER is empty then the default is used, 'cgls_W'.
%   Other possibilities for SOLVER are: 'cgls', 'cgne', 'lsqr', 'lsqr_W', 
%   'lsmr'.
%
%   XLS = LS_SOLVER(A, B, SOLVER, MAXIT) also pass the number of iterations
%   MAXIT after which the algorithm will be stopped. If MAXIT is empty then
%   LS_METHOD uses the default, 100.
%
%   XLS = LS_SOLVER(A, B, SOLVER, NITER, TOL) specifies the tolerance of 
%   the method. If TOL is empty then LS_SOLVER uses the default, 1e-6.
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

if nargin < 2, error('Not enough input arguments!'); end
if nargin < 3 || isempty(solver), solver = 'cgls_W'; end
if nargin < 4 || isempty(maxit),  maxit = 100;       end
if nargin < 5 || isempty(tol),    tol = 1e-6;        end


switch solver
    case 'cgls_W'
        xls = cgls_W(A, b, maxit, tol);
    case 'cgls'
        xls = cgls(A, b, [], tol, maxit, [], []);
    case 'cgne'
        xls = cgne(A, b, maxit, tol);
    case 'lsqr'
        xls = lsqr(A, b, tol, maxit);
    case 'lsmr'
        xls = lsmr(A, b, [], tol, tol, [], maxit);
    otherwise
        error('Please pass a valid arm name!');
end

end

