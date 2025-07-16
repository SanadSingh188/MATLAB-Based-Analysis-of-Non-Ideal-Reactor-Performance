function IDEAL_PFR(C_t,T,n,k,Ca0)

%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);

% Calculating Mean Residence Time and Variance
Tm = trapz(T,(T.*(E_t)));


Tau = Tm;
if (n==0)
    X = k*(Tau)*(Ca0^-1);
elseif (n==1)
    X = 1 - exp(-k*(Tau));
else
    X = (Tau*k*Ca0)/(1 + Tau*k*Ca0);
end

%% DISPLAY SECTION

fprintf("\n\nConversion obtained in Ideal PFR is : %f %% \n\n",(X*100));
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
    