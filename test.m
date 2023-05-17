fid = fopen("data/near.pcm",'rb');%load far end
ssin = fread(fid,inf,'int16');
fid = fopen("data/far.pcm",'rb');
rrin = fread(fid,inf,'int16');
ssin = ssin(1:2*4096*20);
rrin = rrin(1:2*4096*20);
ssin = ssin / 32768;
rrin = rrin / 32768;
Fs = 16000;
filter_length = 4096;
frame_size = 128;
speex_mdf_out = speex_mdf(Fs,rrin,ssin,filter_length,frame_size);
figure;
ax1 =subplot(311);
plot(ssin);
ax2 =subplot(312);
plot(rrin);
ax3 = subplot(313);
plot(speex_mdf_out.e)
#sound(ssin,16000);

e = floor(real(speex_mdf_out.e)*32768);
fid = fopen('out.pcm', 'wb');
fwrite(fid,e,'int16');
fclose(fid);