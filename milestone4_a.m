%   Jimmy Cook
%   Milestone 4 part A
%   4/06/22

[y, Fs] = audioread('IQ.wav'); % reads IQ data from file
for k = 1:length(y)
    IQ(k) = y(k, 1) + i*y(k, 2);
end
[Pxx, W] = pwelch(IQ);
semilogy(W, Pxx);
[B, a] = butter(5, 40000/(Fs/2));
IQfilt = filtfilt(B, a, IQ);
[Pxx, W] = pwelch(IQfilt);
figure(1)
semilogy(W, Pxx); 
figure(2)
plot(IQfilt);

for k = 2:length(IQfilt)
    IQangle(k-1) = angle(IQfilt(k))-angle(IQfilt(k-1));
end
counter = 29+125;
index = 1;
while counter<length(IQangle)
    if IQangle(counter) > 0
        data(index) = 1;
    else
        data(index) = 0;
    end
    index = index + 1;
    counter = counter+250;
end

for k= 1:2000
    b(k) = IQangle(k);
end