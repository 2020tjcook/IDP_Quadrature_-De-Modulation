%   Allison Pitzl
%   Milestone 4 part A
%   created 3/30/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y, Fs] = audioread('IQ.wav'); % reads IQ data from file
for k = 1:length(y)
    IQ(k) = y(k, 1) + i*y(k, 2);
end
[Pxx, W] = pwelch[IQ]