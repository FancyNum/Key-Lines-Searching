%MΪ�ڵ��������    removal_line��ʾ�Ͽ�����·���    br_code��ʾ����ֲ�ϵ���Ľڵ��ż���
%���ڼ�����·�Ͽ���ָ����·���ϵ���·���˷ֲ�ϵ��
function [D1] = LTDF(M,removal_line,slackbus,br_code,Z,mpc)
M2 = M;%%�������֧·�Ŀ��Ϸֲ�ϵ��
M2(slackbus,:) = [];
x = max(size(br_code));
D1 = zeros(x,4);%1 ֧·���   2֧·�׽ڵ�   3֧·β�ڵ�  4֧·���˷ֲ�ϵ��
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