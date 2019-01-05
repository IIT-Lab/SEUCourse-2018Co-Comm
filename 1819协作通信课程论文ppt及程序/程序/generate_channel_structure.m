function [channel_structure]=generate_channel_structure();
%�����ŵ��ṹ��
attenuation_structure=generate_attenuation_structure;
noise_structure=generate_noise_structure;

channel_structure=struct(...   %matlabһ��д����ʱ����ʡ�Ժſ�������һ�У����е�����
'attenuation',attenuation_structure,... %fading
'noise',noise_structure);            %noise

function [attenuation_structure]=generate_attenuation_structure();
%Ϊ˥���������һ���ṹ��
attenuation_structure=struct(...
'pattern',{},...     %'no','Rayleigh'
'distance',{},...    %�źŴ������
'd',{},...           %pass loss
'h',{},...           %attenuation �������Ⱥ���λ
'h_mag',{},...       %attenuation����
'phi',{},...         %����
'block_length',{});%�鳤(bit/block)

function [noise_structure]=generate_noise_structure();
%���������������Ľṹ��
noise_structure=struct(...
'SNR',{},...%�����
'sigma',{});%��˹�����ı�׼��


