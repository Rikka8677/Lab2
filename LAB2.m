clear,close all;

filename = './Sample/mySample.wav';
[data,fs] = audioread(filename);
sample = 20.*((data(:,2)+data(:,1))/2);
figure('Name','Orignal Signal');
subplot(211);   plot(sample,'r');   title('Orignal Signal');  xlabel('Sample number'); ylabel('Amplitude');
subplot(212);   spectrogram(sample,1024,1000,[],fs,'yaxis');  

%%{
h1 = zeros(1,5000);
h1(3500) = 1;
y1 = myconv(sample,h1);
[H1, w1] = myfreqz(h1);
q1 = abs(H1);
for x = 1:512
    if(abs(q1-1)<1e-15)
        q1(x) = round(q1(x));
    end
end
figure('Name','Ideal Delay filter');
subplot(311);   plot(20*log10(q1)); title('Ideal Delay frequency response'); xlabel('Sample number'); ylabel('Amplitude(dB)');
subplot(312);   plot(y1,'g');       title('Signal with Ideal Delay');        xlabel('Frequency'); ylabel('Amplitude');
subplot(313);   spectrogram(y1,1024,1000,[],fs,'yaxis');    title('Signal with Ideal Delay');
audiowrite('./Export/Ideal_Delay.wav',y1,fs);
%}


%%{
h2 = zeros(1,length(sample));
M1 = -20;
M2 = 10;
h2((length(sample)/2)+M1:(length(sample)/2)+M2) = 1/(abs(M2-M1)+1);
y2 = myconv(sample,h2);
[H2, w2] = myfreqz(h2);
q2 = abs(H2);
for x = 1:512
    if(abs(q2-1)<1e-15)
        q2(x) = round(q2(x));
    end
end
figure('Name','Moving Average filter');
subplot(311);   plot(20*log10(q2)); title('Moving Average frequency response'); xlabel('Sample number'); ylabel('Amplitude(dB)');
subplot(312);   plot(y2,'g');       title('Signal with Moving Average');        xlabel('Frequency'); ylabel('Amplitude');
subplot(313);   spectrogram(y2,1024,1000,[],fs,'yaxis');    title('Signal with Moving Average');
audiowrite('./Export/Moving_Average.wav',y2,fs);
%}


%%{
h3 = ones(1,30);
y3 = myconv(sample,h3);
[H3, w3] = myfreqz(h3);
q3 = abs(H3);
for x = 1:512
    if(abs(q3-1)<1e-15)
        q3(x) = round(q3(x));
    end
end
figure('Name','Accumulator filter');
subplot(311);   plot(20*log10(q3)); title('Accumulator frequency response'); xlabel('Sample number'); ylabel('Amplitude(dB)');
subplot(312);   plot(y3,'g');       title('Signal with Accumultor');        xlabel('Frequency'); ylabel('Amplitude');
subplot(313);   spectrogram(y3,1024,1000,[],fs,'yaxis');    title('Signal with Accumulator');
audiowrite('./Export/Accumulator.wav',y3,fs);
%}


%%{
h4 = [1 -1 0];
y4 = myconv(sample,h4);
[H4, w4] = myfreqz(h4);
q4 = abs(H4);
for x = 1:512
    if(abs(q4-1)<1e-15)
        q4(x) = round(q4(x));
    end
end
figure('Name','Forward diff filter');
subplot(311);   plot(20*log10(q4)); title('Forward diff frequency response'); xlabel('Sample number'); ylabel('Amplitude(dB)');
subplot(312);   plot(y4,'g');       title('Signal with Forward diff');        xlabel('Frequency'); ylabel('Amplitude');
subplot(313);   spectrogram(y4,1024,1000,[],fs,'yaxis');    title('Signal with Forward diff');
audiowrite('./Export/Forward_diff.wav',y4,fs);
%}


%%{
h5 = [0 1 -1];
y5 = myconv(sample,h5);
[H5, w5] = myfreqz(h5);
q5 = abs(H5);
for x = 1:512
    if(abs(q5-1)<1e-15)
        q5(x) = round(q5(x));
    end
end
figure('Name','Backward diff filter');
subplot(311);   plot(20*log10(q5)); title('Backward diff frequency response'); xlabel('Sample number'); ylabel('Amplitude(dB)'); 
subplot(312);   plot(y5,'g');       title('Signal with Backward diff');        xlabel('Frequency'); ylabel('Amplitude');
subplot(313);   spectrogram(y5,1024,1000,[],fs,'yaxis');    title('Signal with Backward diff');
audiowrite('./Export/Backward_diff.wav',y5,fs);
%}