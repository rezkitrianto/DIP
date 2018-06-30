load ImageCub
load cinder
load playa
load rhyolite
load vegetation
load shade

M=[cinder playa rhyolite vegetation shade];
M=M(:,2:2:10);
plot(M);

% Least Square
z=reshape(ImageCub,40000,158)';
abd=inv(M'*M)*M'*z;
abd1=reshape(abd',200,200,5);

figure
for i=1:5
    subplot(3,2,i)
    imagesc(abd1(:,:,i))
end
colormap(gray)

% Show all bands
for i=1:158
    imagesc(ImageCub(:,:,i))
    title(['Band ',num2str(i)])
    pause(0.3)
end
