fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
B=A(512*3+1:512*4,:)';

% Harr Wavelet (Compare to Box pyramid)
figure
subplot(1,2,1)
% low-pass in horizontal
C1=(B(:,1:2:end)+B(:,2:2:end))/2;
imagesc(C1)
subplot(1,2,2)
% high-pass in horizontal
C2=(B(:,1:2:end)-B(:,2:2:end))/2;
imagesc(C2)
% low-pass and high-pass in virtical
C11=(C1(1:2:end,:)+C1(2:2:end,:))/2;
C12=(C1(1:2:end,:)-C1(2:2:end,:))/2;
C21=(C2(1:2:end,:)+C2(2:2:end,:))/2;
C22=(C2(1:2:end,:)-C2(2:2:end,:))/2;
figure
subplot(2,2,1)
imagesc(C11)
subplot(2,2,3)
imagesc(C12)
subplot(2,2,2)
imagesc(C21)
subplot(2,2,4)
imagesc(C22)
colormap(gray)
B1=B;
% Again for LL image
B=C11;
C1=(B(:,1:2:end)+B(:,2:2:end))/2;
C22=(C2(1:2:end,:)-C2(2:2:end,:))/2;
C2=(B(:,1:2:end)-B(:,2:2:end))/2;
C11=(C1(1:2:end,:)+C1(2:2:end,:))/2;
C12=(C1(1:2:end,:)-C1(2:2:end,:))/2;
C21=(C2(1:2:end,:)+C2(2:2:end,:))/2;
C22=(C2(1:2:end,:)-C2(2:2:end,:))/2;
figure
subplot(2,2,1)
imagesc(C11)
subplot(2,2,3)
imagesc(C12)
subplot(2,2,2)
imagesc(C21)
subplot(2,2,4)
imagesc(C22)
colormap(gray)

% Wavelet compare to Gaussian pyramid
B=B1;
% low pass
wl=[.05 .25 .4 .25 .05];
% high pass
wh=[0 0 1 0 0]-wl;
D=conv2(B,wl,'same');
Dl=D(:,2:2:end);
D=conv2(B,wh,'same');
Dh=D(:,2:2:end);
DD=conv2(Dl,wl','same');
Dll=DD(2:2:end,:);
DD=conv2(Dl,wh','same');
Dlh=DD(2:2:end,:);
DD=conv2(Dh,wl','same');
Dhl=DD(2:2:end,:);
DD=conv2(Dh,wh','same');
Dhh=DD(2:2:end,:);
figure
subplot(2,2,1)
imagesc(Dll)
subplot(2,2,3)
imagesc(Dlh)
subplot(2,2,2)
imagesc(Dhl)
subplot(2,2,4)
imagesc(Dhh)

