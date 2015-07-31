function s = error_bound4r(ordb, parameter)
%ERROR_BOUND4R computes upper bound for the number of pixel differences
%   between the rounded binary vector R and any binary solution of the
%   reconstruction problem. As in Theorem 2.
%
%   Also computes upper bound for the number of pixel differences between
%   any two binary solutions of the reconstruction problem when PARAMETER
%   input is doubled by user. As in Theorem 3.
%
%   ORDB is the sorted vector of increments computed by round2binary.m 
%   PARAMETER computed as given by Theorem 2. If PARAMETER is zero, a 
%   warning message is displayed. Caused by linear system inconsitency or 
%   numerical errors.
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

s = 0;

if parameter >= 0
    summation = 0;
    for wpix = 1:length(ordb) % counter of wrong pixels
        summation = summation + ordb(wpix);
        if summation > parameter
            if wpix == 1
                warning('Upper bound forced to zero: possibly tiny numerical error!');
            end
            break
        end
        s = wpix;
    end
else % only if consistency is guaranteed
    warning('Upper bound forced to zero: parameter < 0 !');
end
