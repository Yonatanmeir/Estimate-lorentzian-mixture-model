p=1
N=200;
snr=20;
range=5;
bin_band=10*10^6 %10 megahz
gamma=10*bin_band*rand(1)+25*bin_band; 
center=6*bin_band*(rand(1)-0.5);
gain=10^(snr/10)*pi*gamma;
samples_vec=linspace(center-range*gamma,center+range*gamma,N);
%generate noisy lorentzian
clean_samples=gain*(1/(pi*gamma))*(gamma^2./((samples_vec-center).^2+gamma^2));
for i=1:N
    noisy_samples(i)=clean_samples(i)+normrnd(0,sqrt(clean_samples(i)));    
end
[val,loc]=max(noisy_samples);
initial_param=[30*bin_band;samples_vec(loc);val*pi*30*bin_band];
if(p)
figure;
plot(samples_vec,noisy_samples,'g')
hold on
plot(samples_vec,clean_samples,'k')
end
ml_out=estimate_one_lorentzian_ml(noisy_samples,samples_vec,range,initial_param,p)
ls_out=estimate_one_lorentzian_ls(noisy_samples,samples_vec,range,initial_param,p)
if(p)
    xlabel('freq');
    ylabel('psd');
    legend('noisy lorentzian','clean lorentzian','ml estimtaion','ls estimation');
end
% %mse gamma
% mse_gamma_ml=mean((gamma_hat_ml-gamma).^2);
% mse_gamma_ls=mean((gamma_hat_ls-gamma).^2);
% figure;
% plot(gamma,'r')
% hold on
% plot(gamma_hat_ml,'g')
% hold on
% plot(gamma_hat_ls,'b')
% legend(['True value'],['ml estimation mse=' num2str(mse_gamma_ml,'%10.2e\n')],['ls estimation mse=' num2str(mse_gamma_ls,'%10.2e\n')] )
% xlabel('iteration');
% ylabel('gamma value');
% title('gamma')
% 
% %mse center:
% mse_center_ml=mean((center_hat_ml-center).^2);
% mse_center_ls=mean((center_hat_ls-center).^2);
% figure;
% plot(center,'r')
% hold on
% plot(center_hat_ml,'g')
% hold on
% plot(center_hat_ls,'b')
% legend(['True value'],['ml estimation mse=' num2str(mse_center_ml,'%10.2e\n')],['ls estimation mse=' num2str(mse_center_ls,'%10.2e\n')] )
% xlabel('iteration');
% ylabel('center value');
% title('center')
% 
% %gain mse
% mse_gain_ml=mean((gain_hat_ml-gain).^2);
% mse_gain_ls=mean((gain_hat_ls-gain).^2);
% figure;
% plot(gain,'r')
% hold on
% plot(gain_hat_ml,'g')
% hold on
% plot(gain_hat_ls,'b')
% legend(['True value'],['ml estimation mse=' num2str(mse_gain_ml,'%10.2e\n')],['ls estimation mse=' num2str(mse_gain_ls,'%10.2e\n')] )
% xlabel('iteration');
% ylabel('gain value');
% title('gain')
