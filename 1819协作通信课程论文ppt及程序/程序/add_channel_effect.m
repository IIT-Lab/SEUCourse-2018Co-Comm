function [channel,rx,a,noise_vector]=add_channel_muti_effect(channel,rx,signal_sequence,P);
%�ŵ�Ӱ�캯��,�����ܹ��ҵ��ŵ���������������2���ı�ֵ���Ա�ִ�й��ʷ���

global signal;

%channel.attenuation.d=1/(channel.attenuation.distance^2);%pass loss is constant for the whole transmittion

%switch channel.attenuation.pattern
%   case 'no'  %no fading at all(only pass loss)
%        channel.attenuation.phi=zeros(size(signal_sequence));
%        channel.attenuation.h=ones(size(signal_sequence))*channel.attenuation.d;
 %       channel.attenuation.h_mag=channel.attenuation.h;   
   % case 'Rayleigh'%Rayleigh
    %    nr_of_blocks=ceil(size(signal_sequence,2)/channel.attenuation.block_length);
     %   h_block=(randn(nr_of_blocks,1)+j*randn(nr_of_blocks,1))*channel.attenuation.d;
      %  h=reshape((h_block*ones(1,channel.attenuation.block_length))',1,nr_of_blocks*channel.attenuation.block_length);
      %  channel.attenuation.h=h(1:(size(signal_sequence,2)));
       % [channel.attenuation.phi,channel.attenuation.h_mag]=cart2pol(real(channel.attenuation.h),imag(channel.attenuation.h));
       % channel.attenuation.phi=-channel.attenuation.phi;
    %otherwise
       % error(['Fading pattern unknown:',channel.attenuation.pattern])
%end

%�õ����Ը�˹������
if (size(signal_sequence,2)~=0)
    S=mean(abs(signal_sequence).^2);
else
    S=0;
end
SNR_linear=10^(channel.noise.SNR/10);
channel.noise.sigma=sqrt(P*S/(2*SNR_linear));
noise_vector=(randn(size(signal_sequence))+j*randn(size(signal_sequence)))*channel.noise.sigma;



%�ѳ��������������ź�,�õ������ź�
rx.received_signal=signal_sequence.*channel.attenuation.h;
a=channel.attenuation.h_mag.*channel.attenuation.h_mag/(2*channel.noise.sigma);%����Ϊ���ʷ�����


        
        
        
