% read image
fid=fopen('paris.lan','r');
fseek(fid,128,-1);
A=fread(fid,[512*7 512],'uint8');
for i=1:7
    Cub(:,:,i)=A(512*(i-1)+1:512*i,:)';
end

%% supervised pure-pixel classification
% minimum distance
% choose center manually
%%% vegetation
m1=mean(reshape(Cub(318:322,51:55,:),25,7))';
%%% water
m2=mean(reshape(Cub(279:281,265:270,:),18,7))';
%%% building
m3=mean(reshape(Cub(225:230,291:300,:),60,7))';
% minimum Euclidean Distance
for i=1:512
    for j=1:512
        dis(1)=norm(shiftdim(Cub(i,j,:))-m1);
        dis(2)=norm(shiftdim(Cub(i,j,:))-m2);
        dis(3)=norm(shiftdim(Cub(i,j,:))-m3);
        [Y,k]=min(dis);
        class(i,j)=k;
    end
end
figure
imagesc(class)
% minimum city-block distance
for i=1:512
    for j=1:512
        dis(1)=sum(abs(shiftdim(Cub(i,j,:))-m1));
        dis(2)=sum(abs(shiftdim(Cub(i,j,:))-m2));
        dis(3)=sum(abs(shiftdim(Cub(i,j,:))-m3));
        [Y,k]=min(dis);
        class1(i,j)=k;
    end
end
figure
imagesc(class1)
% minimum Mahalanobis Distance
C1=(reshape(Cub(318:322,51:55,:),25,7))'*(reshape(Cub(318:322,51:55,:),25,7))/25-m1*m1';
C2=(reshape(Cub(279:281,265:270,:),18,7))'*(reshape(Cub(279:281,265:270,:),18,7))/18-m2*m2';
C3=(reshape(Cub(225:230,291:300,:),60,7))'*(reshape(Cub(225:230,291:300,:),60,7))/60-m3*m3';
for i=1:512
    for j=1:512
        dis(1)=(shiftdim(Cub(i,j,:))-m1)'*inv(C1)*(shiftdim(Cub(i,j,:))-m1);
        dis(2)=(shiftdim(Cub(i,j,:))-m2)'*inv(C2)*(shiftdim(Cub(i,j,:))-m2);
        dis(3)=(shiftdim(Cub(i,j,:))-m3)'*inv(C3)*(shiftdim(Cub(i,j,:))-m3);
        [Y,k]=min(dis);
        class2(i,j)=k;
    end
end
figure
imagesc(class2)

%% Unsupervised pure pixel classification
% K-mean
M=rand(7,3)*255;     % random initial
M1=zeros(7,3);
while sum(sum(abs(M-M1)))>1 % New and old center compare
    M1=M;
    % minimum distance classification
    for i=1:512
        for j=1:512
            for k=1:3
                dis(k)=norm(shiftdim(Cub(i,j,:))-M(:,k));
            end
            [Y,m]=min(dis);
            class(i,j)=m;
        end
    end
    figure,imagesc(class)
    drawnow
    % update mean (center)
    for i=1:7
        for k=1:3
            M(i,k)=sum(sum(Cub(:,:,i).*(class==k)))/nnz(class==k);
        end
    end
end

%% supervised mixed pixel
% Least Square
M=[m1 m2 m3];
for i=1:512
    for j=1:512
        abd(i,j,:)=inv(M'*M)*M'*shiftdim(Cub(i,j,:));
        abd1(i,j,:)=lsqnonneg([M ; 10000*[1 1 1]],[shiftdim(Cub(i,j,:));10000]);
    end
end
figure
for i=1:3
    subplot(2,2,i)
    imagesc(abd(:,:,i))
end
colormap(gray)
figure
for i=1:3
    subplot(2,2,i)
    imagesc(abd1(:,:,i))
end
colormap(gray)

% Maximum Likelihood
C1=(reshape(Cub(318:322,51:55,:),25,7))'*(reshape(Cub(318:322,51:55,:),25,7))/25-m1*m1';
C2=(reshape(Cub(279:281,265:270,:),18,7))'*(reshape(Cub(279:281,265:270,:),18,7))/18-m2*m2';
C3=(reshape(Cub(225:230,291:300,:),60,7))'*(reshape(Cub(225:230,291:300,:),60,7))/60-m3*m3';
for i=1:512
    for j=1:512
        y(3)=.4/sqrt((2*pi)^7*det(C3))*exp(-1/2*(shiftdim(Cub(i,j,:))-m3)'*inv(C3)*(shiftdim(Cub(i,j,:))-m3));
        y(2)=.1/sqrt((2*pi)^7*det(C2))*exp(-1/2*(shiftdim(Cub(i,j,:))-m2)'*inv(C2)*(shiftdim(Cub(i,j,:))-m2));
        y(1)=.5/sqrt((2*pi)^7*det(C1))*exp(-1/2*(shiftdim(Cub(i,j,:))-m1)'*inv(C1)*(shiftdim(Cub(i,j,:))-m1));
        abd(i,j,:)=y/sum(y);
    end
end
for i=1:3
    subplot(2,2,i)
    imagesc(abd(:,:,i))
end

abd(find(abd<0))=0;
abd(find(abd>1))=1;
for i=1:3
    subplot(2,2,i)
    imagesc(abd(:,:,i))
end

%% unsupervised mixed pixel
% First endmember
z=reshape(Cub,512*512,7)';
tmp=sum(z.^2);
[Y,m]=max(tmp);
M=z(:,m);
% rest endmembers
for i=1:3
    % orthogonal subspace
    P=eye(7)-M*inv(M'*M)*M';
    tmp=sum((P*z).^2);
    [Y,m]=max(tmp);
    M(:,i+1)=z(:,m);
end
% LS
abd=inv(M'*M)*M'*z;
for i=1:size(z,2)        
abd2(:,i)=lsqnonneg([M ; 10000*[1 1 1 1]],[z(:,i);10000]);
end

figure
for i=1:4
    subplot(2,2,i)
    imagesc(reshape(abd(i,:),512,512))
end
colormap(gray)
figure
for i=1:4
    subplot(2,2,i)
    imagesc(reshape(abd2(i,:),512,512))
end
colormap(gray)