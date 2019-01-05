function calculate_signal_parameter
%���������źŲ���

global signal;%ȫ�ֱ���signal,��������������,��һ��signal_structure���͵ı���

%����ÿ�������������ı�����
switch signal.modulation_type
    case 'BPSK'
        signal.bits_per_symbol=1;%ÿ���ַ��ı�����
    case 'QPSK'
        signal.bits_per_symbol=2;
        if (signal.nr_of_bits/2~=ceil(signal.nr_of_bits/2))%ceil����������ȡ��
            error(['Using QPSK,number of bits must be a mutiple of 2'])
        end
    otherwise
        error(['Modulation type unknown:',signal.modulation_type])
end

%����Ҫ����ı��ظ�������Ҫ����ķ��Ÿ���
signal.nr_of_symbols=signal.nr_of_bits/signal.bits_per_symbol;

%bit����
signal.bit_sequence=floor(rand(1,signal.nr_of_bits)*2)*2-1;%floor����������ȡ��

%symbol����
signal.symbol_sequence=bit2symbol(signal.bit_sequence);



