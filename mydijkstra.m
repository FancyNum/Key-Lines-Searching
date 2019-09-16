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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ѱ��i,j�������·��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���룺a���ڽӾ���a��i��j)��ָi��j֮��ľ��룬�����������
% sb�����ı��, db���յ�ı��
% �����mydistance�����·�ľ���, mypath�����·��·��
n=size(a,1);
visited(1:n) = 0;
distance(1:n) = inf; 
distance(sb) = 0; %��㵽���������ĳ�ʼ��
visited(sb)=1; 
u=sb;  %uΪ���µ�P��Ŷ���
parent(1:n) = 0; %ǰ������ĳ�ʼ��
for i = 1: n-1
     id=find(visited==0); %����δ��ŵĶ���
     for v = id           
         if  a(u, v) + distance(u) < distance(v)
             distance(v) = distance(u) + a(u, v);  %�޸ı��ֵ 
             parent(v) = u;                                    
         end            
     end
     temp=distance;
     temp(visited==1)=inf;  %�ѱ�ŵ�ľ��뻻������
     [~, u] = min(temp);  %�ұ��ֵ��С�Ķ��� 
     visited(u) = 1;       %����Ѿ���ŵĶ���
 end
mypath = [];
if parent(db) ~= 0   %�������·!
    t = db;
    mypath = [db];
    while t ~= sb
        p = parent(t);
        mypath = [p mypath];
        t = p;      
    end
end
mydistance = distance(db);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����������Ѱ�ұ������е�����·��%%%%%%%%%%%%%%%%%%%%%%%%%%
% %function [d,index1]=mydijkstra2(a,sb);
% % ���룺a���ڽӾ���a��i��j)��ָi��j֮��ľ��룬�����������
% % sb�����ı��
% % �����d������㿪ʼ�������б�ŵ����·����, index1������㿪ʼ�������б�ŵ����··��
% %pb�������P�����Ϣ index1Ϊ��Ŷ���˳�� index2��Ŷ�������
% a(a==0)=inf;
% pb(1:length(a))=0;
% pb(sb)=1;
% index1=sb;
% index2=ones(1,length(a));
% d(1:length(a))=inf;d(sb)=0;%d����������ͨ·��ֵ
% temp=sb;%���µ�P��ŵ����
% while sum(pb)<length(a)
%     tb=find(pb==0);
%     d(tb)=min(d(tb),d(temp)+a(temp,tb));
%     tmpb=find(d(tb)==min(d(tb)));
%     temp=tb(tmpb(1));%�����ж����ͬʱ�ﵽ��Сֵ��ֻȡ����һ��
%     pb(temp)=1;
%     index1=[index1,temp];
%     temp2=find(d(index1)==d(temp)-a(temp,index1));
%     index2(temp)=index1(temp2(1));
% end