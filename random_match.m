function [ match ] = random_match( comp, im, bsize, ovsize, k )
%RANDOM_MATCH

[height, width, ~] = size(im);   
matches = [];

% 
x = 1;
while x <= width - bsize
  y = 1;
  
  x_cut = x:x+bsize;
  if length(x_cut) > bsize
    x_cut = x_cut(1:end-1);
  end
  
  while y <= height - bsize
    
    y_cut = y:y+bsize;
    if length(y_cut ) > bsize
      y_cut = y_cut(1:end-1);
    end
    
    b = im(y_cut, x_cut, :);
%     imshow(b);
    
    comp_ov = comp(:, (bsize - ovsize):bsize, :);
    b_ov = b(:, 1:ovsize+1, :);

    
    ssd = sum((comp_ov(:) - b_ov(:)).^2);
    matches = [matches [y; x; ssd]];
    y = y + bsize;
  end
  x = x + bsize;
end

matches = sortrows(matches', 3)';
matches = matches(:, 1:k);
match_indices = matches(:, length(matches));
y = match_indices(1, :);
x = match_indices(2, :);

x_cut = x:x+bsize;
if length(x_cut) > bsize
  x_cut = x_cut(1:end-1);
end

y_cut = y:y+bsize;
if length(y_cut) > bsize
  y_cut = y_cut(1:end-1);
end

match = im(y_cut, x_cut, :);

end

