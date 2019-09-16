%M为节点关联矩阵    removal_line表示断开的线路编号    br_code表示待求分布系数的节点编号集合
%用于计算线路断开后指定线路集合的线路开端分布系数
function [D1] = LTDF(M,removal_line,slackbus,br_code,Z,mpc)
M2 = M;%%计算相关支路的开断分布系数
M2(slackbus,:) = [];
x = max(size(br_code));
D1 = zeros(x,4);%1 支路编号   2支路首节点   3支路尾节点  4支路开端分布系数
Ml = M2(:,removal_line);
ss = Z*Ml;
for i = 1:x
    k = br_code(i);
    Mk = M2(:,k);
    Xk_l = Mk'*ss;
    Xl_l = Ml'*ss;
    Dk_l = (Xk_l/mpc.branch(k,4))/(1-Xl_l/mpc.branch(removal_line,4));
    D1(i,1) = k;
    D1(i,2) = mpc.branch(k,1);
    D1(i,3) = mpc.branch(k,2);
    D1(i,4) = Dk_l;
end