function [ block ] = get_block( im, bsize, row, col )
%GET_BLOCK Returns the subimage of im at (row, col), given block size 
% if row == 1
%   hcut = 1:bsize;
% else
%   hcut = (row-1)*bsize:row*bsize;
% end
% 
% if col == 1
%   vcut = 1:bsize;
% else
%   vcut = (col-1)*bsize:col*bsize;
% end

row_cut = max(1, (row-1)*bsize):row*bsize;
col_cut = max(1, (col-1)*bsize):col*bsize;

% row_cut = row_cut(1:end-1);
% col_cut = col_cut(1:end-1);

if length(col_cut) > bsize 
  col_cut = col_cut(1:end-1); 
end


if length(row_cut) > bsize
  row_cut = row_cut(1:end-1);
end


% % size(im)
% row
% row_cut(end)
% col_cut(end)

block = im(row_cut, col_cut, :);

end

