function PathLost = PathLoss_free(fc,distance)
%���ɿռ�·�����ģ��
%����
%    fc���ز�Ƶ��[Hz]
%    distance����վ���ƶ�̨֮��ľ���[m]

%���
%    PL��·�����[dB]
lamda=3e8/fc;
tmp=lamda./(4*pi*distance);
PathLost=-20*log10(tmp);%ʽ(1.2)/(1.3)