function letter = character(snap, line)
    
    snap=imresize(snap,[42 24]); 

	if line==1
		alph = false(16, 42, 24);
	    alph(1, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Kha-1.bmp')));
	    alph(2, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Ga1-1.bmp')));
	    alph(3, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Ga2-1.bmp')));

	    alph(4, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Dhaka1-1.bmp')));
	    alph(5, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Dhaka2-1.bmp')));
	    alph(6, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Chatta1-1.bmp')));
	    alph(7, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Chatta2-1.bmp')));

	    alph(8, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Metro1-1.bmp')));
	    alph(9, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Metro2-1.bmp')));
	    alph(10, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Metro3-1.bmp')));
	    alph(11, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Metro4-1.bmp')));
	    alph(12, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\cha-1.bmp')));
	    alph(13, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\ka-1.bmp')));
        alph(14, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\la-1.bmp')));
        alph(15, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\cha-2.bmp')));
        alph(16, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\Gha1-1.bmp')));

        rec=[ ];
	    for n=1:16
	        cor=corr2(squeeze(alph(n,:,:)),snap); 
	        rec=[rec cor]; 
	    end

	    ind=find(rec==max(rec));
	    %display(ind);


	    if ind==13
	        letter='Ka';
	    elseif ind==1
	        letter='Kha';
	    elseif ind==2 || ind==3
	        letter='Ga';
	    elseif ind==16
	        letter='Gha';
	    elseif ind==12 || ind==15
	        letter='Cha';
        elseif ind==14
	        letter='La';
	    elseif ind==4 || ind==5
	        letter='Dhaka';
	    elseif ind==6 || ind==7
	        letter='Chatta';
	    elseif ind==8 || ind==9 || ind==10 || ind==11
	        letter='Metro';
	    end

    elseif line==2   
	    %Natural Numbers
	    number = false(10, 42, 24);
	    number(1, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\1-1.bmp')));
	    number(2, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\2-1.bmp')));
	    number(3, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\3-1.bmp')));
	    number(4, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\4-1.bmp')));
	    number(5, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\5-1.bmp')));
	    number(6, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\6-1.bmp')));
	    number(7, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\7-1.bmp')));
	    number(8, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\8-1.bmp')));
	    number(9, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\9-1.bmp')));
	    number(10, :, :)=imbinarize(rgb2gray(imread('D:\github_ws\test thesis\Dataset\template\0-1.bmp')));

	    rec=[ ];
	    for n=1:10
	        cor=corr2(squeeze(number(n,:,:)),snap); 
	        rec=[rec cor]; 
	    end

	    ind=find(rec==max(rec));
	    %display(ind);

	    
	    if ind==1
	        letter='1';
	    elseif ind==2
	        letter='2';
	    elseif ind==3
	        letter='3';
	    elseif ind==4
	        letter='4';
	    elseif ind==5
	        letter='5';
	    elseif ind==6
	        letter='6';
	    elseif ind==7
	        letter='7';
	    elseif ind==8
	        letter='8';
	    elseif ind==9
	        letter='9';
	    elseif ind==10
	        letter='0';
	    end


	end

end