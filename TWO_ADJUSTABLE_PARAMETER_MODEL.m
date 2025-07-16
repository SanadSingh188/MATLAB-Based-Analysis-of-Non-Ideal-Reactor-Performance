function TWO_ADJUSTABLE_PARAMETER_MODEL(C_t,T,n,k,Ca0,V,vo,Ct0)
                       


%% COMPUTATION SECTION

% EVALUATING ALPHA AND BETA.

Y = log((Ct0)./(Ct0 - C_t));  % Y = ln(Ct0 / (Ct0 - Ct))
COEFF = polyfit(T,Y,1);       % Linear fit: Y = m*T + c
Tau = V / vo;
A = exp(-COEFF(2)) / (Tau * COEFF(1));
B = 1 - exp(-COEFF(2));

syms C
Parameter = vo * (1 - B) * (Ca0 - C) - k * (C^n) * A * V;
Parameter = matlabFunction(Parameter);

% Calculating Cas i.e concentration of effluent leaving the reactor

Cas = fzero(Parameter, 0.5);
Ca = B * Ca0 + (1 - B) * Cas;

% Calculating Conversion
Conv = 1 - (Ca / Ca0);

%% DISPLAY SECTION

fprintf("\n\nConversion predicted by modelling Real CTSR using bypass and dead space : %f %%\n", Conv * 100);
fprintf("Fraction of dead space of CSTR : %f %% \n", ((1 - A) * 100));
fprintf("Fraction of volumetric flow rate bypassed : %f %% \n\n", (B * 100));

%% PLOTTING SECTION

T_fit = linspace(min(T), max(T), 500);
Y_fit = polyval(COEFF, T_fit);

figure;
grid on;
hold on;

scatter(T, Y, 50, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'LineWidth', 1.2);
plot(T_fit, Y_fit, '-b', 'LineWidth', 2);

xlabel('Time (T)', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('ln(C_{t0} / (C_{t0} - C_t))', 'FontWeight', 'bold', 'FontSize', 16);
title('Linear Fit for Two Adjustable Parameter Model', 'FontWeight', 'bold', 'FontSize', 17);

legend('Experimental Data Points', 'Linear Regression Fit', 'Location', 'northwest');

hold off
