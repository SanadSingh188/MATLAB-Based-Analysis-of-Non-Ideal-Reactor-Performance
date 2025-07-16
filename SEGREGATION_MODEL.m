function SEGREGATION_MODEL(C_t,T,n,k,Ca0)

%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);


% EXPRESSING CONVERSION AS A FUNCTION OF TIME

syms t 

if (n==0)
    x = (k*t)/(Ca0);
elseif (n==1)
    x = 1 - exp(-1*k*t);
else
    x = (k*t*Ca0)/(1+(k*t*Ca0));
end


X_t = double(subs(x,t,T));


%% DISPLAY SECITON
Conv = trapz((T),(X_t.*E_t));
fprintf('\n\nConversion predicted by Segregation Model is : %f %% \n\n',Conv*100);
T_smooth = linspace(min(T), max(T), 500);
E_smooth = pchip(T, E_t, T_smooth);
figure;
grid on;
hold on;
scatter(T, E_t, 40, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.2);
plot(T_smooth, E_smooth, 'g-', 'LineWidth', 2.4);
xlabel('Time','fontsize',18);
ylabel('E(t)','fontsize',18);
title('RTD Curve', 'FontWeight', 'bold', 'FontSize', 18);
hold off
