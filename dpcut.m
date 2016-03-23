function [ cut ] = dpcut( a, b, casee )
%DPCUT
% a and b are overlapping images to be cut

% Find the errors, to use as a cost as each pixel
errors = sum((a - b).^2, 3);
if strcmp(casee, 'hori')
  errors = errors';
end
[err_h, err_w, ~] = size(errors);

% Initialize the dynamic programming table with zeros
dp = zeros(err_h, err_w);

% Fill in the first row of dp with the error at that starting point
dp(1:err_w, :) = errors(1:err_w, :);

% Compute the dp table entries
for i = 2:err_h
  for j = 1:err_w
    % Consider the pixels we may have come from
    paths = [dp(i-1, j)];
    
    if j ~= 1
      % Don't consider this case if j is 1
      paths = [paths dp(i-1, j-1)];
    end
    
    if j ~= err_w
      % Similarly if j is err_w
      paths = [paths dp(i-1, j+1)];
    end
    
    % Find the min up to this point using dp
    dp(i, j) = errors(i, j) + min(paths);
  end
end

% Find the answer using backtracking
cut = ones(err_h, err_w);
[~, start] = min(errors(err_h, 1:err_w));
cut(i, start) = 0;
cut(i, start+1:err_w) = 1;
cut(i, 1:start-1) = -1;

for i = err_h-1:-1:1
  for j = 1:err_w
    if start < err_w
      if errors(i, start+1) == min(errors(i, max(start-1, 1):start+1))
        start = start + 1;
      end
    end
    
    if start > 1
      if errors(i, start-1) == min(errors(i, start-1:min(start+1, err_w)))
        start = start - 1;
      end
    end
    
    cut(i, start) = 0;
    cut(i, start+1:err_w) = 1;
    cut(i, 1:start-1) = -1;
  end
end

if strcmp(casee, 'hori')
  cut = cut';
end

end

