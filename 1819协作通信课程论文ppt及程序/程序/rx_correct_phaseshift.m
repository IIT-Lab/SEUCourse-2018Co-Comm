function [rx]=rx_correct_phaseshift(rx,phi);
%��������
switch rx.combining_type
    case 'MRC'%���յ���ԭʼ�ź�,����Ҫ��������,��������������źźϲ�ʱ�ͽ�����
        rx.signal2analyse=[rx.signal2analyse;rx.received_signal];
    otherwise
        rx.signal2analyse=[rx.signal2analyse;rx.received_signal.*exp(j*phi)];
end

