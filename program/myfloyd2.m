clear;warning('off');
n=154; d=zeros(n);
x=xlsread('1.xlsx');
start=floor(x(:,1));ending=floor(x(:,2));dij=x(:,3);
for i=1:length(start)
    d(start(i),ending(i))=dij(i);
end
% a(1,2)=50;a(1,4)=40;a(1,5)=25;a(1,6)=10;
% a(2,3)=15;a(2,4)=20;a(2,6)=25; a(3,4)=10;a(3,5)=20;
% a(4,5)=10;a(4,6)=25; a(5,6)=55;
d=d+d'; 
d(d==0)=inf; %把所有零元素替换成无穷
d([1:n+1:n^2])=0; %对角线元素替换成零，Matlab中数据是逐列存储的
[dist,mypath]=myfloyd(d,3,4)%3    69    80    81    88    89     4


