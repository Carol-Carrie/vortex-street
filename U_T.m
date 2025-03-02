%% 
clear all;
clc;
u=ncread('20070118.nc','u');
v=ncread('20070118.nc','v');
for i=1:1:11
      U(:,:,i)=permute(u(:,:,i),[2 1 3]);
      V(:,:,i)=permute(v(:,:,i),[2 1 3]);
      U1(:,:,i)=U([2 3 4],[8 9 10 11 12 13],i);
      V1(:,:,i)=V([2 3 4],[8 9 10 11 12 13],i);
      U2(:,:,i)=mean(U1(:,:,i),[1 2]);
      V2(:,:,i)=mean(V1(:,:,i),[1 2]);
      U3(:,:,i)=U2(:,:,i).^2;
      V3(:,:,i)=V2(:,:,i).^2;
      M(:,:,i)=U3(:,:,i)+V3(:,:,i);
      M1(:,:,i)=sqrt(M(:,:,i));
end
for k=1:1:10
    c=M1(:,:,k);
    d=M1(:,:,k+1);
    M2(:,:,k)=(c+d)/2;
end

M3=reshape(M2,1,10);
xlswrite('U.xlsx',M3,1,'C30');
%%
clear all;
clc;
T=ncread('20170118.nc','t');
Q=mean(T,[1 2]);
q=reshape(Q,1,11);
q1(:,:)=q(:,end:-1:1);
xlswrite('T.xlsx',q1,3,'C27');
%% 
clear all;
clc;
t=ncread('20170118.nc','t');%
for i=1:1:11
    t1(:,:,i)=permute(t(:,:,i),[2 1 3]);
    t2(:,:,i)=t1([4 5 6 7 8],[8 9 10 11 12 13],i);
end
 t3=mean(t2,[1 2]);
 t4=reshape(t3,1,11);
 T(:,:)=t4(:,end:-1:1);
xlswrite('T.xlsx',T,3,'C27');