function [symbol_sequence]=bit2symbol(bit_sequence);
%��bit����symbol���е�ת��
global signal;

switch signal.modulation_type
    case 'BPSK'
        symbol_sequence=bit_sequence;
    case 'QPSK'
        symbol_sequence=bit_sequence(1:signal.nr_of_symbols)+j*bit_sequence(signal.nr_of_symbols+1:signal.nr_of_bits);%���Ǻ�����
    otherwise
        error(['Modulation type unknown:',signal.modulation_type])
end

