clear
clc
mpc = case39;
removal_line = 10;
K = 2;
[theta,Pb,M,Z,slackbus] = DCpowerflow(mpc);
Pbs = [Pb,mpc.branch(:,1:2)];
[temp_br_code1,distance,path] = path_search(mpc,removal_line,K);
temp_D1 = LTDF(M,removal_line,slackbus,temp_br_code1,Z,mpc);
x = max(size(temp_br_code1));
Pmax = zeros(x,1);
delta_P = zeros(x,2);
for i =1:x
    m = temp_D1(i,1);
    Pmax(i,1) = mpc.branch(m,6);
    delta_P(i,1) = m;
    if Pb(m)>0
        delta_P(i,2) = abs(mpc.branch(m,6) - Pb(m));
    else
        delta_P(i,2) = abs(-mpc.branch(m,6) - Pb(m));
    end
end
ss1 = delta_P(:,2)./temp_D1(:,4);
xx1 = ss1./1200;
ss2 = [ss1,temp_D1(:,1:3),xx1];

mpc.branch(removal_line,:)=[];
[thet1a,Pb1,M1,Z1,slackbus1] = DCpowerflow(mpc);
mov_code = removal_line;
Pbb = Pb1;
temp_P = Pbb(mov_code:end);
Pbb(mov_code) = 0;
Pbb(mov_code+1:end) = [];
Pbb = [Pbb;temp_P]; 
Pbs = [Pbs,Pbb];
PPC = zeros(x,3);
for i = 1:x
    mc = temp_br_code1(i);
    PPC(i,1) = mc;
    PPC(i,2) = Pbb(mc);
    PPC(i,3) = abs(Pbb(mc)/Pmax(i,1));
end
ss2 = [ss2,Pmax,PPC];