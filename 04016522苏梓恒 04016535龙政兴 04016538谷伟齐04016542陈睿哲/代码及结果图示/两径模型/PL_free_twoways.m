function PL=PL_free1(ht,hr,dist,Gt,Gr)
%����ģ��
%����
%    ht���������ߵ���Ч�߶�
%    hr���������ߵ���Ч�߶�
%    dist��������ͽ��ջ�֮��ľ���[m]
%    Gt���������������
%    Gr�����ջ���������
%���
%    PL��·�����[dB]
tmp=(ht*hr)./(dist.*dist);
if nargin>2,tmp=tmp*sqrt(Gt);end % nargin_��������ĸ���
if nargin>3,tmp=tmp*sqrt(Gr);end
PL=-20*log10(tmp);%ʽ(1.2)/(1.3)