% open window with 1000x1000 pixels
[w, rect] = Screen('OpenWindow', 1);

nlines = 25;

% evenly spaced with a small border
xs = linspace(100,rect(3)-100,nlines);
ys = linspace(100,rect(4)-100,nlines);
centers = combvec(xs,ys)';

% length of line segments
linelen = diff(centers(1:2))*0.25;

% initialize the lines array 
xy = zeros(2,length(centers));

% counter for lines
l = 1;

% loop over center positions
for i = 1:length(centers)
    
    % debugging
    % fprintf('%.02f, %02f\n', xc, yc);

    % y position
    xc = centers(i,1);
    yc = centers(i,2);

    % generate a random orientation from 0-90, convert to radians
    theta = 360*rand(1,1) * pi/180;

    % project line through that point
    xy(1,l) = xc - linelen * cos(theta);
    xy(2,l) = yc - linelen * sin(theta);

    xy(1,l+1) = xc + linelen * cos(theta);
    xy(2,l+1) = yc + linelen * sin(theta);

    % increment
    l = l + 2;
    
end

Screen('FillRect', w, 128);
Screen('DrawLines', w, xy);
Screen('Flip', w);