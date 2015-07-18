function s = dif2binsols_limitones(radius_dif,ordb,Ix,r)
% 
radius_dif = 2*radius_dif;
ord_r = r(Ix); % r ordered by its values in b
s=0;

while radius_dif > 0
    r_i = abs(ord_r(1)-1);
    Ind = find(ord_r==r_i,1);
    if isempty(Ind)
        return
    end
    radius_dif = radius_dif - ordb(1) - ordb(Ind);
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