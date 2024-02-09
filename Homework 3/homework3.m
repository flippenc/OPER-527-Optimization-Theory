%x = linspace(0,10,1000);
%plot(x,f(x),'color','r');
%axis([0 10 -0.1 0.4])

% x = linspace(0,10,1000);
% plot(x,f(x),'color','red'); hold on;
% plot(x,fd1(x),'color','blue'); hold on;
% plot(x,fd2(x), 'color','black');
% axis([0 10 -1.2 1.2])
% 
% format long
% % apply Newton's Method on f' and f'' to find where f'=0
% [maximizer, results] = newtonsMethod(@fd1,@fd2,5.8,20,10^-6);
% % results are in the form (x_n, f'(x_n)) starting at n=0
% results
% % print x* and f(x*)
% [maximizer, f(maximizer)]

x = linspace(0,10,1000);
y = 15 + cos(13/7)*x;
plot(x,y)
