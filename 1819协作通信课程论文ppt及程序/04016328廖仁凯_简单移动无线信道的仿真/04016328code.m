%��Ƶ��ѡ������˥���ŵ�
test1 = randn(1000,1);
delay=[0 1e-5 ];     %����ʱ��
Ts=1e-5;
db=[0 -30];          %����˥��
fd=1;                %������Ƶ��С
RLchannel=rayleighchan(Ts,fd,delay,db);
RLchannel.StorePathGains=1;
RLchannel.StoreHistory=1;
r=filter(RLchannel,test1);
plot(RLchannel);

%��Ƶ��ѡ���Կ�˥���ŵ�
test1 = randn(1000,1);
delay=[0 1e-5 ];     %����ʱ��
Ts=1e-5;
db=[0 -30];          %����˥��
fd=200;                %������Ƶ�ƴ�
RLchannel=rayleighchan(Ts,fd,delay,db);
RLchannel.StorePathGains=1;
RLchannel.StoreHistory=1;
r=filter(RLchannel,test1);
plot(RLchannel);

%Ƶ��ѡ������˥���ŵ�
test1 = randn(1000,1);
delay=[0 1e-5 2e-5];     %����ʱ��
Ts=1e-5;
db=[0 -5 -10];          %����˥��
fd=1;                %������Ƶ��С
RLchannel=rayleighchan(Ts,fd,delay,db);
RLchannel.StorePathGains=1;
RLchannel.StoreHistory=1;
r=filter(RLchannel,test1);
plot(RLchannel);

%Ƶ��ѡ���Կ�˥���ŵ�
test1 = randn(1000,1);
delay=[0 1e-5 2e-5];     %����ʱ��
Ts=1e-5;
db=[0 -5 -10];          %����˥��
fd=200;                %������Ƶ�ƴ�
RLchannel=rayleighchan(Ts,fd,delay,db);
RLchannel.StorePathGains=1;
RLchannel.StoreHistory=1;
r=filter(RLchannel,test1);
plot(RLchannel);