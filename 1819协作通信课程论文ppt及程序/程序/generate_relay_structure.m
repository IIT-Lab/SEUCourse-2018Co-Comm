function [relay_structure]=generate_relay_structure();
%Ϊrelay�����ṹ��

rx_structure=generate_rx_structure;

relay_structure=struct(...
'mode',{},...                %'AAF','DAF'
'magic_genie',{},...         %'Magic Genie'
'amplification',{},...       %AAFģʽ��ʹ��
'symbol_sequence',{},...     %DAFģʽ��ʹ��
'signal2send',{},...         %Ҫת�����ź�
'rx',rx_structure);   %relay�Ľ��ղ���