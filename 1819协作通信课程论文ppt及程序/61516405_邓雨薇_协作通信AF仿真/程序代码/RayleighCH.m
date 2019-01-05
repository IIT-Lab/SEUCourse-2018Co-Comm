%% function of the Rayleigh Fading Channel
%**************************************************************************
%�������а�Ȩ������ʹ�÷��������뱣��ԭ����ϢCopyleft
%Author: 11/06/2010 Davy
%2010.06.11 �� Davy ���˺� yuema1086 ������ www.CSDN.com
%**************************************************************************
%==========================================================================
% Description: 
% Usage:  H = RayleighCH(sigma)
% Inputs:
%         sigma2: variance(��^2)
% Outputs:
%         H: 1��n Fading coefficient matrix 
% =========================================================================
function H = RayleighCH(sigma2)

mu = 0;	% average value(0)
sigma = sqrt(sigma2); % Standard deviation(��)
H = normrnd(mu,sigma)+j*normrnd(mu,sigma);	
% normrnd�ĸ�ʽ��:normrnd(MU,SIGNA,m,n),��������ΪMU,SIGMA����̬�ֲ������

%% ++++++++++++++++++++++++ Another Method ++++++++++++++++++++++++
% another method (n: bit number)
% function H = RayleighCH(n)
% H = randn(1,n)+j*randn(1,n);
% randn()������ֵΪ0������ ��^2 = 1����׼��� = 1����̬�ֲ�������������ĺ���
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++