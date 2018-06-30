load fusion_spot
imagesc(A)
colormap(gray)
figure
image(A1(:,:,[3 2 1]))
B=A1(:,:,[3 2 1]);
C=rgb2hsv(B); 
D=zeros(1000,1000,3);
for i=1:4,for j=1:4
    D(i:4:end,j:4:end,:)=C;
end,end
D(:,:,3)=double(A)/255;
F=hsv2rgb(D);
figure
image(F)