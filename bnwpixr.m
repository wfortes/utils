function s = bnwpixr(ordb,parameter,Ix,normPbyQ,r,lim)

% Upper bound for the number of different pixels between the rounded binary
% vector and any binary solution

s = 0;
if strcmp(lim,'notlimited')
    if parameter>0
        soma = 0;
        for wpix = 1:length(ordb) % wrong pixels is wpix
            soma = soma+ordb(wpix);
            if soma > parameter
                break
            end
            s = wpix;
        end
    else % only if consistency is guaranteed
        s=0;
    end
elseif strcmp(lim,'limited')
    s = Bmaxs(parameter,ordb,Ix,normPbyQ,r);
else
    error('wrong parameter')
end