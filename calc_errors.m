function [ errors ] = calc_errors( im, out_slice, casee, bsize, ovsize)
%CALC_ERRORS - version used for texture transfer

[im_h, im_w, ~] = size(im);

errors = zeros(im_h - bsize, im_w - bsize);

for i = 1:im_h - bsize     % loops over rows
  for j = 1:im_w - bsize   % loops over cols
    % We need to find a block whose above (or left) slice
    % is similar to the stuff that was already at the block we're
    % considering, from quilting.m's main loop
    si = i; sj = j;
    if strcmp(casee, 'above')
      ei = si + ovsize - 1;
      ej = sj + bsize - 1;
      
    elseif strcmp(casee, 'left')
      ei = si + bsize - 1;
      ej = sj + ovsize - 1;
      
    elseif strcmp(casee, 'corner')
      % Used to remove the tiny overlapping region
      ei = si + ovsize - 1;
      ej = sj + ovsize - 1;
    end
    
    % Retrieve the block
    block = im(si:ei, sj:ej, :);
    
    % Calculate the error for the block
    errors(i, j) = sum((out_slice(:) - block(:)).^2);
  end
end

end

