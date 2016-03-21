function [ match ] = random_match_2( comp_left, comp_above, im, bsize, ovsize, tolerance)
% check = [vert, hori] Indicated which edge to check

[height, width, ~] = size(im);
matches = [];

cols = floor(width / bsize);
rows = floor(height / bsize);
for c = 1 : cols
  for r = 1 : rows
    block = get_block(im, bsize, r, c);
    
    % Get the overlap region
    comp_ov_vert = comp_left(:, (bsize - ovsize + 1):bsize, :); % Left image's overlap
    block_ov_vert = block(:, 1:ovsize, :);                      % Right image's overlap
    
    comp_ov_hori = comp_above((bsize - ovsize + 1):bsize, :, :); % Top image's overlap
    block_ov_hori = block(1:ovsize, :, :);                       % Bottom image's overlap
    
    % Calculate the error with sum of square differences
%     ssd = sum((comp_ov_hori(:) - block_ov_hori(:)).^2);
%     ssd = ssd + sum((comp_ov_vert(:) - block_ov_vert(:)).^2);

    ssd_h = sum((comp_ov_hori(:) - block_ov_hori(:)).^2);
    ssd_v = sum((comp_ov_vert(:) - block_ov_vert(:)).^2);
    
    matches = [matches [r; c; ssd_h; ssd_v]]; % Append the match
  end
end

% Sort the possible matches by the errors
matches = sortrows(matches', 3)';

% Get the top matches with in the tolerance
k = -1; % Cut off index of usable matches

[~, w, ~] = size(matches);
best_error_h = matches(3, 1);
max_error_h = best_error_h  * tolerance + best_error_h ;

best_error_v = matches(4, 1);
max_error_v = best_error_v  * tolerance + best_error_v ;

for i = 1 : w
  if matches(3, i) > max_error_h || matches(4, i) > max_error_v
    k = i;
    break
  end
end

% Choose random match from the top k matches
match_index = matches(:, randi(k));
match = get_block(im, bsize, match_index(1), match_index(2));

end
