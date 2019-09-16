%  clear
%  clc
% a = [0 50 Inf 40 25 10;
%     50 0 15 20 Inf 25;
%     Inf 15 0 10 20 Inf;
%     40 20 10 0 10 25;
%     25 Inf 20 10 0 55;
%     10 25 Inf 25 55 0];
% sb = 1;
% db = 3;
 function [mydistance,mypath]=mydijkstra(a,sb,db)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%寻找i,j两点最短路径%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 输入：a—邻接矩阵，a（i，j)是指i到j之间的距离，可以是有向的
% sb—起点的标号, db—终点的标号
% 输出：mydistance—最短路的距离, mypath—最短路的路径
n=size(a,1);
visited(1:n) = 0;
distance(1:n) = inf; 
distance(sb) = 0; %起点到各顶点距离的初始化
visited(sb)=1; 
u=sb;  %u为最新的P标号顶点
parent(1:n) = 0; %前驱顶点的初始化
for i = 1: n-1
     id=find(visited==0); %查找未标号的顶点
     for v = id           
         if  a(u, v) + distance(u) < distance(v)
             distance(v) = distance(u) + a(u, v);  %修改标号值 
             parent(v) = u;                                    
         end            
     end
     temp=distance;
     temp(visited==1)=inf;  %已标号点的距离换成无穷
     [~, u] = min(temp);  %找标号值最小的顶点 
     visited(u) = 1;       %标记已经标号的顶点
 end
mypath = [];
if parent(db) ~= 0   %如果存在路!
    t = db;
    mypath = [db];
    while t ~= sb
        p = parent(t);
        mypath = [p mypath];
        t = p;      
    end
end
mydistance = distance(db);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%从起点出发，寻找遍历所有点的最短路径%%%%%%%%%%%%%%%%%%%%%%%%%%
% %function [d,index1]=mydijkstra2(a,sb);
% % 输入：a—邻接矩阵，a（i，j)是指i到j之间的距离，可以是有向的
% % sb—起点的标号
% % 输出：d—从起点开始便利所有标号的最短路距离, index1—从起点开始便利所有标号的最短路路径
% %pb用来存放P标号信息 index1为标号顶点顺序 index2标号顶点索引
% a(a==0)=inf;
% pb(1:length(a))=0;
% pb(sb)=1;
% index1=sb;
% index2=ones(1,length(a));
% d(1:length(a))=inf;d(sb)=0;%d用来存放最短通路的值
% temp=sb;%最新的P标号的起点
% while sum(pb)<length(a)
%     tb=find(pb==0);
%     d(tb)=min(d(tb),d(temp)+a(temp,tb));
%     tmpb=find(d(tb)==min(d(tb)));
%     temp=tb(tmpb(1));%可能有多个点同时达到最小值，只取其中一个
%     pb(temp)=1;
%     index1=[index1,temp];
%     temp2=find(d(index1)==d(temp)-a(temp,index1));
%     index2(temp)=index1(temp2(1));
% end