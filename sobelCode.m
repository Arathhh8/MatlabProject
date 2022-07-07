clear all; clc; close all;

img = imread('Temperature.jpg');
Image = double(img)./255;
imshow(Image); title('Original Image'); %Original Image

A = rgb2gray(Image);
%figure(), imshow(A);title('Grayscale')
% output_imageA = im2bw(A,0.45);
% figure(),imshow(output_imageA); title('Seg') %% muestra la imagen de interés (segmentación)
BW1 = edge(A, 'Sobel');
figure(), imshow(BW1); title('Function Sobel')

[m,n,p] = size(A); %calculate rows and columns of matrix A
[m2,n2,p2] = size(A);
d = ones(m,n);
b = zeros(m,n);  % create arrays with zeros and m rows and n columns
c = zeros(m2,n2)
T = graythresh(A)
%   A = [35 40 41 45 50
%        40 40 42 46 52
%        42 46 50 55 55
%        48 52 56 58 60
%        56 60 65 70 75];
   
%   A = [3 0 1 2 7 4
%        1 5 8 9 3 1
%        2 7 2 5 1 3
%        0 1 3 1 7 8
%        4 2 1 6 2 8
%        2 4 5 2 3 9];
  
%    L = [111 222 163 230 224 217
%         225 32  110 215 187 88
%         41  92  184 97  161 16
%         194 233 127 202 29  194
%         166 141 164 172 237 99
%         72  66  204 8   225 139];
  
% ------------------------------------SOBEL-------------------------------------%
  Gx = [-1 0 1      
        -2 0 2
        -1 0 1];
   
  Gy = [-1 -2 -1      
         0  0  0
         1  2  1];

 %----------------------Calculate values for the x-axis--------------------------%

  for i = 2: m-1 % m = number of rows in Image A
      for j = 2: n-1 % n number of columns in Image A
         
          b(i,j) = Gx(1,1)*A(i-1,j-1) +Gx(1,2)*A(i-1,j) + Gx(1,3)*A(i-1,j+1)...
                 + Gx(2,1)*A(i,j-1)   +Gx(2,2)*A(i,j)   + Gx(2,3)*A(i,j+1)...
                 + Gx(3,1)*A(i+1,j-1) +Gx(3,2)*A(i+1,j) + Gx(3,3)*A(i+1,j+1);
               
      end
  end
  
  %----------------------Calculate values for the y-axis--------------------------%
  for i = 2: m2-1
      for j = 2: n2-1
          
          c(i,j) = Gy(1,1)*A(i-1,j-1) +Gy(1,2)*A(i-1,j) + Gy(1,3)*A(i-1,j+1)...
                 + Gy(2,1)*A(i,j-1)   +Gy(2,2)*A(i,j)   + Gy(2,3)*A(i,j+1)...
                 + Gy(3,1)*A(i+1,j-1) +Gy(3,2)*A(i+1,j) + Gy(3,3)*A(i+1,j+1); 
              
      end
  end

%   for i = 2: m-1
%       for j = 2: n-1
%           
%           d(i,j) = Gx(1,1)*A(i-1,j-1) +Gx(1,2)*A(i-1,j) + Gx(1,3)*A(i-1,j+1)...
%                  + Gx(2,1)*A(i,j-1)   +Gx(2,2)*A(i,j)   + Gx(2,3)*A(i,j+1)...
%                  + Gx(3,1)*A(i+1,j-1) +Gx(3,2)*A(i+1,j) + Gx(3,3)*A(i+1,j+1);
%           if d(i,j) > 0.07
%               d(i,j) = 1;
%           elseif d(i,j) <0.07
%               d(i,j) = 0;
%           end
%       end
%   end
  
%   figure()
%   imshow(d)
%   title('prueba')
%   d
  a3 = sqrt(b.^2+c.^2);
 % figure(), imshow(a3); title('Imagen sobel final')

%   % Define a threshold value
%  thresholdValue = 100; % varies between [0 255]
%  output_imageX = max(b, thresholdValue);
%  output_image = max(a3, thresholdValue);
%  output_image(output_image == round(thresholdValue)) = 0;
%  output_image(output_image == round(thresholdValue)) = 0;
 
% Displaying Output Image
output_image = im2bw(a3,0.2);
output_imageX = im2bw(b);
figure, imshow(output_image); title('Edge Detected Image');
 