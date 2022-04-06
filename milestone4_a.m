%   Allison Pitzl
%   Milestone 4 part A
%   created 3/30/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y, Fs] = audioread('IQ.wav'); % reads IQ data from file
for k = 1:length(y)
    IQ(k) = y(k, 1) + i*y(k, 2);
end
[Pxx, W] = pwelch(IQ);
semilogy(W, Pxx);
[B, a] = butter(5, 10000/(Fs/2));
IQfilt = filtfilt(B, a, IQ);
[Pxx, W] = pwelch(IQfilt);
%semilogy(W, Pxx); 
 