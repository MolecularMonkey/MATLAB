function width = fwhm(x,y)
% function width = fwhm(x,y)
%
% Full-Width at Half-Maximum (FWHM) of the waveform y(x)
% and its polarity.
% The FWHM result in 'width' will be in units of 'x'
%% Added by nima
n=1;
while isnan(y(n))
    y(n)=y(n+1);
    n=n+1;
end
n=1;
while isnan(y(end))
    y(end)=y(end-n);
    n=n+1;
end

%% original code by author
% Rev 1.2, April 2006 (Patrick Egan)
y = y ./ max(y);
N = length(y);
lev50 = 0.5;
if y(1) < lev50                  % find index of center (max or min) of pulse
    [~,centerindex]=max(y);
    Pol = +1;
    % disp('Pulse Polarity = Positive') %disabled by NS
else
    [~,centerindex]=min(y);
    Pol = -1;
    %disp('Pulse Polarity = Negative')  %disabled by NS
end
i=3;

while sign(y(i)-lev50) == sign(y(i-1)-lev50)
    i = i+1;
end                                   %first crossing is between v(i-1) & v(i)
interp = (lev50-y(i-1)) / (y(i)-y(i-1));
tlead = x(i-1) + interp*(x(i)-x(i-1));
i = centerindex+1;                    %start search for next crossing at center
while ((sign(y(i)-lev50) == sign(y(i-1)-lev50)) && (i <= N-1))
    i = i+1;
end
if i ~= N
    Ptype = 1;  
    %disp('Pulse is Impulse or Rectangular with 2 edges') %disabled by NS
    interp = (lev50-y(i-1)) / (y(i)-y(i-1));
    ttrail = x(i-1) + interp*(x(i)-x(i-1));
    width = ttrail - tlead;
else
    Ptype = 2; 
    disp('Step-Like Pulse, no second edge')
    ttrail = NaN;
    width = NaN;
end
