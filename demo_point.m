% image read
A=imread('cameraman.tif');
imagesc(A)
colormap(gray)
% uint8 cannot do calculation
sqrt(A(1:5,1:5))
% convert to double
A1=double(A);
sqrt(A1(1:5,1:5))
% histogram
x=0:255;
[y,x]=hist(double(A(:)),x);
figure, bar(x,y)
figure, plot(x,y)
A=double(A);
% histogram for each column
[y1,x]=hist(double(A),x);
plot(y1)
% original image
figure, subplot(2,1,1), imagesc(A), colormap(gray)
subplot(2,1,2), bar(x,y)
% image negative 
for i=1:256
for j=1:256
A1(i,j)=255-A(i,j);
end
end
% image negative
B=255-A;
figure, subplot(2,1,1), imagesc(B), colormap(gray)
[y1,x]=hist(B(:),x);
subplot(2,1,2), bar(x,y1)
% square root
D=sqrt(A*255);
[y1,x]=hist(D(:),x);
figure, subplot(2,1,1), imagesc(D), colormap(gray)
subplot(2,1,2), bar(x,y1)
% 3rd order root
D=(A*255*255).^(1/3);
[y1,x]=hist(D(:),x);
figure, subplot(2,1,1), imagesc(D), colormap(gray)
subplot(2,1,2), bar(x,y1)
% square
E=A.^2/255;
imagesc(E)
[y1,x]=hist(E(:),x);
figure, subplot(2,1,1), imagesc(E), colormap(gray)
subplot(2,1,2), bar(x,y1)
% piecewise linear
imagesc(A<=100)
C=A*2.*(A<=100)+(200+55/155*(A-100)).*(A>100);
[y1,x]=hist(C(:),x);
figure, subplot(2,1,1), imagesc(C), colormap(gray)
subplot(2,1,2), bar(x,y1)

% histogram equalization
[y,x]=hist(double(A(:)),x);
y=y/(256*256);
for i=1:256
z(i)=sum(y(1:i));
end
for i=1:256
F(A==(i-1))=z(i)*255;
end
figure, imagesc(F), pause(5)
imagesc(reshape(F,256,256))
plot(z)
[y1,x]=hist(F(:),x);
figure, subplot(2,1,1), imagesc(reshape(F,256,256)), colormap(gray)
subplot(2,1,2), bar(x,y1)

% histogram specification (Gaussian)
y1=exp(-0.5*(x-128).^2/40^2);
plot(x,y1)
y1=y1/sum(y1);
plot(x,y1)
bar(x,y1)
for i=1:256
z1(i)=sum(y1(1:i));
end
for i=1:256
[Y,m]=max(z1>z(i));
F(A==(i-1))=m;
end
[y1,x]=hist(F(:),x);
figure, subplot(2,1,1), imagesc(reshape(F,256,256)), colormap(gray)
subplot(2,1,2), bar(x,y1)

% bit-plane slice
for i=1:8
B(:,:,i)=uint8(A>=2^(8-i));
A=A-2^(8-i).*double(B(:,:,i));
end
figure
for i=1:8
subplot(3,3,i)
imagesc(B(:,:,i))
end
colormap(gray)
subplot(3,3,9)
A=imread('cameraman.tif');
A=double(A);
imagesc(A)
% recover
A1=zeros(256);
for i=1:8
A1=A1+2^(8-i)*B(:,:,i);
subplot(3,3,i)
imagesc(A1)
end
% substitude last bit plane by other image
A2=imread('circles.png');
B(:,:,8)=A2;
for i=1:8
subplot(3,3,i)
imagesc(B(:,:,i))
end
figure
A1=zeros(256);
for i=1:8
A1=A1+2^(8-i)*B(:,:,i);
subplot(3,3,i)
imagesc(A1)
end
colormap(gray)
imagesc(A1)