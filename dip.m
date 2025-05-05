[filename, pathname] = uigetfile('*.*','Select rice image');
filewithpath = strcat(pathname, filename);
f = imread(filewithpath);
[~, ~, r] = size(f);
if r == 3
    f = rgb2gray(f);
end
f = imresize(f, [nan, 256]);
fb = imbinarize(f, 'adaptive');  
fb = imfill(logical(fb), 'holes');
se = strel('disk', 2);
fe = imerode(fb, se);             
fecb = imclearborder(fe);        
blank = nnz(fecb);

if blank ~= 0
    [L1, n1] = bwlabel(fecb);
    stats1 = regionprops(L1, 'Area');     
    T1 = struct2table(stats1);
    area = table2array(T1);
    marea = mean(area);                   % Getting mean area
    ba = bwareaopen(L1, round(1.1 * marea));
    LL = logical(fecb - ba);              % Removing joint grains
    [L2, n2] = bwlabel(LL);
    stats2 = regionprops(L2, 'MajorAxisLength', 'MinorAxisLength');  % Getting grain's lengths
    T2 = struct2table(stats2);
    S = table2array(T2);
    
    if ~isempty(S)
        majoraxis = S(:,1);
        minoraxis = S(:,2);

        thr = 4;  % Defining Threshold
        mmr = majoraxis ./ minoraxis;  % Ratio of grain's length and width
        count = mmr > thr;
        outcome = (nnz(count) / numel(count)) * 100;

        if outcome >= 80
            msg = 'Rice is of good length';
        else
            msg = 'Rice sample is rejected';
        end
    else
        msg = 'No rice grains';
    end
else
    msg = 'No rice grains';
end

imgo = insertText(f, [10,10], msg, 'FontSize', 18, 'TextColor', 'white');  % Insert outcome text
imshow(imgo);
