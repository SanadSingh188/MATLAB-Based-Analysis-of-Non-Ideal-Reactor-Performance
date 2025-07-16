function DISPERSION_MODEL(C_t,T,k)



%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);

% Calculating Mean Residence Time and Variance
Tm = trapz(T,(T.*(E_t)));
Var = trapz(T,((T-Tm).^2).*(E_t));

% Calculating Peclet Number
syms P

% For Close-Close Boundary System
Parameter = (Var/(Tm^2)) - (2/(P*P))*(P - 1 - exp(-P));
Parameter = matlabFunction(Parameter);
Pec_NumC = fzero(Parameter,10);


% Predicting Conversion for Close-Close Boundary System
Tau = Tm;
Da = Tau*k;

q = (1+(4*(Da/Pec_NumC)))^(0.5);
a = 4*q*exp(Pec_NumC/2);
b = ((1+q)^2)*exp(Pec_NumC*q*0.5);
c = ((1-q)^2)*exp(-Pec_NumC*q*0.5);
XC = 1 - ((a)/(b-c));





%% DISPLAY SECTION

fprintf("\n\nConversion predicted by Axial Dispersion Model for a Close-Close Boundary System is : %f %%\n\n",XC*100);

T_smooth = linspace(min(T), max(T), 500);
E_smooth = pchip(T, E_t, T_smooth);
figure;
grid on;
hold on;
scatter(T, E_t, 40, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.2);
plot(T_smooth, E_smooth, 'g-', 'LineWidth', 2.4);
xlabel('Time','fontsize',18);
ylabel('E(t)','fontsize',18);
title('RTD Curve - Dispersion Model', 'FontWeight', 'bold', 'FontSize', 18);
hold off







