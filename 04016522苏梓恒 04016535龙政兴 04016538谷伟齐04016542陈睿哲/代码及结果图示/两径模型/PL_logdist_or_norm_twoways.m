function PL=PL_logdist_or_norm1(ht,hr,d,d0,n,sigma)
%��������������Ӱ˥��·����ĵ�����ģ��
%����
%    ht���������ߵ���Ч�߶�
%    hr���������ߵ���Ч�߶�
%    d��������ͽ��ջ�֮��ľ���[m]
%    d0���ο�����[m]
%    n��·�����ָ��
%    sigma������[dB]
%���
%    PL��·�����[dB]
PL=-20*log10((ht*hr)./(d.*d))+10*n*log10(d/d0);%ʽ(1.4)
if nargin>5
    PL=PL+sigma*randn(size(d));%ʽ(1.5)
end