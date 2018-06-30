dir *.lan
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
B=A(512*3+1:512*4,:)';
imagesc(B)
C=ones(size(B));
% Gaussian Pyramid
w=[.05 .25 .4 .25 .05];
% Reduce
W=w'*w;
D=conv2(B,W,'same')./conv2(C,W,'same');
G1=D(2:2:end,2:2:end);
figure
imagesc(G1)
colormap(gray)
% Expand
F=zeros(512);
F(2:2:end,2:2:end)=G1;
imagesc(F)
colormap(gray)
H=4*conv2(F,W,'same')./conv2(C,W,'same');
figure
imagesc(H)
colormap(gray)
figure
imagesc(B-H)
colormap(gray)
% Laplacian
L1=B-H;
% Use for loop
for i=1:6
eval(['B=G',num2str(i),';'])
C=ones(size(B));
D=conv2(B,W,'same')./conv2(C,W,'same');
G=D(2:2:end,2:2:end);
eval(['G',num2str(i+1),'=G;'])
F=zeros(size(G)*2);
F(2:2:end,2:2:end)=G;
H=4*conv2(F,W,'same')./conv2(C,W,'same');
eval(['L',num2str(i+1),'=B-H;'])
end
for i=2:7
subplot(3,2,i-1)
eval(['imagesc(G',num2str(i),')'])
end
colormap(gray)
figure
for i=2:7
subplot(3,2,i-1)
eval(['imagesc(L',num2str(i),')'])
end
colormap(gray)

% Box Pyramid
B=A(512*3+1:512*4,:)';
W=ones(2)/4;
D=conv2(B,W,'same');
G1=D(1:2:end,1:2:end);
figure
imagesc(G1)
colormap(gray)
F=zeros(512);
F(1:2:end,1:2:end)=G1;
imagesc(F)
colormap(gray)
H=4*conv2(F,W,'same');
figure
imagesc(H)
colormap(gray)
figure
imagesc(B-H)
colormap(gray)
L1=B-H;

for i=1:6
eval(['B=G',num2str(i),';'])
C=ones(size(B));
D=conv2(B,W,'same');
G=D(1:2:end,1:2:end);
eval(['G',num2str(i+1),'=G;'])
F=zeros(size(G)*2);
F(1:2:end,1:2:end)=G;
H=4*conv2(F,W,'same');
eval(['L',num2str(i+1),'=B-H;'])
end
for i=2:7
subplot(3,2,i-1)
eval(['imagesc(G',num2str(i),')'])
end
colormap(gray)
figure
for i=2:7
subplot(3,2,i-1)
eval(['imagesc(L',num2str(i),')'])
end
colormap(gray)
