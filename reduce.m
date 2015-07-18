function [W_red p_red f_red] = reduce(W_old,p_old,f_old,f_grey,fix_columns)

    % Determine dimensions of the problem
    [M N] = size(W_old);
    
    % Create red matrix by deleting columns of W
    W_red = W_old;
    W_red(:,fix_columns) = [];
    
    % Create red right hand side
    p_red = p_old - W_old(:,fix_columns)*f_old(fix_columns);
    
    % Remove fixed variables
    % The free variables get their non-segmented values!
    f_red = f_grey;
    f_red(fix_columns) = [];

end