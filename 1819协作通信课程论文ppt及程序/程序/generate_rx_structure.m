function [rx_structure]=generate_rx_structure();
%Ϊ���ղ��������ṹ��
rx_structure=struct(...
'combining_type',{},...%'ERC','FRC','SNRC','ESNRC','MRC'
'sd_weight',{},...%'FRC'��ʹ��,relay·��ȨֵΪ1
'received_signal',{},...%ԭʼ���յ�.���ź�
'signal2analyse',{});%���������о����ź�,ÿһ·���յ����ź�ռһ��

