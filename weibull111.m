function [fitresult, gof] = weibull1(num11, num12,num1)
%% 
[xData, yData] = prepareCurveData( num11, num12 );

% 
ft = fittype( 'weibull' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0];
% opts.StartPoint = [0.255095115459269 0.505957051665142];


[fitresult, gof] = fit( xData, yData, ft, opts );


% figure( 'Name', '1' );
% h = plot( fitresult, num1(1,:), num1(2,:) );
% legend( h, 'num12 vs. num11', '1', 'Location', 'NorthEast', 'Interpreter', 'none' );

% xlabel( 'num11', 'Interpreter', 'none' );
% ylabel( 'num12', 'Interpreter', 'none' );
% grid on


