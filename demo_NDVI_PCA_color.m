fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
imagesc(A)
for i=1:7
A1(:,:,i)=A(512*(i-1)+1:512*i,:)';
end
for i=1:7
subplot(3,3,i)
imagesc(A1(:,:,i))
end
figure
image(A1(:,:,[3 2 1])/255)
image(A1(:,:,[4 3 2])/255)
image(A1(:,:,[1 4 7])/255)
ndvi=(A1(:,:,4)-A1(:,:,3))./(A1(:,:,4)+A1(:,:,3));
rvi=(A1(:,:,4))./(A1(:,:,3));
imagesc(ndvi)
figure
imagesc(rvi)
colormap(gray)
A2=A1;

A1(:,:,6)=[];                                                               
z=reshape(A1,512*512,6)';
R=(z-repmat(mean(z')',1,512*512))*(z-repmat(mean(z')',1,512*512))';
R=R/(512*512);
[V,D]=eig(R);                                                               
diag(D), PC=fliplr(V)'*z;                                                            
for i=1:6
subplot(3,2,i)
imagesc(reshape(PC(i,:),512,512))
end
colormap(gray)

fid=fopen('tokyo.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
for i=1:7
A1(:,:,i)=A(512*(i-1)+1:512*i,:)';
end
figure
for i=1:7
subplot(3,3,i)
imagesc(A1(:,:,i))
end
colormap(gray)
clf
image(A1(:,:,[1 4 7])/255)
image(A1(:,:,[4 3 2])/255)
A3=(A1(:,:,[4 3 2])/255);
B=rgb2hsv(A3);
figure
for i=1:3
subplot(2,2,i)
imagesc(B(:,:,i))
end
colormap(gray)
B1=B;
B1(:,:,3)=B(:,:,3).^(1/3);
C=hsv2rgb(B1);
figure
image(C)
figure
image(A3.^(1/3))
C1=C(161:220,321:380,:);
figure
image(C1)
A3=(A2(:,:,[4 3 2])/255);
image(A3)
B=rgb2hsv(A3);
clf
for i=1:3
subplot(2,2,i)
imagesc(B(:,:,i))
end
B1=B;
B1(:,:,3)=B(:,:,3).^(1/2);
C=hsv2rgb(B1);
image(C)
B1(:,:,3)=B(:,:,3).^(2);
C=hsv2rgb(B1);
image(C)
B1=B;
B1(:,:,2)=B(:,:,2).^(1/2);
C=hsv2rgb(B1);
image(C)
B1(:,:,2)=B(:,:,2).^(2);
C=hsv2rgb(B1);
image(C)
B1=B;
B1(:,:,1)=mod(B(:,:,1)+1/3,1);
C=hsv2rgb(B1);
image(C)
B1(:,:,1)=mod(B(:,:,1)-1/3,1);
C=hsv2rgb(B1);
image(C)

Tass=[.2909 .2493 .4806 .5568 .4438 .1706;
-.2728 -.2174 -.5508 .7221 .0733 -.1648;
.1446 .1761 .3322 .3396 -.6210 -.4186;
.8461 .0731 .464 -.0032 -.0492 .0119;
.0549 -.0232 .0339 -.1937 .4162 -.7823;
.1186 -.8069 .4094 .0571 -.0228 .022];
Bias=[10.3695 -.731 -3.3828 .7879 -2.4750 -.0336]';
Result=Tass*z+repmat(Bias,1,512*512);
for i=1:6
subplot(3,2,i)
imagesc(reshape(Result(i,:),512,512))
end
colormap(gray)
