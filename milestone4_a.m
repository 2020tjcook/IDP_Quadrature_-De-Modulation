%   Jimmy Cook
%   Milestone 4 part A
%   4/06/22

[y, Fs] = audioread('IQ.wav'); % reads IQ data from file
%Creates the IQ complex vectors from the read IQ data
for k = 1:length(y)
    IQ(k) = y(k, 1) + i*y(k, 2);
end
%Calculates the welch's power spectral density estimate (should be centered
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
figure(1)
semilogy(W, Pxx); 
%Plots the filtered IQ data
figure(2)
plot(IQfilt);
%Calculates array of finite differences of angle between IQfilt samples
for k = 2:length(IQfilt)
    IQangle(k-1) = angle(IQfilt(k))-angle(IQfilt(k-1));
end
%29 is the start of the first recorded bit. There are 250 samples/bit due
%to 9.6Kbps data rate and 2.4MHz sample frequency, so add half of 250 to
%sample the middle of the bit
counter = 29+125;
index = 1;
%Calculate the digital output array of data
while counter<length(IQangle)
    if IQangle(counter) > 0
        data(index) = 1;
    else
        data(index) = 0;
    end
    index = index + 1;
    counter = counter+250;
end
