function add2statistic(x,y,leg);
% ���ͼ
global statistic;
statistic.x = [statistic.x;x];
statistic.y = [statistic.y;y];
statistic.legend = strvcat(statistic.legend,leg);