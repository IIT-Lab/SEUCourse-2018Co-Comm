%������ͬ������(���ն˵�����ϲ�)��ʵ���������ߺ��������ߵıȽ�,���뵥��·�ıȽϣ�����ͬ������ÿ��
%�Ĺ���Ϊp������·�����ߵĹ���Ϊ2p
tic
nr_of_iterations=100; %ѭ������
SNR=[-13:2.5:12];%dB��ʽ
global signal;%�����źŵ�ȫ�ֱ���
signal=generate_signal_structure;%�����źŽṹ�壬��������������������ַ�����ÿ���ַ������ı��������źŵĵ��Ʒ�ʽ�������źŵı������С�
                                 %�����źŵ��ַ�����,������Ϻ���յ��ı�������,������������.
signal(1).modulation_type='QPSK'
signal.nr_of_bits=2^5;
calculate_signal_parameter;%�����ź�׼�����

channel=generate_channel_structure;
channel(1).attenuation(1).pattern='Rayleigh';
channel.attenuation(1).block_length=1;
channel(2)=channel(1);
channel(3)=channel(1);
channel(1).attenuation.distance=1;
channel(2).attenuation.distance=1;
channel(3).attenuation.distance=1;%for single link

rx=generate_rx_structure;
rx(1).combining_type='FRC';
rx.sd_weight=1;
rx(2)=rx(1);

h = waitbar(0,'Please wait...');
BER_2sender=zeros(size(SNR));
BER_1sender=zeros(size(SNR));
for iSNR=1:size(SNR,2)
    waitbar(iSNR/size(SNR,2));
    channel(1).noise(1).SNR=SNR(iSNR);
    channel(2).noise(1).SNR=SNR(iSNR);
    channel(3).noise(1).SNR=3+SNR(iSNR);
     for it=1:nr_of_iterations
          rx(1)=rx_reset(rx(1));
          [channel(1),rx(1)]=add_channel_effect(channel(1),rx(1),signal.symbol_sequence);
          rx(1)=rx_correct_phaseshift(rx(1),channel(1).attenuation.phi);
          [channel(2),rx(1)]=add_channel_effect(channel(2),rx(1),signal.symbol_sequence);
          rx(1)=rx_correct_phaseshift(rx(1),channel(2).attenuation.phi);
          rx(2)=rx_reset(rx(2));
          [channel(3),rx(2)]=add_channel_effect(channel(3),rx(2),signal.symbol_sequence);
          rx(2)=rx_correct_phaseshift(rx(2),channel(3).attenuation.phi);
          %���ն�
          %%%%%%%%%%%%%%%%%%������ͬ�������Ͷ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          [received_symbol,signal.received_bit_sequence]=rx_combine(rx(1),channel,1); 
          BER_2sender(iSNR)=BER_2sender(iSNR)+sum(not(signal.received_bit_sequence==signal.bit_sequence));
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
          %%%%%%%%%%%%%%%%%%%����·%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          [received_single_symbol,single_received_bit_sequence]=rx_combine(rx(2),channel,0);
          BER_1sender(iSNR)=BER_1sender(iSNR)+sum(not(single_received_bit_sequence==signal.bit_sequence));
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      end%end of iteration
   BER_2sender(iSNR)=BER_2sender(iSNR)./it./signal.nr_of_bits;
   BER_1sender(iSNR)=BER_1sender(iSNR)./it./signal.nr_of_bits;
    %����������ͬ�����ߵ�����ber 
    SNR_avg(iSNR)=10^(SNR(iSNR)/10);
    theo_ber(iSNR)=ber_2_sender(SNR_avg(iSNR),signal.modulation_type);
    single_link_theo_ber(iSNR)=ber(2*SNR_avg(iSNR),'QPSK','Rayleigh');
end
close(h);
%����ʵ�ʺ�����������ͼ
figure,semilogy(3+SNR,BER_2sender,'r-o',3+SNR,theo_ber,'k-',3+SNR,BER_1sender,'g-^',3+SNR,single_link_theo_ber,'b-')
legend('simulation 2sender','theory 2sender','simulation 1sender','theory single link');
xlabel('Eb/No (dB)');
ylabel('BER');
grid on;
hold on;



          
          
          
          
          
          
          
          