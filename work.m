clear
%����һ������Ʒ��������ɣ���״̬��
trans_p = [0.6 0.4;
    0.3 0.7];
start_p = [0.6 0.4];

x = unifrnd (0,1);
if x < 0.6
    w(1) = 1;
else
    w(1) = 2;
end

for i = 2 : 20
    x = unifrnd (0,1);
    if w(i - 1) == 1
         if x < 0.6
             w(i) = 1;
         else
             w(i) = 2;
         end
    else
        if x < 0.3
             w(i) = 1;
         else
             w(i) = 2;
         end
    end
end

%plot(1:20,w,'*r')

%�����������Ʒ��������ɣ���״̬��
for i = 1 : 20
    x = unifrnd (0,1);
    if w(i) == 1
         if x < 0.6
             a(i) = 1;
         elseif  x > 0.9
             a(i) = 3;
         else
             a(i) = 2;
         end
    else
        if x < 0.1
             a(i) = 1;
         elseif  x > 0.5
             a(i) = 3;
         else
             a(i) = 2;
         end
    end
end
%plot(1:20,a,'*k')

%������Ʒ�ģ��
emit_p = [0.6 0.3 0.1;
    0.1 0.4 0.5];
%�������������췢���Ļ״̬�ֱ���1 2 3���������������������Ϊ1 2 2�ĸ��ʡ�
a1 = [1 2 3];
b1 = [1 2 2];
p1 = 0.6*0.6;
p2 = trans_p(b1(1),b1(2))*emit_p(b1(2),a1(2));
p3 = trans_p(b1(2),b1(3))*emit_p(b1(3),a1(3));
p = p1*p2*p3

%������֪��������ʮ�췢����״̬���Ʋ���20���������
obs = [2 1 3 2 3 2 2 3 3 1 2 1 1 1 2 3 3 3 3 2 ];
%obs = a;
k = 20;
states = [1 2];
newpath = zeros(2,k);
path = zeros(2,k);
V = zeros(20,2);%��¼����
for y = 1:2
    V(1,y) = start_p(y) * emit_p(y,obs(1));
    path(y,1) = y;
end
for  t = 2:k
    for y = 1:2
        prob = -1;
        for y0 = 1:2
            nprob = V(t - 1,y0) * trans_p(y0,y) * emit_p(y,obs(t));
            if nprob > prob
                prob = nprob;
                state = y0;
                % ��¼������
                V(t,y) = prob;
                % ��¼·��
                for i = 1 : t
                    newpath(y,i) = path(state,i);
                end
                newpath(y,t) = y;
            end
        end
    end
    path = newpath;
end

prob = -1;
state = 1;
for y = 1:2
    if V(obs(k),y) > prob
        prob = V(20,y);
        state = y;
    end
end
stateP = path(state,:)
for i = 1 : k
    x = unifrnd (0,1);
    if stateP(i) == 1
         if x < 0.6
             aa(i) = 1;
         elseif  x > 0.9
             aa(i) = 3;
         else
             aa(i) = 2;
         end
    else
        if x < 0.1
             aa(i) = 1;
         elseif  x > 0.5
             aa(i) = 3;
         else
             aa(i) = 2;
         end
    end
end


