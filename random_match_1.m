function [ match ] = random_match_1( comp, im, bsize, ovsize, tolerance, check)
% check = [vert, hori] Indicated which edge to check

[height, width, ~] = size(im);
matches = [];

cols = floor(width / bsize);
rows = floor(height / bsize);
for c = 1 : cols
  for r = 1 : rows
    block = get_block(im, bsize, r, c);
    
    comp_ov = 0;
    block_ov = 0;
    
    % Get the overlap region
    if strcmp(check, 'vert')
      comp_ov = comp(:, (bsize - ovsize + 1):bsize, :); % Left image's overlap
      block_ov = block(:, 1:ovsize, :);                 % Right image's overlap
    elseif strcmp(check, 'hori')
      comp_ov = comp((bsize - ovsize + 1):bsize, :, :); % Top image's overlap
      block_ov = block(1:ovsize, :, :);                 % Bottom image's overlap
    end
    
    error = sum((comp_ov(:) - block_ov(:)).^2);
    matches = [matches [r; c; error]]; % Append the match
  end
end

% Sort the possible matches by the errors
matches = sortrows(matches', 3)';

% Get the top matches with in the tolerance
k = -1; % Cut off index of usable matches

[~, w, ~] = size(matches);
best_error = matches(3, 1);
max_error = best_error * tolerance + best_error;

for i = 1 : w
  if matches(3, i) > max_error
    k = i;
    break
  end
end

% Choose random match from the top k matches
match_index = matches(:, randi(k));
match = get_block(im, bsize, match_index(1), match_index(2));

end