function [signal_sequence]=power_control(Ps,signal_sequence);
%��һ���ķ��͹���Ps�����ź�
signal_sequence=signal_sequence*sqrt(Ps);
