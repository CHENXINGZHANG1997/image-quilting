function [ blocks, r, c ] = cut_blocks( im, block_size )
%CUT_BLOCKS Cuts an image into blocks of size block_size

[width, height, ~] = size(im);
blocks = {};
y = 1; c = 1;

while y <= width - block_size
  x = 1; r = 1;
  while x <= height - block_size
    blocks{r}{c} = im(y:(y+block_size), x:(x+block_size), :);
    x = x + block_size; r = r + 1;
  end
  y = y + block_size; c = c + 1;
end

imshow(blocks{3}{1});
size(blocks)
r = r - 1; c = c - 1;
end

