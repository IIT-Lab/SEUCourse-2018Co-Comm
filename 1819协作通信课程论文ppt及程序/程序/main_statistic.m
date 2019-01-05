%��main�������������Ի�����Эͬ����
tic
nr_of_iterations=1000; %ѭ������
SNR=[-13:2.5:12];%dB��ʽ
use_direct_link=1;%ֱ�Ӵ���
use_relay=1;%ͨ����鴫��

global statistic;
%statistic = generate_statistic_structure;

global signal;%�����źŵ�ȫ�ֱ���
signal=generate_signal_structure;%�����źŽṹ�壬��������������������ַ�����ÿ���ַ������ı��������źŵĵ��Ʒ�ʽ�������źŵı������С�
                                 %�����źŵ��ַ�����,������Ϻ���յ��ı�������,������������.
signal(1).modulation_type='QPSK'
signal.nr_of_bits=2^5;
signal.position_x=-1;
siganl.position_y=0;
calculate_signal_parameter;%�����ź�׼�����

channel=generate_channel_structure;
channel(1).attenuation(1).pattern='Rayleigh';
channel.attenuation(1).block_length=1;
channel(2)=channel(1);
channel(3)=channel(1);
channel(1).attenuation.distance=1;
channel(2).attenuation.distance=1;
channel(3).attenuation.distance=1;

rx=generate_rx_structure;
rx(1).combining_type='ESNRC';
rx.rx_position_x=1;
rx.rx_position_y=0;
rx.sd_weight=3;

global relay;
relay=generate_relay_structure;
relay(1).mode='DAF';       
relay.magic_genie=1;
relay.rx=rx;
h = waitbar(0,'Please wait...');
BER=zeros(size(SNR));
for iSNR=1:size(SNR,2)
    waitbar(iSNR/size(SNR,2));
    channel(1).noise(1).SNR=SNR(iSNR);
    channel(2).noise(1).SNR=SNR(iSNR);
    channel(3).noise(1).SNR=SNR(iSNR);  
    for it=1:nr_of_iterations
        %Reset receiver
        rx=rx_reset(rx);
        relay.rx=rx_reset(relay.rx);
        
        %direct link
        if(use_direct_link==1)
        [channel(1),rx]=add_channel_effect(channel(1),rx,signal.symbol_sequence);
        rx=rx_correct_phaseshift(rx,channel(1).attenuation.phi);
        end
        
        
        %Multi-hop
        if (use_relay==1)
            %sender to relay
            [channel(2),relay.rx]=add_channel_effect(channel(2),relay.rx,signal.symbol_sequence);
            relay=prepare_relay2send(relay,channel(2));
            %relay to destination
            [channel(3),rx]=add_channel_effect(channel(3),rx,relay.signal2send);
            switch relay.mode
                case 'AAF'
                    rx=rx_correct_phaseshift(rx,channel(2).attenuation.phi+channel(3).attenuation.phi);
                case 'DAF'
                    rx=rx_correct_phaseshift(rx,channel(3).attenuation.phi);
                otherwise
                    error(['Relay-mode unknown:',relay.mode]);
            end
        end
        %receiver
        [received_symbol,signal.received_bit_sequence]=rx_combine(rx,channel,use_relay);
        
        BER(iSNR)=BER(iSNR)+sum(not(signal.received_bit_sequence==signal.bit_sequence));
    end%end of iteration
    
    BER(iSNR)=BER(iSNR)./it./signal.nr_of_bits;
     %����������ͬ�����ߵ�����ber 
    SNR_avg(iSNR)=10^(SNR(iSNR)/10);
    theo_ber(iSNR)=ber_2_sender(SNR_avg(iSNR),signal.modulation_type);
    %����ֻ�е���·������ber
    single_link_theo_ber(iSNR)=ber(2*SNR_avg(iSNR),'QPSK','Rayleigh');
end; 
close(h);
%����ʵ�ʺ�����������ͼ
%figure,
%semilogy(SNR+3,BER,'b->',3+SNR,theo_ber,'k-',3+SNR,single_link_theo_ber,'b-');
%legend('Combining type FRC:2:1 QPSK Rayleign','theory 2sender','theory single link');
%xlabel('Eb/No (dB)');
%ylabel('BER');
%grid on;
%hold on;
% ------------------------------------
% Present the result of the simulation
txt_distance = [' - distance: ',...
num2str(channel(1).attenuation.distance), ':',...
num2str(channel(2).attenuation.distance), ':',...
num2str(channel(3).attenuation.distance)];
txt_distance='';
if (use_relay == 1)
      if (relay.magic_genie == 1)
          txt_genie = ' - Magic Genie';
      else
          txt_genie = '';
      end
     txt_combining = [' - combining: ', rx(1).combining_type];
     switch rx(1).combining_type
        case 'FRC'
             txt_combining = [txt_combining, ' ',...
              num2str(rx(1).sd_weight),':1'];
     end
     add2statistic(3+SNR,BER,[signal.modulation_type, ' - ',...
     relay.mode, txt_combining, txt_distance, txt_genie])
else
    switch channel(1).attenuation.pattern
        case 'no'
            txt_fading = ' - no fading';
        otherwise
            txt_fading = ' - Rayleigh fading';
    end
    add2statistic(3+SNR,BER,[signal.modulation_type,txt_fading]);
end
% % -----------------
% % Graphs to compare
SNR_linear = 10.^(SNR/10);
%add2statistic(SNR+3,single_link_theo_ber,'BPSK - single link transmiss')
%add2statistic(SNR+3,theo_ber,'QPSK - 2 senders')
show_statistic;
toc












