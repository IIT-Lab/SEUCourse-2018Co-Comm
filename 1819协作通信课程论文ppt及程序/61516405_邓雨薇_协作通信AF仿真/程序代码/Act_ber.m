%% function of the BER
%**************************************************************************
%�������а�Ȩ������ʹ�÷��������뱣��ԭ����ϢCopyleft
%Author: 11/06/2010 Davy
%2010.06.11 �� Davy ���˺� yuema1086 ������ www.CSDN.com
%**************************************************************************
%==========================================================================
% Description: Obtain the actual BER
% Usage:  number_of_errbits = Ber(x,y)
% Inputs:
%         signal_x: The right signals, is used to refer to
%         signal_y: signal which needs to be calculated error rate
% Outputs:
%         number_of_errbits: number of errbits of the signal "signal_y"
% =========================================================================
function number_of_errbits = Act_ber(signal_x,signal_y)

[number,ratio] = biterr(signal_x,signal_y);
number_of_errbits = number;