clc; clear all; close all;
Image = imread('Temperature.jpg');
figure(), imshow(Image), title('Real Image');

ImGray = rgb2gray(Image);
figure(),imshow(ImGray)
ImSobel = edge(ImGray,'Sobel');
figure(),imshow(ImSobel),title('Sobel Image');
[rows,cols] = size(ImSobel);
xInitial = [0,0];, x2Initial = 0;,yInitial = 0;,y2Initial = 0;
topLeft = [rows cols]; %initial point 
lowRight = [0 0]; % this array will be use to colocated the final point

%% code to detect edges in ImSobel image 
for i = 2: rows-1 % rows = number of rows in ImSobel image
      for j = 2: cols-1 % cols = number of columns in ImSobel image 
          if ( ImSobel(i,j) == 1 && ImSobel(i,j+2)== 1 && ImSobel(i,j+4)== 1 && ImSobel(i,j+6)== 1 && ImSobel(i,j+10) == 1) %this is the range to detect a edge in ImSobel image

              if ( j < topLeft(1,2) ) % x resolution
                yInitial = i; %i axe y
                xInitial = j; %j axe x
                topLeft(1,1) = yInitial;
                topLeft(1,2) = xInitial;   
              end 
              if (j > lowRight(1,2) && i + 5 > topLeft(1,1) && i - 5 > topLeft(1,1))    
                   y2Initial = i;
                   x2Initial = j;
                   lowRight(1,1) = y2Initial;
                   lowRight(1,2) = x2Initial;
              end
              if( i == lowRight(1,1) && j > lowRight(1,2))
                   x2Initial = j;
                   lowRight(1,2) = x2Initial;
              end
          end 
      end
end
lowRight(1,2) = lowRight(1,2) + 10; % final point

%% Section to graph a new image  
% topLeft - - - - - -   - 
%   -     - - - - - -   -  
%   -     - - - - - -   - 
%   - - - - - - - - - lowRight


%% creating new segmented image using imcrop
rec = imcrop(Image,[topLeft(1,2)-10 topLeft(1,1)-10 lowRight(1,2)-topLeft(1,2)+20 lowRight(1,1)-topLeft(1,1)+20]);
figure(4), imshow(rec),title('Segmented Image')


%% creating new segmented image with code
%newImage = [0 0];
%a = 0;
%b = 1;
%newImage = [lowRight(1,1)-topLeft(1,1) lowRight(1,2)-topLeft(1,2)]
% for i = topLeft(1,1): lowRight(1,1)
%     a = a+1
%     
%       for j = topLeft(1,2): lowRight(1,2)
%           newImage(a,b) = ImSobel(i,j);
%           newImage(a,b)
%           ImSobel(i,j)
%           if (b < lowRight(1,2)-topLeft(1,2))
%               b = b+1;
%           end
%           if (b > lowRight(1,2))
%               b = 1;
%           end          
%           b
%       end 
% end 
