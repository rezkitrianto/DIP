A=imread('autumn.tif');
A=double(A);
% HSI color system
B=rgb2hsv(A);
for i=1:3
subplot(2,2,i)
imagesc(B(:,:,i))
end
colormap(gray)
subplot(2,2,4)
image(A/255)
% Point operation on intensity
figure
B1=B;
B1(:,:,3)=sqrt(B(:,:,3)*255);
subplot(2,2,1)
imagesc(B1(:,:,3))
colormap(gray)
A1=hsv2rgb(B1);
subplot(2,2,2)
image(A1/255)
B1=B;
B1(:,:,3)=(B(:,:,3).^2)/255;
subplot(2,2,3)
imagesc(B1(:,:,3))
colormap(gray)
A1=hsv2rgb(B1);
subplot(2,2,4)
image(A1/255)
% Mask operation on intensity
figure
M=ones(5)/25;
B1(:,:,3)=conv2(B(:,:,3),M,'same');
subplot(2,2,1)
imagesc(B1(:,:,3))
A2=hsv2rgb(B1);
subplot(2,2,2)
image(A2/255)
% Fourier
D=fft2(B(:,:,3));
D1=fftshift(D);
[m,n]=size(D);
H=zeros(size(D));
[X,Y]=meshgrid(1:n,1:m);
H=sqrt((X-floor(n/2)).^2+(Y-floor(m/2)).^2)<80;
C=D1.*H;
E=ifftshift(C);
F=ifft2(E);
subplot(2,2,3)
imagesc(abs(F))
F=abs(F);
B1(:,:,3)=(F-min(min(F)))/(max(max(F))-min(min(F)))*255;
A2=hsv2rgb(B1);
subplot(2,2,4)
image(A2/255)

% Point operation on Saturation
figure
B1=B;
B1(:,:,2)=sqrt(B(:,:,2));
A1=hsv2rgb(B1);
subplot(2,2,1)
A1(find(A1<0))=0;
image(A1/255)
B1=B;
B1(:,:,2)=(B(:,:,2).^2);
A1(find(A1<0))=0;
A1=hsv2rgb(B1);
subplot(2,2,2)
image(A1/255)

% Point operation on Hue
B1=B;
B1(:,:,1)=mod(B(:,:,1)+1/3,1);
A1=hsv2rgb(B1);
subplot(2,2,3)
image(A1/255)
B1=B;
B1(:,:,1)=mod(B(:,:,1)-1/3,1);
A1=hsv2rgb(B1);
subplot(2,2,4)
image(A1/255)