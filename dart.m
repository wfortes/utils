function [images,f_grey,f_seg,res,pixelError] = dart(projections,volSize,nAngles,greyValues,method,initial_arm_it,arm_it,dart_it,fix_prob,f_true,W)
%DART Discrete Algebraic Reconstruction Technique for Tomography
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES) computes the DART
%   reconstruction from the PROJECTIONS at an image size of VOLSIZE. The
%   PROJECTIONS are acquired from NANGLES and the reconstructed image
%   consists of grey values GREYVALUES. Reconstructions of each iteration
%   are stored in the cell array IMAGES.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD) also pass
%   the algebraic reconstruction method (ARM) as a string, if METHOD is
%   empty the default is used, 'sirt'. Other possibilities for METHOD are:
%   'cgls', 'cgne', 'lsqr', 'lsmr', 'scaled_cgls', 'scaled_cgne',
%   'scaled_lsqr', 'scaled_lsmr'.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD, 
%   INITIAL_ARM_IT) also defines the number of iterations used for the 
%   initial ARM reconstruction, if INITIAL_ARM_IT is empty the default is
%   used, 50.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD,
%   INITIAL_ARM_IT,ARM_IT) also pass the number of intermediate ARM 
%   iterations. If ARM_IT is empty, the default will be used, 20.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD,
%   INITIAL_ARM_IT,ARM_IT,DART_IT) also pass the number of DART iterations.
%   If DART_IT is empty, the default will be used, 20.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD,
%   INITIAL_ARM_IT,ARM_IT,DART_IT,FIX_PROB) also give the fix probability. 
%   Each pixel in the image is classified as free with a probability of 
%   1-FIX_PROB. If FIX_PROB is empty, the default will be used, 1.
%
%   IMAGES = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,METHOD,
%   INITIAL_ARM_IT,ARM_IT,DART_IT,FIX_PROB,F_TRUE) als pass the ground 
%   truth image. This is used to compute the pixel error which can be 
%   useful in a phantom study.
%
%   [IMAGES,F_GREY] = DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,...) also
%   returns the final continuous grey value reconstruction F_GREY.
%
%   [IMAGES,F_GREY,F_SEG] = 
%   DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,...) also returns the final
%   segemented reconstruction F_SEG.
%
%   [IMAGES,F_GREY,F_SEG,RES] =
%   DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,...) also returns the 
%   residual RES of the continuous grey value reconstruction F_GREY.
%
%   [IMAGES,F_GREY,F_SEG,RES,PIXELERROR] =
%   DART(PROJECTIONS,VOLSIZE,NANGLES,GREYVALUES,...) also returns the 
%   the PIXELERROR if a ground truth image has been passed.
%
%   See also RDART, ADART.

%   Copyright 2012, 2013 Frank Tabak, and Folkert Bleichrodt

% input parsing
if nargin < 4 ,   error('Not enough input arguments!');        end
if nargin < 5 || isempty(method)         , method = 'sirt';    end
if nargin < 6 || isempty(initial_arm_it) , initial_arm_it = 50;end
if nargin < 7 || isempty(arm_it)         , arm_it   = 20;      end
if nargin < 8 || isempty(dart_it)        , dart_it  = 20;      end
if nargin < 9 || isempty(fix_prob)       , fix_prob = 1;       end
if nargin < 10 || isempty(f_true)        , f_true   = [];      end

if numel(volSize) == 1;
    volSize = [volSize, volSize];
end

N = prod(volSize);

p = projections(:);
det_width = numel(p)/nAngles;

% Create projection operator
% proj_geom = astra_create_proj_geom('parallel', 1.0, det_width, linspace2(0,pi,nAngles));
% vol_geom  = astra_create_vol_geom(volSize);
% 
% proj_id = astra_create_projector('strip', proj_geom, vol_geom);

%W = opTomo('cuda', proj_geom, vol_geom);
% matrix_id = astra_mex_projector('matrix', proj_id);
% W = astra_mex_matrix('get', matrix_id);

% %% Create System
% f_org = Im(:);
% p = W*f_org;

% % Add noise to sinogram
% if noise ~= 0
%     p = astra_add_noise_to_sino(p,noise);
% %     sinogram = astra_add_noise_to_sino(sinogram,noise);
% %     astra_mex_data2d('store', sinogram_id, sinogram);
% end

f_grey = zeros(N,dart_it);
f_seg  = zeros(N,dart_it);
res    = zeros(dart_it,1);


% --------------------------DART------------------------------------------

% Initial ARM Reconstructions
display('Initial Reconstruction');

f_grey(:,1) = applyArm(method, W, p, initial_arm_it);

res(1)    = norm(W*f_grey(:,1) - p);
images{1} = reshape(f_grey(:,1), volSize);

if ~isempty(f_true)
    pixelError = zeros(dart_it,1);
end

% Start DART iterations
for i = 1:dart_it-1

    display(['DART iteration: ' num2str(i)])
    
    % Segment continuous image
    f_seg(:,i) = segment(f_grey(:,i), greyValues);
    images{i}  = reshape(f_seg(:,i), volSize);

    if ~isempty(f_true)
        pixelError(i) = sum(sum(images{i} ~= f_true));
    end

    imshow(images{i}, []);
    drawnow;
%     subplot(2,2,1);
%    show(images{i});

    % Identify boundary and free pixels
    edges     = boundary(images{i});
    rand_free = rand(volSize) < (1-fix_prob);
%     free  = edges;
    free = or(edges, rand_free);
    
%     subplot(2,2,2);
%     show(free);
% 
%     
%     subplot(2,2,3);
%     show(edges);
    
    % Determine and solve the reduced system
    free_columns  = free(:)  > 0;min((i-1),8);
    fixed_columns = ~free_columns;
    
    if sum(free_columns) == 0
        disp('Converged');
        break;
    end
    
    [W_red, p_red, f_red] = reduce(W, p, f_seg(:,i), f_grey(:,i), fixed_columns);
    
%     fprintf('%d pixels are fixed\n', sum(fixed_columns));
%     fprintf('%d pixels are free\n', sum(free_columns));
    
    updatedPixels = applyArm(method, W_red, p_red, arm_it, f_red);%zeros(size(f_red)));
    
    updateRecon = f_seg(:,i);
    updateRecon(free_columns) = updatedPixels;
    f_grey(:,i+1) = updateRecon;
    
    % Smooth reconstruction
    im_pre_smooth = reshape(f_grey(:,i+1), volSize);
    im_smooth     = smooth(im_pre_smooth);
%     f_grey(:,i+1) = im_smooth(:);
    % smooth only boundary
    f_grey(free_columns,i+1) = im_smooth(free_columns);
    
    % Finish iteration
    res(i+1) = norm(W*f_grey(:,i+1) - p);
    
end

% Final reconstruction
display('Final Reconstruction');

f_seg(:,dart_it) = segment(f_grey(:,dart_it), greyValues);
images{dart_it}  = reshape(f_seg(:,dart_it), volSize);

if ~isempty(f_true)
    pixelError(dart_it) = sum(sum(images{dart_it} ~= f_true));
end

% plot(pixelError);
