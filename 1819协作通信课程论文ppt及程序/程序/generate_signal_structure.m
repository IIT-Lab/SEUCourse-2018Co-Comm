function [signal_structure]=generate_signal_structure();
%������ʾ�����źŵĽṹ��

signal_structure=struct(...
'nr_of_bits',{},...        %����ı�����
'nr_of_symbols',{},...     %������ַ���
'bits_per_symbol',{},...   %ÿ���ַ������ı�����Qpsk(2bit/symbol),Bpsk(1bit/symbol)
'modulation_type',{},...   %���Ʒ�ʽ 'Qpsk'��'Bpsk'
'bit_sequence',{},...      %�źŵı�������
'symbol_seguence',{},...   %�źŵ��ַ�����
'received_bit_sequence',{},...%������Ϻ�ı�������
'position_x',{},...%�ź�Դ������λ�õĺ�����
'position_y',{});%�ź�Դ������λ�õ�������