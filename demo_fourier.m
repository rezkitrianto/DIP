A=imread('cameraman.tif');
A=double(A);
% Fourier
B=fft2(A);
figure
imagesc(A)
colormap(gray)
% Fourier spectrum
figure
imagesc(abs(B))
colormap(gray)
imagesc(log(abs(B)+1))
C=fftshift(B);
imagesc(log(abs(C)+1))

% ideal low-pass
H=zeros(256);
[X,Y]=meshgrid(1:256,1:256);
H=sqrt((X-128).^2+(Y-128).^2)<80;
figure
imagesc(H)
colormap(gray)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

% ideal high-pass
H=1-H;
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))


% Butterworth low-pass
H=1./(1+(sqrt((X-128).^2+(Y-128).^2)/80).^4);
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

% Butterworth high-pass
H=1-H;
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

% Butterworth high-boost
H=0.5+H;
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

% Gaussian low-pass
H=exp(-1*((X-128).^2+(Y-128).^2)/(2*30^2));
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

%Gaussian high-pass
H=1-H;
imagesc(H)
D=C.*H;
imagesc(log(abs(D)+1))
E=ifftshift(D);
F=ifft2(E);
imagesc(abs(F))

% Relationship of Mask and Fourier filters
% impulse
K=zeros(256);
K(128,128)=1;
K1=fft2(K);
mesh(abs(K1))
max(max(abs(K1)))
min(min(abs(K1)))
% average (low-pass)
K=zeros(256);
K(126:130,126:130)=1/25;
K1=fft2(K);
mesh(abs(K1))
K2=fftshift(K1);
mesh(abs(K2))
% weighted average (low-pass)
K=zeros(256);
f=[.05 .25 .4 .25 .05];
M1=f'*f;
K(126:130,126:130)=M1;
K1=fft2(K);
mesh(abs(K1))
K2=fftshift(K1);
mesh(abs(K2))
% high-pass
D=zeros(5);
D(3,3)=1;
M2=D-M1;
K(126:130,126:130)=M2;
K1=fft2(K);
mesh(abs(K1))
K2=fftshift(K1);
mesh(abs(K2))
