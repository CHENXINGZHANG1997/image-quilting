function [ match ] = random_match_2( comp_left, comp_above, im, bsize, ovsize, tolerance)
% check = [vert, hori] Indicated which edge to check

[height, width, ~] = size(im);
matches = [];

cols = floor(width / bsize);
rows = floor(height / bsize);
for c = 1 : cols
  for r = 1 : rows
    block = get_block(im, bsize, r, c);
    
    [h, w, ~] = size(comp_left);
    
    % Get the overlap region
    comp_ov_vert = comp_left(1:(h-ovsize), (w - ovsize + 1):w, :); % Left image's overlap
    block_ov_vert = block(1:(h-ovsize), 1:ovsize, :);                      % Right image's overlap
    
    comp_ov_hori = comp_above((h - ovsize + 1):h, 1:(w-ovsize), :); % Top image's overlap
    block_ov_hori = block(1:ovsize, 1:(w-ovsize), :);                       % Bottom image's overlap
    
%     imshow(uint8(comp_left));
    
%     size(comp_ov_hori)
%     size(block_ov_hori)
    
    % Calculate the error with sum of square differences
    ssd = sum((comp_ov_hori(:) - block_ov_hori(:)).^2);
    ssd = ssd + sum((comp_ov_vert(:) - block_ov_vert(:)).^2);
    
%     s = ssd(comp_ov_vert, block_ov_vert);
%     s = s + ssd(comp_ov_hori, block_ov_hori);
    
    matches = [matches [r; c; ssd]];
  end
end

% Sort the possible matches by the errors
matches = sortrows(matches', 3)';

% Get the top matches with in the tolerance
k = -1; % Cut off index of usable matches

[~, w, ~] = size(matches);
best_error = matches(3, 1);
max_error = best_error  * tolerance + best_error ;

for i = 1 : w
  if matches(3, i) > max_error
    k = i;
    break
  end
end

% Choose random match from the top k matches
match_index = matches(:, 1); %matches(:, randi(k));
match = get_block(im, bsize, match_index(1), match_index(2));

end

