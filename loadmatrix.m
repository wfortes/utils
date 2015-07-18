function M = loadmatrix(address,sz,proj,model,kind,varargin)

% The matrices must be in folders named with their model and the address
% must indicate the parent folder

sz = num2str(sz);
proj = num2str(proj);
optargin = size(varargin,2);
if optargin >= 1 && (strcmp(kind,'PQ')||strcmp(kind,'w_PQ'))
img_index = num2str(varargin{1});
vari = num2str(varargin{2});
elseif optargin >= 1 && strcmp(kind,'r')
img_index = num2str(varargin{1});
iter = num2str(varargin{2});
end

if strcmp(kind,'matrix')
    filename = strcat(address,model,'/M-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = M;
elseif strcmp(kind,'pinvM')
    filename = strcat(address,kind,'/',model,'/pinvM-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = pinvM;
elseif strcmp(kind,'sv')
    filename = strcat(address,kind,'/',model,'/sv-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = sv;
elseif strcmp(kind,'sv_svd_full_W')
    filename = strcat(address,kind,'/',model,'/sv_svd_full_W-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = sv;
elseif strcmp(kind,'sv_pinv')
    filename = strcat(address,kind,'/',model,'/sv_pinv-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = sv_pinv;
elseif strcmp(kind,'randfactor')
    if strcmp(model,'grid')
    filename = strcat(address,kind,'/randfactor-',model,'-sz',sz,'-proj',proj,'.mat');
    else
        filename = strcat(address,kind,'/randfactor','-sz',sz,'-proj',proj,'.mat');
    end
    load(filename);
    M = randfactor;
elseif strcmp(kind,'PQ')||strcmp(kind,'w_PQ')
    filename = strcat(address,'/gaussian_noise/',kind,'-',model,'-img',img_index,'-sz',sz,'-var',vari,'.mat');
    load(filename);
    M = PQ;
elseif strcmp(kind,'r')% a binary reconstruction by a dart-lie algorithm
    filename = strcat(address,'r/',kind,'-',model,'-img',img_index,'-sz',sz,'-proj',proj,'it',iter,'.mat');
    load(filename);
    M = r;
elseif strcmp(kind,'S')
    filename = strcat(address,'/USV/',kind,'-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = S;
elseif strcmp(kind,'U')
    filename = strcat(address,'/USV/',kind,'-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = U;
elseif strcmp(kind,'V')
    filename = strcat(address,'/USV/',kind,'-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = V;
elseif strcmp(kind,'pinvS')
    filename = strcat(address,'/USV/',kind,'-',model,'-sz',sz,'-proj',proj,'.mat');
    load(filename);
    M = pinvS;
else
    error('Fool user error')
end