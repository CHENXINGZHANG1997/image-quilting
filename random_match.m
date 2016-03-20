function [ match ] = random_match( comp, im, bsize, ovsize, k )
%RANDOM_MATCH

[height, width, ~] = size(im);   
matches = [];

cols = floor(width / bsize);
rows = floor(height / bsize);
for c = 1 : cols
  for r = 1 : rows
    block = get_block(im, bsize, r, c);
    
    % Get the overlap region
    comp_ov = comp(:, (bsize - ovsize + 1):bsize, :); % Left image's overlap
    block_ov = block(:, 1:ovsize, :);                 % Right image's overlap
    
    ssd = sum((comp_ov(:) - block_ov(:)).^2)
    matches = [matches [r; c; ssd]]; % appending the match
  end
end

% Sort the possible matches by the errors
matches = sortrows(matches', 3)';

% Choose random match from the top k matches
match_index = matches(:, randi(k));
match = get_block(im, bsize, match_index(1), match_index(2));

end

