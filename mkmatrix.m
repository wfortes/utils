 function W = mkmatrix(M,N,dir_a,dir_b)
 % W modifications
%  dir_a = ones(dir_cnt,1);
%  ang_sp = linspace(0,(dir_cnt-1)*pi/dir_cnt,dir_cnt);
%  dir_b = tan(ang_sp);
 %%%%%%%%%%%%%%%%%
 
 
% Directions are of the form (a,b). For example, if the directions are
% (1,0) and (1, -1), then dir_a = [1 1] and dir_b = [0 -1]
% dir_a = [1 0];
% dir_b = [0 1];
% [dir_a,dir_b]=mkdirvecs(sum_max);

% number of directions
% dir_cnt = 2;
dir_cnt = size(dir_a,2);

% number of columns in image
% N = 20;
% number of rows in image
% M = 20;

% current row in projection matrix (equation index)
current_row = 0;
% current nonzero element in projection matrix
current_index = 0;

% list of indexes of rows, for each nonzero element
row_list = zeros(1,M*N*dir_cnt);
% list of indexes of columns, for each nonzero element
col_list = zeros(1,M*N*dir_cnt);

% build the projection matrix
for dir = 1:dir_cnt;
    cur_a = dir_a(dir);
    cur_b = dir_b(dir);

    for ys = 1:M
        for xs=1:N
            if (ys - cur_b < 1) || (xs - cur_a < 1) || (ys - cur_b > M) || (xs - cur_a > N)
                current_row = current_row + 1;
                x = xs;
                y = ys;
                while (y >= 1) && (x >= 1) && (y <= M) && (x <= N)
                  current_index = current_index + 1;
                  row_list(current_index) = current_row;
                  col_list(current_index) = (y-1)*N + x;
                  x = x + cur_a;
                  y = y + cur_b;
                end
            end
        end
    end
end

row_list = row_list(1:current_index);
col_list = col_list(1:current_index);

% create sparse projection matrix
W = sparse(row_list, col_list, ones(1,current_index),current_row,M*N);

% cleanup
row_list = [];
col_list = [];

% optional: WD = full(W);  will create a dense projection matrix