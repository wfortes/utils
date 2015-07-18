function s = Bmaxs(radius_dif,ordb,Ix,normPbyQ,r)
% 
ord_r = r(Ix); % r ordered by its values in b
L1_dif = round(normPbyQ)-norm(r,1); % # of ones that differ from xbin and r

if L1_dif > 0
    % find the first L1_dif elements = 0 in ord_r which will become 1's
    Ind = find(ord_r==0,L1_dif); % Ind is vector of indices of ord_r or ordb 
elseif L1_dif < 0
    % find the first L1_dif elements = 1 in ord_r which will become 0's
    Ind = find(ord_r,abs(L1_dif));
else
    s = roundkeepnorm(radius_dif,ord_r,ordb,Ix);
    return
end

t = length(Ind); % # of elements to change

for i = 1:t 
    radius_dif = radius_dif - ordb(Ind(i)); % add the contributions
    if radius_dif < 0
        s=i-1;
        return
    elseif radius_dif == 0
        s=i;
        return
    end
end

ordb(Ind) = [];
ord_r(Ind) = [];
Ix(Ind)=[];
s = roundkeepnorm(radius_dif,ord_r,ordb,Ix);
s=t+s; %\tilde(\ell)

function s = roundkeepnorm(radius_dif,ord_r,ordb,Ix)
s=0;
while radius_dif > 0
    radius_dif = radius_dif - ordb(1);
    r_i = abs(ord_r(1)-1);
    Ind = find(ord_r==r_i,1);
    if isempty(Ind)
        return
    end
    radius_dif = radius_dif - ordb(Ind);
    if radius_dif < 0
        return
    end
    s=s+2;
    
    Ind_aux = [1;Ind];
    ordb(Ind_aux) = [];
    ord_r(Ind_aux) = [];
    Ix(Ind_aux) = [];
end
% \tilde(\ell)+s is always even and the number of 0's is limited by n_0 and
% the same for 1's.