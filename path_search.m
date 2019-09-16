% clear
% clc
% mpc = case14;
function [ini_branch,dist,path] = path_search(mpc,broken_line,K)
[L,~] = size(mpc.branch);
[N,~] = size(mpc.bus);
A = zeros(N);
for i = 1:L %加权邻接矩阵
    p = mpc.branch(i,1);q = mpc.branch(i,2);
    A(p,q) = mpc.branch(i,4);
    A(q,p) = A(p,q);
end
for i = 1:N
    for j = 1:N
        if A(i,j) == 0 && i~=j
            A(i,j) = inf;
        end
    end
end

% broken_line = 3;
B = A;
brk_p = mpc.branch(broken_line,1);brk_q = mpc.branch(broken_line,2);
B(brk_p,brk_q) = inf;
B(brk_q,brk_p) = inf;
% K = 2;
[dist,path] = kShortestPath(B,brk_p,brk_q,K);
% [dist,path] = mydijkstra(B,brk_p,brk_q);
% total_branch = cell(1,K);
mm1 = max(size(path));
for i = 1:mm1%找出对应的支路号
    path1 = path{i};
    n1 = max(size(path{i})) - 1;
    ini_branch1 = zeros(1,n1);
    for j = 1:n1
        p = path1(j);q = path1(j+1);
        for k = 1:L
            if(mpc.branch(k,1)==p && mpc.branch(k,2)==q)||(mpc.branch(k,1)==q&&mpc.branch(k,2)==p)
                ini_branch1(j) = k;
                break;
            end
        end
    end
    if i == 1
        ini_branch = ini_branch1;
    else
        ini_branch = union(ini_branch,ini_branch1);
    end
%     total_branch{i} = ini_branch1;
end


% n1 = max(size(path))-1;%最短路径上支路的数量
% ini_branch = zeros(K,n1);%初始支路的支路号
% for m = 1:n1
%     for i = 1:L
%         if (mpc.branch(i,1) == path(m) && mpc.branch(i,2) == path(m+1)) || (mpc.branch(i,1) == path(m+1) && mpc.branch(i,2) == path(m))
%              ini_branch(m) = i;
%              break;
%         end
%     end
% end
% [distf,pathf] = floyd(B,brk_p,brk_q);   部分结果有错误