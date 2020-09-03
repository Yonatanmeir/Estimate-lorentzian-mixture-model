function [parameter_out]=estimate_one_lorentzian_ls(noisy_samples,samples_vec,range,initial,p)
bin_band=10*10^6 %10 megahz
g=@(x)(x(3)/(pi*x(1)))*(x(1)^2./(x(1)^2+(samples_vec-x(2)).^2))-noisy_samples;
options=optimset('Display','iter','TolX',10^-100,'TolFun',10^-100,'MaxFunEvals',500);
lb=[25*bin_band,-3*bin_band,min(noisy_samples)*25*bin_band*pi];
up=[35*bin_band,3*bin_band,max(noisy_samples)*35*bin_band*pi];
parameter_out=lsqnonlin(g,initial,lb,up,options);
gamma_hat=parameter_out(1);
center_hat=parameter_out(2);
gain_hat=parameter_out(3);
if(p)
    ls_samples_vec=linspace(center_hat-range*gamma_hat,center_hat+range*gamma_hat,length(noisy_samples));
    plot(ls_samples_vec,gain_hat*(1/(pi*gamma_hat))*(gamma_hat^2./((ls_samples_vec-center_hat).^2+gamma_hat^2)),'r');
end
end
