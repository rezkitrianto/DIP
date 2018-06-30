At=zeros(206,345);
Bu=1;
imagesc(At);
while Bu~=3
    [x1,y1,Bu]=ginput(1);
    At(round(y1)-1:round(y1)+1,round(x1)-1:round(x1)+1)=1;
    imagesc(At)
    drawnow;
end