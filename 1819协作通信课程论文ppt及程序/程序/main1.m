%��main�������������Ի�����Эͬ����
tic
nr_of_iterations=1000; %ѭ������
SNR=[-10:2.5:15];%dB��ʽ
use_direct_link=1;%ֱ�Ӵ���
use_relay=1;%ͨ����鴫��
P=2;%�ܹ���Ϊ2


global signal;%�����źŵ�ȫ�ֱ���
signal=generate_signal_structure;%�����źŽṹ�壬��������������������ַ�����ÿ���ַ������ı��������źŵĵ��Ʒ�ʽ�������źŵı������С�
                                 %�����źŵ��ַ�����,������Ϻ���յ��ı�������,������������.
signal(1).modulation_type='QPSK';%�źŵ�������
signal.nr_of_bits=2^10;%���������
signal.position_x=-1;%�ź�Դ����λ�ú�����
signal.position_y=0;%�ź�Դ����λ��������
calculate_signal_parameter;%�����ź�׼�����

channel=generate_channel_structure;
channel(1).attenuation(1).pattern='Rayleigh'; %'no','Rayleigh'
channel.attenuation(1).block_length=1;%�鳤(bit/block)
channel(2)=channel(1);
channel(3)=channel(1);%���ŵ�ģʽ��ͬ
channel(1).attenuation.distance=1; %�źŴ������
channel(2).attenuation.distance=0.75;
channel(3).attenuation.distance=0.25;

rx=generate_rx_structure;%Ϊ���ղ��������ṹ��
rx(1).combining_type='ESNRC';%'ERC','FRC','SNRC','ESNRC','MRC'�ϲ�����
rx.rx_position_x=1;
rx.rx_position_y=0;%λ��
rx.sd_weight=2;%��ȨֵΪ2
rx(2)=rx(1);%����û��Эͬ����µĽ���


global relay;
relay=generate_relay_structure;%Ϊrelay�����ṹ��
relay(1).mode='AAF';       
relay.magic_genie=0;
relay.rx=rx(1); %relay�Ľ��ղ���Ϊrx��1��
h = waitbar(0,'Please wait...');%�򿪻���µȴ����Ի���
BER=zeros(size(SNR));%���س�����ʳ�ʼ��
BER_1sender=zeros(size(SNR));
for iSNR=1:size(SNR,2)
    waitbar(iSNR/size(SNR,2));
    channel(1).noise(1).SNR=SNR(iSNR);
    channel(2).noise(1).SNR=SNR(iSNR);
    channel(3).noise(1).SNR=SNR(iSNR); %���ɲ�ͬ����ȵ�channel 
    for it=1:nr_of_iterations
        %Reset receiver
        rx(1)=rx_reset(rx(1));%ÿ��ѭ����ʼ����rx��1����0
        rx(2)=rx_reset(rx(2));%�����Эͬ���
        relay.rx=rx_reset(relay.rx);
        
        [channel(1)]=get_channel_muti_parameter(channel(1),signal.symbol_sequence,1);%����ŵ���������
        [noise_vector_sd,channel(1),asd]=get_channel_white_noise(channel(1),signal.symbol_sequence);%����ŵ����Ը�˹�����������ҵõ���aֵ�������й��ʷ���
        
        [channel(2)]=get_channel_muti_parameter(channel(2),signal.symbol_sequence,1);
        [noise_vector_sr,channel(2),asr]=get_channel_white_noise(channel(2),signal.symbol_sequence);
        
        [channel(3)]=get_channel_muti_parameter(channel(3),signal.symbol_sequence,1);
        [noise_vector_rd,channel(3),ard]=get_channel_white_noise(channel(3),signal.symbol_sequence);
        
        %���ʷ���
        [Ps,Pr]=power_allocate(P,asd,asr,ard,'FRC','Best','AAF',rx(1).sd_weight);
        
        %direct link
        if(use_direct_link==1)
        [rx(1)]=add_PA_and_channel_effect(channel(1),signal.symbol_sequence,rx(1),Ps,noise_vector_sd);
        rx(1)=rx_correct_phaseshift(rx(1),channel(1).attenuation.phi);
        end
        
        
        %Multi-hop
        if (use_relay==1)
            %sender to relay
            [relay.rx]=add_PA_and_channel_effect(channel(2),signal.symbol_sequence,relay.rx,Ps,noise_vector_sr);%ps
            relay=prepare_relay2send(relay,channel(2),Ps,Pr);%relay�����źţ�Ϊת����׼��
            %relay to destination ת��
            [rx(1)]=add_PA_and_channel_effect(channel(3),relay.signal2send,rx(1),Pr,noise_vector_rd);%pr
            switch relay.mode
                case 'AAF'
                    rx(1)=rx_correct_phaseshift(rx(1),channel(2).attenuation.phi+channel(3).attenuation.phi);
                case 'DAF'
                    rx(1)=rx_correct_phaseshift(rx(1),channel(3).attenuation.phi);
                otherwise
                    error(['Relay-mode unknown:',relay.mode]);
            end
        end
      
        
        %receiver
        [received_symbol,signal.received_bit_sequence]=rx_combine(rx(1),channel,use_relay,Ps);
        
        BER(iSNR)=BER(iSNR)+sum(not(signal.received_bit_sequence==signal.bit_sequence));
        
        %��Эͬ�����ֻ��һ������·
        [rx(2)]=add_PA_and_channel_effect(channel(1),signal.symbol_sequence,rx(2),P,noise_vector_sd);
        rx(2)=rx_correct_phaseshift(rx(2),channel(1).attenuation.phi);
        [received_single_symbol,single_received_bit_sequence]=rx_combine(rx(2),channel,0,P);
        BER_1sender(iSNR)=BER_1sender(iSNR)+sum(not(single_received_bit_sequence==signal.bit_sequence));
    end%end of iteration
    
    BER(iSNR)=BER(iSNR)./it./signal.nr_of_bits; %�������㷨
    BER_1sender(iSNR)=BER_1sender(iSNR)./it./signal.nr_of_bits;
    %����ֻ�е���·������ber
    SNR_avg(iSNR)=10^(SNR(iSNR)/10);
    single_link_theo_ber(iSNR)=ber(SNR_avg(iSNR),'QPSK','Rayleigh');
end; 
close(h);
%����ʵ�ʺ�����������ͼ
%figure,
%semilogy(SNR,single_link_theo_ber,'g-^');
semilogy(SNR,BER,'r-+');
%semilogy(SNR,BER,'g-+',SNR,BER_1sender,'r->');%SNR,single_link_theo_ber,'k-');
legend('Combining type MRC QPSK Rayleign','Combining type EGC QPSK Rayleign','Combining type SC QPSK Rayleign');
xlabel('Eb/No (dB)');
ylabel('BER');
grid on;
hold on;












