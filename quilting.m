% Parameters
bsize = 36;             % Set by user
ovsize = bsize/6;       % Efros and Freeman
k = 7;                  % Tolerance

% Open image
im = double(imread('images/FarmAerial.jpg'));
[im_h, im_w, ~] = size(im);

mri = floor(im_h/bsize); % maximum row index
mci = floor(im_w/bsize); % maximum col index

out = uint8(zeros(im_w*2, im_h*2, 3));
[out_h, out_w, ~] = size(out);

% Set the first block at random for the block comparison
prev_block = get_block(im, bsize, randi(mri), randi(mci));
out(1:bsize, 1:bsize, :) = prev_block;

% Fill in first row
for col = 2:floor((out_w/bsize)) + 1    % +1 fills in gaps at end
  col_cut = max(1, (col-1)*bsize):col*bsize;
  
  if length(col_cut) > bsize
    col_cut = col_cut(1:end-1);
  end 
 
     %   Totally random selection
%   out(1:bsize, col_cut, :) = get_block(im, bsize, randi(mri), randi(mci));
  
  
  %   Random selection from k best matches
%   comp_col_cut = col_cut - bsize;
%   if col == 1
%     comp_col_cut = col_cut - bsize+1;
%   end
  
%   comp = out(1:bsize, comp_col_cut, :);
  
  prev_block = random_match(prev_block, im, bsize, ovsize, k);
  out(1:bsize, col_cut, :) = prev_block;
end

%
% % Fill in first column
% for row = 1:(out_h/bsize)+2            % TODO: always +2 ? edge case?
%   row_cut = row*bsize:(row+1)*bsize;
%
%   if length(row_cut) > bsize
%     row_cut = row_cut(1:end-1);
%   end
%
%   out(row_cut, 1:bsize, :) = get_block(im, bsize, randi(mci), randi(mri));
% end
%
% % Fill in the rest
% for row = 1:(out_h/bsize)+2
%   row_cut = row*bsize:(row+1)*bsize;
%
%   if length(row_cut) > bsize
%     row_cut = row_cut(1:end-1);
%   end
%
%   for col = 1:(out_w/bsize)+2
%     col_cut = col*bsize:(col+1)*bsize;
%
%     if length(col_cut) > bsize
%       col_cut = col_cut(1:end-1);
%     end
%
%     % Randomly pick blocks
%     out(row_cut, col_cut, :) = get_block(im, bsize, randi(mci), randi(mri));
%   end
% end

imshow(out);