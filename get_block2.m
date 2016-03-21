function [ block ] = get_block2( im, bsize, ovsize, row, col )
%GET_BLOCK2 Returns the subimage of im at (row, col), given block size

row_cut = max(1, (row-1)*(bsize) - ovsize + 1):(row*bsize - ovsize);
col_cut = max(1, (col-1)*(bsize) - ovsize + 1):(col*bsize - ovsize);

if length(col_cut) > bsize
  col_cut = col_cut(1:end-1);
end

if length(row_cut) > bsize
  row_cut = row_cut(1:end-1);
end

block = im(row_cut, col_cut, :);

end

