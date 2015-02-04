% canny.m

function [x y] = canny(jpgFile,varargin)

% Get input.
parser = inputParser;
parser.FunctionName = 'canny';
parser.addRequired('jpgFile', @(x)exist(x,'file')==2);
parser.addParamValue('showFigs', 0, @(x)or(x==0,x==1));
parser.parse(jpgFile,varargin{:});
jpgFile = parser.Results.jpgFile;
showFigs = parser.Results.showFigs;

%%%%%%%%%%%%% The main.m file  %%%%%%%%%%%%%%%
% The algorithm parameters:
% 1. Parameters of edge detecting filters:
%    X-axis direction filter:
Nx1=10;
Sigmax1=1;
Nx2=10;
Sigmax2=1;
Theta1=pi/2;
%    Y-axis direction filter:
Ny1=10;
Sigmay1=1;
Ny2=10;
Sigmay2=1;
Theta2=0;
% 2. The thresholding parameter alfa:
alfa=0.1;

% Get the initial image lena.gif
x=imread(jpgFile);
w = rgb2gray(x);
%map = colormap;
%w=ind2gray(x,map);
if(showFigs)
    figure(1);colormap(gray);
    subplot(3,2,1);
    imagesc(w); %,200);
    title('Image: lena.gif');
end

% X-axis direction edge detection
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(double(w),double(filterx),'same');
if(showFigs)
    subplot(3,2,2);
    imagesc(Ix);
    title('Ix');
end

% Y-axis direction edge detection
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(double(w),double(filtery),'same');
if(showFigs)
    subplot(3,2,3)
    imagesc(Iy);
    title('Iy');
end

% Norm of the gradient (Combining the X and Y directional derivatives)
NVI=sqrt(Ix.*Ix+Iy.*Iy);
if(showFigs)
    subplot(3,2,4);
    imagesc(NVI);
    title('Norm of Gradient');
end

% Thresholding
I_max=max(max(NVI));
I_min=min(min(NVI));
level=alfa*(I_max-I_min)+I_min;
Ibw=max(NVI,level.*ones(size(NVI)));
if(showFigs)
    subplot(3,2,5);
    imagesc(Ibw);
    title('After Thresholding');
end

% Thinning (Using interpolation to find the pixels where the norms of
% gradient are local maximum.)
[n,m]=size(Ibw);
for i=2:n-1,
    for j=2:m-1,
        if Ibw(i,j) > level,
            X=[-1,0,+1;-1,0,+1;-1,0,+1];
            Y=[-1,-1,-1;0,0,0;+1,+1,+1];
            Z=[Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
                Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
                Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
            XI=[Ix(i,j)/NVI(i,j), -Ix(i,j)/NVI(i,j)];
            YI=[Iy(i,j)/NVI(i,j), -Iy(i,j)/NVI(i,j)];
            ZI=interp2(X,Y,Z,XI,YI);
            if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
                I_temp(i,j)=I_max;
            else
                I_temp(i,j)=I_min;
            end
        else
            I_temp(i,j)=I_min;
        end
    end
end
if(showFigs)
    subplot(3,2,6);
    imagesc(I_temp);
    title('After Thinning');
    colormap(gray);
end
%%%%%%%%%%%%%% End of the main.m file %%%%%%%%%%%%%%%

[rows cols]=ind2sub(size(I_temp),find(I_temp>I_min));
% May be off by 1....
x = cols;
y = rows;
if(showFigs)
    figure(2);
    imshow(jpgFile);
    hold on;
    scatter(x,y,'r*');
end