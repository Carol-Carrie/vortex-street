%% 

clc;
clear;
warning off;
num1=xlsread('00-22.xlsx', 'data2','D3:E98');
num2=xlsread('00-22.xlsx', 'data2','A3:B118');
num1=num1';num2=num2';


% 
n=length(num1);
for i=1:n
    if num1(2,i)==0
        num1(1,i)=NaN;
    end
end
[~,b1]=find(isnan(num1));
[~,b2]=find(isnan(num2));
num1(:,b1)=[];num2(:,b2)=[];
n1=length(num1);
n2=length(num2);
num11=num1(1,:);
num12=num1(2,:);
num21=num2(1,:);
num22=num2(2,:);


[num11_re,~]=mapminmax(num11);
[num12_re,~]=mapminmax(num12);
[num21_re,~]=mapminmax(num21);
[num22_re,~]=mapminmax(num22);
num1_re(1,:)=num11_re;
num1_re(2,:)=num12_re;
num2_re(1,:)=num21_re;
num2_re(2,:)=num22_re;





for i=1:n1
    num1_hos(i)=10000;%num1
    for j=1:n2
        num1_hos(i)=min(num1_hos(i),sqrt((num1_re(1,i)-num2_re(1,j)).^2+(num1_re(2,i)-num2_re(2,j)).^2));
    end            
end

for i=1:n2
    num2_hos(i)=10000;%num2
    for j=1:n1
        num2_hos(i)=min(num2_hos(i),sqrt((num2_re(1,i)-num1_re(1,j)).^2+(num2_re(2,i)-num1_re(2,j)).^2));
    end
end
% 


accuracy_11 = 0;
accuracy_21 = 0;
accuracy_12 =0;
accuracy_22 = 0;
accuracy_13 = 0;
accuracy_23 = 0;
k1=0;q1=0;
k2=0;q2=0;

wheels = [1 2 3 4];
names = ["power" "exp" "rat" "weibull"];
d = containers.Map(wheels,names);
% 
   k1 =20;k2=30;m=1;
   [~,I1]=mink(num1_hos,k1);%
    num1_use = zeros(2,length(I1));
    for i=1:k1
        
        num1_use(:,i)=num1(:,I1(i));
    end

    n1=length(num1_use);
    num11=num1_use(1,:);
    num12=num1_use(2,:);


    [~,I2]=mink(num2_hos,m*k2);
    num2_use = zeros(2,length(I2));

    for i=1:m*k2
        num2_use(:,i)=num2(:,I2(i));
    end

    n2=length(num2_use);
    num21=num2_use(1,:);
    num22=num2_use(2,:);
    save('graypoint.txt','num11','num12','num21','num22',"-ascii")
  

    plot(num1_use(1,:),num1_use(2,:),'b*')
    hold on
    plot(num2_use(1,:),num2_use(2,:),'r*')
    xlabel('Upstream average velocity (m/s)')
    ylabel('Calibration of temperature inversion intensity (K/m)')
    yline(0)
    % title('1-norm power')
    set(gca,'Xlim',[0,25])
    xticks([0 5 10 15 20 25])
    xticklabels({'0','5','10','15','20','25'})
    set(gca,'Ylim',[0,0.012])
    set(gca,'YTick',[0:0.002:0.012])
    set(gca,'FontName','times new roman')
%     % legend('non-vortex','vortex',d(q1),d(q2))
%     legend('non-vortex','vortex')
%     hold on
% %     end
% % end
%     xlabel('wind speed')
%     ylabel('inversion')
%     yline(0)




% 
% for k = 10:2:36
% %     for m=1:0.5:2.5
% 
%     
%     [~,I1]=mink(num1_hos,k);
%     num1_use = zeros(2,length(I1));
%     for i=1:k
%         
%         num1_use(:,i)=num1(:,I1(i));
%     end
% 
%     n1=length(num1_use);
%     num11=num1_use(1,:);
%     num12=num1_use(2,:);
% 
%     
% 
% 
%     [~,I2]=mink(num2_hos,m*k);
%     num2_use = zeros(2,length(I2));
% 
%     for i=1:m*k
%         num2_use(:,i)=num2(:,I2(i));
%     end
% 
%     n2=length(num2_use);
%     num21=num2_use(1,:);
%     num22=num2_use(2,:);
%     plot(num1_use(1,:),num1_use(2,:),'b*')
%     hold on
%     plot(num2_use(1,:),num2_use(2,:),'r*')
%     xlabel('wind speed')
%     ylabel('inversion')
%     yline(0)
%     




% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%
% for k = 10:5:30
%      for m=1:3
% 
%     
% %     [~,I1]=mink(num1_hos,k);
% %     num1_use = zeros(2,length(I1));
% %     for i=1:k
% %         
% %         num1_use(:,i)=num1(:,I1(i));
% %     end
% % 
% %     n1=length(num1_use);
% %     num11=num1_use(1,:);
% %     num12=num1_use(2,:);
% % 
% % 
%     [~,I2]=mink(num2_hos,m*k);
%     num2_use = zeros(2,length(I2));
% 
%     for i=1:m*k
%         num2_use(:,i)=num2(:,I2(i));
%     end
% 
%     n2=length(num2_use);
%     num21=num2_use(1,:);
%     num22=num2_use(2,:);
% % %     plot(num1_use(1,:),num1_use(2,:),'b*')
% % %     hold on
% % %     plot(num2_use(1,:),num2_use(2,:),'r*')
% % %     xlabel('wind speed')
% % %     ylabel('inversion')
% % %     yline(0)
% %     
% % %     %%%
% %     %%%%%%%%%%%%%%%%%power
% %     [fitresult1, ~] = power1(num21, num22, num1);
% %     y2=fitresult1(num2(1,:));
% %     ans1=y2'<num2(2,:);
% %     y1=fitresult1(num1(1,:));
% %     ans2=y1'<num1(2,:);
% %     
% %     sum1 = sum(ans1);
% %     sum2 = sum(ans2);
% %     
% %     if sum1/(sum1+sum2)>accuracy_21
% %         accuracy_21 = sum1/(sum1+sum2);
% %         fitresult_d = fitresult1;
% %         accuracy_22 = sum1/(length(ans1));
% %         accuracy_23 = sum2/length(ans2);
% % 
% %         k2=m*k;q2=1;
% %     else if sum1/(sum1+sum2)==accuracy_21
% %             if sum1/(length(ans1))>accuracy_22
% %                 fitresult_d = fitresult1;
% %                 accuracy_22 = sum1/(length(ans1));
% %                 accuracy_23 = sum2/length(ans2);
% %                 k2=m*k;q2=1;
% %             else if sum1/(length(ans1))==accuracy_22
% %                     if accuracy_23<sum2/length(ans2) 
% %                         fitresult_d = fitresult1;
% %                         accuracy_23 = sum2/length(ans2);
% %                         k2=m*k;q2=1;
% %                     end
% %             end
% %             end
% %     end
% %     end
%     
%     %%%%%%%%%%%%%%%exp1
%     [fitresult1, ~] = exp1(num21, num22, num1);
%     y2=fitresult1(num2(1,:));
%     ans1=y2'<num2(2,:);%
%     y1=fitresult1(num1(1,:));
%     ans2=y1'<num1(2,:);%
%     
%     sum1 = sum(ans1);
%     sum2 = sum(ans2);
%     
%     if sum1/(sum1+sum2)>accuracy_21
%         accuracy_21 = sum1/(sum1+sum2);
%         fitresult_d = fitresult1;
%         accuracy_22 = sum1/(length(ans1));
%         accuracy_23 = sum2/length(ans2);
% 
%         k2=m*k;q2=2;
%     else if sum1/(sum1+sum2)==accuracy_21
%             if sum1/(length(ans1))>accuracy_22
%                 fitresult_d = fitresult1;
%                 accuracy_22 = sum1/(length(ans1));
%                 accuracy_23 = sum2/length(ans2);
%                 k2=m*k;q2=2;
%             else if sum1/(length(ans1))==accuracy_22
%                     if accuracy_23<sum2/length(ans2) 
%                         fitresult_d = fitresult1;
%                         accuracy_23 = sum2/length(ans2);
%                         k2=m*k;q2=2;
%                     end
%             end
%             end
%     end
%     end
% %     
% % %     %%%%%%%%%%%%%%%%rat1
% % %     [fitresult1, ~] = rat1(num21, num22, num1);
% % %     y2=fitresult1(num2(1,:));
% % %     ans1=y2'<num2(2,:);
% % %     y1=fitresult1(num1(1,:));
% % %     ans2=y1'<num1(2,:);
% % %     
% % %     sum1 = sum(ans1);
% % %     sum2 = sum(ans2);
% % %     
% % %     if sum1/(sum1+sum2)>accuracy_21
% % %         accuracy_21 = sum1/(sum1+sum2);
% % %         fitresult_d = fitresult1;
% % %         accuracy_22 = sum1/(length(ans1));
% % %         accuracy_23 = sum2/length(ans2);
% % % 
% % %         k2=m*k;q2=3;
% % %     else if sum1/(sum1+sum2)==accuracy_21
% % %             if sum1/(length(ans1))>accuracy_22
% % %                 fitresult_d = fitresult1;
% % %                 accuracy_22 = sum1/(length(ans1));
% % %                 accuracy_23 = sum2/length(ans2);
% % %                 k2=m*k;q2=3;
% % %             else if sum1/(length(ans1))==accuracy_22
% % %                     if accuracy_23<sum2/length(ans2) 
% % %                         fitresult_d = fitresult1;
% % %                         accuracy_23 = sum2/length(ans2);
% % %                         k2=m*k;q2=3;
% % %                     end
% % %             end
% % %             end
% % %     end
% % %     end
% %     
%     %%%%%%%%%%%%%%%%%weibull1
%     [fitresult1, ~] = weibull1(num21, num22, num1);
%     y2=fitresult1(num2(1,:));
%     ans1=y2'<num2(2,:);%
%     y1=fitresult1(num1(1,:));
%     ans2=y1'<num1(2,:);%
%     
%     sum1 = sum(ans1);
%     sum2 = sum(ans2);
%     
%     if sum1/(sum1+sum2)>accuracy_21
%         accuracy_21 = sum1/(sum1+sum2);
%         fitresult_d = fitresult1;
%         accuracy_22 = sum1/(length(ans1));
%         accuracy_23 = sum2/length(ans2);
% 
%         k2=m*k;q2=4;
%     else if sum1/(sum1+sum2)==accuracy_21
%             if sum1/(length(ans1))>accuracy_22
%                 fitresult_d = fitresult1;
%                 accuracy_22 = sum1/(length(ans1));
%                 accuracy_23 = sum2/length(ans2);
%                 k2=m*k;q2=4;
%             else if sum1/(length(ans1))==accuracy_22
%                     if accuracy_23<sum2/length(ans2)
%                         fitresult_d = fitresult1;
%                         accuracy_23 = sum2/length(ans2);
%                         k2=m*k;q2=4;
%                     end
%             end
%             end
%     end
%     end
% 
% 
%     end
% end
% 
% 
% x=2:0.25:22;
% plot(num1(1,:),num1(2,:),'r.')
% hold on
% plot(num2(1,:),num2(2,:),'b.')
% hold on
% 
% plot(x,fitresult(x),'g')
% hold on
% plot(x,fitresult_d(x),'m')
% hold on
% 
% % x.*fitresult(x);
% % x.*fitresult_d(x);
% % % 



% % 
% % for i = 1:15
% %     y=0.002*i./sqrt(x);
% %     plot(x,y,'k')
% %     hold on
% % end
% % y1=0.01./sqrrt(x);y2 = 0.025./sqrt(x);
% % plot(x,y1,'k')
% % hold on
% % plot(x,y2,'k')
% 
% 

% 
% xlabel('Upstream average velocity (m/s)')
% ylabel('Calibration of temperature inversion intensity (K/m)')
% yline(0)
% % title('1-norm power')
% set(gca,'Xlim',[0,25])
% xticks([0 5 10 15 20 25])
% xticklabels({'0','5','10','15','20','25'})
% set(gca,'YTick',[0:0.002:0.012])
% set(gca,'FontName','times new roman')
% % legend('non-vortex','vortex',d(q1),d(q2))
%  legend('cloud without vortices',' cloud with vortices','fit line 2','fit line 1')
% % legend('non-vortex','vortex',d(q2))



