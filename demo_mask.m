A=imread('eight.tif');
A=double(A);
imagesc(A)
colormap(gray)
% low-pass (average)
M=ones(5)/25;
B=conv2(A,M);  
figure
imagesc(B)
colormap(gray) 
B=conv2(A,M,'same');
imagesc(B)
colormap(gray)
% remove the dark edge
C=ones(size(B));    
B=conv2(A,M,'same')./conv2(C,M,'same');
imagesc(B)
colormap(gray)
C1=conv2(C,M,'same');
figure
colormap(gray)
imagesc(C1*255)
mesh(M)
% low-pass (weighted average)
f=[.05 .25 .4 .25 .05];
M1=f'*f;
mesh(M1)
B=conv2(A,M1,'same')./conv2(C,M1,'same');
figure
imagesc(B)
colormap(gray)
% high-pass = original - low-pass
D=zeros(5);
D(3,3)=1;
M2=D-M1;
mesh(M2)
B=conv2(A,M2,'same')./conv2(C,M2,'same');
imagesc(B)
B=conv2(A,M1,'same')./conv2(C,M1,'same');
F=A-B;
imagesc(F)

% high-boost = original + high-pass
figure, imagesc(A+F), colormap(gray)
figure, imagesc(A+0.5*F), colormap(gray)

% low-pass (median filter)
I = imread('eight.tif');
J = imnoise(I,'salt & pepper', 0.02);
imagesc(I), figure, imagesc(J)
J=double(J);
for i=1:240
for j=1:306
temp=J(i:i+2,j:j+2);
temp1=sort(temp(:));
G(i,j)=temp1(5);
end
end
figure
colormap(gray)
imagesc(G)
% average can not remove salt&pepper noise
B=conv2(J,M1,'same')./conv2(C,M1,'same');
figure, imagesc(B), colormap(gray)

% edge detection
% Sobel filter
sobel1=[-1 -2 -1;0 0 0;1 2 1];
sobel2=sobel1';
A1=conv2(A,sobel1,'same');
A2=conv2(A,sobel2,'same');
figure
imagesc(A1)
colormap(gray)
figure
imagesc(A2)
colormap(gray)
imagesc(sqrt((A1).^2+(A2).^2))
imagesc(abs(A1)+abs(A2))
% Robert filter
robert1=[0 0 0 ; 0 -1 0 ; 0 0 1];
robert2=[0 0 0 ; 0 0 -1 ; 0 1 0];
A1=conv2(A,robert1,'same');
A2=conv2(A,robert2,'same');
imagesc(A2)
imagesc(A1)
imagesc(abs(A1)+abs(A2))

