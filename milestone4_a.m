%   Jimmy Cook
%   Milestone 4 part A
%   4/06/22

[y, Fs] = audioread('IQ.wav'); % reads IQ data from file
%Creates the IQ complex vectors from the read IQ data
for k = 1:length(y)
    IQ(k) = y(k, 1) + i*y(k, 2);
end
%Calculates the welch's power spectral density estimate (unfiltered)(should be centered
%around 0
[Pxx, W] = pwelch(IQ);
%Plots the welch's power spectral density estimate
%semilogy(W, Pxx);
%Sets up a 5th order butterworth filter
[B, a] = butter(5, 40000/(Fs/2));
%Filters the IQ data
IQfilt = filtfilt(B, a, IQ);
%Calculates the welch's power spectral density estimate for filtered IQ
%data
%[Pxx, W] = pwelch(IQfilt);
%Plots the welch's power spectral density estimate for filtered IQ data
%semilogy(W, Pxx); 
%Plots the filtered IQ data
%plot(IQfilt);
%29 is the start of the first recorded bit. There are 250 samples/bit due
%to 9.6Kbps data rate and 2.4MHz sample frequency, so add half of 250 to
%sample the middle of the bit
%Calculate the angle finite differences
finalAngle = diff(unwrap(angle(IQfilt)));
%sample the angle every 250 samples due to 9.6Kbps data rate and 2.4MHz
%sample rate
sampledAngle = finalAngle(179:250:length(finalAngle));
%Determine digital data based on
for k = 1:length(sampledAngle)
    if sampledAngle(k) > 0
        finalData(k) = 1;
    else
        finalData(k) = 0;
    end
end
