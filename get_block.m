function [ block ] = get_block( im, bsize, row, col )
%GET_BLOCK Returns the subimage of im at (row, col), given block size 
if row == 1
  hcut = 1:bsize;
else
  hcut = row*bsize:(row+1)*bsize;
end

if col == 1
  vcut = 1:bsize;
else
  vcut = col*bsize:(col+1)*bsize;
end

if length(vcut) > bsize
  vcut = vcut(1:end-1);
end

if length(hcut) > bsize
  hcut = hcut(1:end-1);
end

block = im(vcut, hcut, :);

end

