clear;warning('off');
n=154; d=zeros(n);
x=xlsread('1.xlsx');
start=floor(x(:,1));ending=floor(x(:,2));dij=x(:,3);
for i=1:length(start)
    d(start(i),ending(i))=dij(i);
end
d=d+d'; 
d(d==0)=inf; %把所有零元素替换成无穷
d([1:n+1:n^2])=0; %对角线元素替换成零，Matlab中数据是逐列存储的
[d_all,path]=myfloyd(d);
startcity=[16,63,120];
endcity=[1,10,11,16,22,24,27,31,34,36,42,63,64,65,79,94,106,120,123,141,145];
d_simp=d_all(startcity,endcity);
xlswrite('distance.xlsx',d_simp);
% figure(1);
mypath=cell(length(startcity)*length(endcity),1);
for i=1:length(startcity)
    for j=1:length(endcity)
        sb=startcity(i);db=endcity(j);
        mypath((i-1)*length(endcity)+j,1)={findpath(path,sb,db)};
    end
end
m=cell2table(mypath);
writetable(m,'node.xlsx')

function [dist,mypath]=myfloyd(a)
% 输入：a—邻接矩阵，元素(aij)是顶点i到j之间的直达距离，可以是有向的
% sb—起点的标号；db—终点的标号
% 输出：dist—最短路的距离；% mypath—最短路的路径
n=size(a,1); path=zeros(n);
for k=1:n
    for i=1:n
        for j=1:n
            if a(i,j)>a(i,k)+a(k,j)
                a(i,j)=a(i,k)+a(k,j);
                path(i,j)=k;
            end
        end
    end
end
dist=a;
mypath=path;
end

function mypath=findpath(path,sb,db)
parent=path(sb,:); %从起点sb到终点db的最短路上各顶点的前驱顶点
parent(parent==0)=sb; %path中的分量为0，表示该顶点的前驱是起点
mypath=db; t=db;
while t~=sb
        p=parent(t); mypath=[p,mypath];
        t=p;
end
end