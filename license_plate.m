function license_plate()
    close all;
    clear all;

    %%Image preprocessing
    img = imread('D:\github_ws\test thesis\33.jpg');
    imgray = rgb2gray(img);
    imgray=imresize(imgray, [480 640]);
    figure, imshow(imgray);
    %hold on;

    nonoise_img = medfilt2(imgray, [3 3]);
    figure, imshow(nonoise_img);
    filtered = edge(nonoise_img,'canny');
    figure, imshow(filtered);

    L = bwlabeln(filtered, 8);
    S = regionprops(L, 'Area');
    BW = ismember(L,find([S.Area]>=8));
    figure, imshow(BW);

    H3 = imfill(BW,'holes');
    figure, imshow(H3);

    im = bwareaopen(H3, 1200);
    figure, imshow(im);

    %%Below steps are to find location of number plate
    Iprops=regionprops(im,'BoundingBox','Area', 'Image');
    area = Iprops.Area;
    count = numel(Iprops);
    maxa= area;
    boundingBox = Iprops.BoundingBox;
    for i=1:count
       if maxa<Iprops(i).Area
           maxa=Iprops(i).Area;
           boundingBox=Iprops(i).BoundingBox;
       end
       %rectangle('position',Iprops(i).BoundingBox,'Edgecolor','r');
       %figure, imshow(Iprops(i).Image);
    end    

    %%crop the number plate area
    im = imcrop(imgray, boundingBox);
    figure, imshow(im);

    im = imresize(im, [150 350]);
    [counts,x] = imhist(im,16);
    T = otsuthresh(counts);
    im = imbinarize(im, T);
    im = ~im;

    %%Finding the rectangle exactly outside of text
    mn=10000000; idx=1; idy=1;
    H = 110; W = 320;
    for i=1:150-H
        for j = 1:350-W
            temp = sum(im(i:i+H, j))+sum(im(i, j:j+W))+sum(im(i+H, j:j+W))+sum(im(i:i+H, j+W));
            if(temp<=mn)
                mn = temp;
                idx = i; idy = j;
            end
        end
    end

    figure, imshow(im);
    hold on;

    %plot(310, 1:150, 'r.');
    plot(idy, idx:idx+H, 'r.');
    plot(idy:idy+W, idx, 'r.');
    plot(idy+W, idx:idx+H, 'r.');
    plot(idy:idy+W, idx+H, 'r.');

    %%Removing small object
    text = imcrop(im, [idy idx W H]);
    text = bwareafilt(text, 9);
    figure, imshow(text);
    hold on;

    %%Finding separation Line
    mn=10000000; dis=10000000; idx1=1;
    rowsum = sum(text, 2);
    for i=1:length(rowsum)
        if rowsum(i)<=mn && abs(75-i)<=dis
            mn = rowsum(i); dis = abs(75-i);
            idx1 = i;
        end
    end

    plot(1:350, idx1, 'r.');

    %Cropping First Line and second Line
    firstLine = text(1:idx1, :);
    secondLine = text(idx1+1:end, :);
    
    firstLine = cut_border(firstLine);
    secondLine = cut_border(secondLine);
    
    firstLine = [false(size(firstLine, 1), 1) firstLine false(size(firstLine, 1), 1)];
    secondLine = [false(size(secondLine, 1), 1) secondLine false(size(secondLine, 1), 1)];

    %firstLine = bwareafilt(firstLine, 3);
    %secondLine = bwareafilt(secondLine, 6);
    figure, imshow(firstLine);
    figure, imshow(secondLine);

    %%FirstLine
    colsum = sum(firstLine, 1);
    startIdx = -1;

    line1='';
    line2='';

    cnt = 0;
    for i=1:length(colsum)
        if colsum(i)>0 && startIdx == -1
            startIdx = i;
        elseif colsum(i)==0 && startIdx~=-1
            %figure, imshow(firstLine(:, startIdx:i-1));
            cnt = cnt+1;
            if cnt==2
                line1 = [line1 ' Metro'];
                startIdx = -1;
            else
                char = cut_border(firstLine(:, startIdx:i-1));
                figure, imshow(char);
                line1 = [line1 ' ' character(char, 1)];
                startIdx = -1;
            end
        end
    end

    %%SecondLine
    colsum = sum(secondLine, 1);
    startIdx = -1;
    for i=1:length(colsum)
        if colsum(i)>0 && startIdx == -1
            startIdx = i;
        elseif colsum(i)==0 && startIdx~=-1
            %figure, imshow(secondLine(:, startIdx:i-1 ));
            char = cut_border(secondLine(:, startIdx:i-1));
            line2 = [line2 character(char, 2)];
            startIdx = -1;
        end
    end

    disp(line1);
    disp(line2);
end

function mat = cut_border(img)
    mat = [];

    rowsum = sum(img, 2);

    rlow = 0; rhigh = 0;
    for i=1:length(rowsum)
        if rowsum(i)~=0
            rlow = i;
            break;
        end
    end

    for i=length(rowsum):-1:1
        if rowsum(i)~=0
            rhigh = i;
            break;
        end
    end
    
    
    colsum = sum(img, 1);

    clow = 0; chigh = 0;
    for i=1:length(colsum)
        if colsum(i)~=0
            clow = i;
            break;
        end
    end

    for i=length(colsum):-1:1
        if colsum(i)~=0
            chigh = i;
            break;
        end
    end
    
    mat = img(rlow:rhigh, clow:chigh);
end