function s = error_bound4r_limitones(parameter, ordb, Ix, norm_OIbyQ, r)
%ERROR_BOUND4R_LIMITONES computes upper bound for the number of pixel 
%   differences between the rounded binary vector R and any binary solution
%   of the reconstruction problem considering the number of ones and zeros.
%   As in Theorem 5.
%
%   ORDB is the sorted vector of increments computed by round2binary.m 
%   PARAMETER computed as given by Theorem 5. 
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% r ordered by its values in b
ord_r = r(Ix); 
% Number of ones that differ between any binary image and r
L1_dif = round(norm_OIbyQ) - norm(r,1); 

if L1_dif > 0
    % find the first L1_dif elements = 0 in ord_r which will become 1's
    Ind = find(ord_r==0,L1_dif); % Ind is vector of indices of ord_r or ordb 
elseif L1_dif < 0
    % find the first L1_dif elements = 1 in ord_r which will become 0's
    Ind = find(ord_r,abs(L1_dif));
else
    s = roundkeepnorm(parameter, ord_r, ordb, Ix);
    return
end

t = length(Ind); % number of elements to change

for i = 1:t 
    parameter = parameter - ordb(Ind(i)); % add the contributions
    if parameter < 0
        s=i-1;
        return
    elseif parameter == 0
        s=i;
        return
    end
end

ordb(Ind) = [];
ord_r(Ind) = [];
Ix(Ind)=[];
s = roundkeepnorm(parameter, ord_r, ordb, Ix);
s=t+s; %\tilde(\ell)

function s = roundkeepnorm(parameter, ord_r, ordb, Ix)
s=0;
while parameter > 0
    parameter = parameter - ordb(1);
    r_i = abs(ord_r(1) - 1);
    Ind = find(ord_r == r_i, 1);
    if isempty(Ind)
        return
    end
    parameter = parameter - ordb(Ind);
    if parameter < 0
        return
    end
    s=s+2;
    
    Ind_aux = [1; Ind];
    ordb(Ind_aux) = [];
    ord_r(Ind_aux) = [];
    Ix(Ind_aux) = [];
end
% \tilde(\ell)+s is always even and the number of 0's is limited by n_0 and
% the same for 1's.