function f_value = mle_lorentzian(param,noisy_vec,samples_vec)
%params=(gamma,center,gain)
f_value=0;
for i=1:length(samples_vec)
    mu=(param(3)/(pi*param(1)))*(param(1)^2/(param(1)^2+(samples_vec(i)-param(2))^2));
    to_add=log(normpdf(noisy_vec(i),mu,sqrt(mu)));
%     if(abs(to_add)==inf)
%         continue
%     end
    f_value=f_value+to_add;     
end
f_value=-f_value;
