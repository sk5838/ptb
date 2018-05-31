% open window with 1000x1000 pixels
[w, rect] = Screen('OpenWindow', 1, [], [0 0 1000 1000]);

nlines = 25;

% evenly spaced with a small border
xs = linspace(100,rect(3)-100,nlines);
ys = linspace(100,rect(4)-100,nlines);
centers = combvec(xs,ys)';

% size of 1 side of texture box
side = ceil(max(diff(centers(1:2,1))));

% initialze base array for texture element, and make it gray (128)
arr = ones(side,side)*128;

% draw a line through it
arr(ceil(side/2),:) = 255;

% make it a texture
tex = Screen('MakeTexture', w, arr);

% this is the source rect
src_rect = [0 0 side side];

% these are the destination rects for all the lines
dst_rects = zeros(length(centers), 4);

% counter for lines
l = 1;

% make rects for positions
for i = 1:length(centers)
    
    % debugging
    % fprintf('%.02f, %02f\n', xc, yc);

    % y position
    xc = centers(i,1);
    yc = centers(i,2);
    
    % move source rect to this new location
    new_rect = CenterRectOnPointd(src_rect, xc, yc);
    
    % store that location
    dst_rects(l,:) = new_rect;
    
    % increment
    l = l + 1;
    
end

Screen('FillRect', w, 128);
rotations = 360*rand(length(centers),1);
Screen('DrawTextures', w, line_tex, src_rect, dst_rects', rotations);
Screen('Flip', w);

Screen('DrawTextures', w, mask_tex, src_rect, dst_rects', rotations);

