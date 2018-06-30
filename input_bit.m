A=zeros(100,150);
imagesc(A)
bt=1;
while bt==1
[x,y,bt]=ginput(1);
A(round(y), round(x))=1;
imagesc(A)
drawnow
end