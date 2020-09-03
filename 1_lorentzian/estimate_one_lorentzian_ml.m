function [parameter_out]=estimate_one_lorentzian_ml(noisy_samples,samples_vec,range,initial,p)
f=@(x)mle_lorentzian(x,noisy_samples,samples_vec);
bin_band=10*10^6 %10 megahz
options1=optimset('Display','iter','TolX',10^-100,'TolFun',10^-100);
lb=[25*bin_band,-3*bin_band,min(noisy_samples)*25*bin_band*pi];
up=[35*bin_band,3*bin_band,max(noisy_samples)*35*bin_band*pi];
A=[];
b=[];
aeq=[];
beq=[];
parameter_out=fmincon(f,initial,A,b,aeq,beq,lb,up,[],options1);
gamma_hat=parameter_out(1);
center_hat=parameter_out(2);
gain_hat=parameter_out(3);
if(p)
    ml_samples_vec=linspace(center_hat-range*gamma_hat,center_hat+range*gamma_hat,length(noisy_samples));
    plot(ml_samples_vec,gain_hat*(1/(pi*gamma_hat))*(gamma_hat^2./((ml_samples_vec-center_hat).^2+gamma_hat^2)),'b');
end



