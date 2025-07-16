function TANKS_IN_SERIES_MODEL(C_t,T,n,k,Ca0)

                             
%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);

% FINDING THE NUMBER OF TANKS I.E 'N'

Tm = trapz(T,(T.*(E_t)));
Var = trapz(T,((T-Tm).^2).*(E_t));
N = ((Tm^2)/Var);
Exact_N = N;
Taui = Tm/N;

if (n==1)
    Da = Taui*k;
    Conv = 1 - (1/((1+Da)^N));
    fprintf('\nNumber of tanks calculated from the model : %f \n',Exact_N);
    fprintf('\n\nConversion predicted by Tanks-In-Series Model is : %f %%\n\n',Conv*100);
    T_smooth = linspace(min(T), max(T), 500);
    E_smooth = pchip(T, E_t, T_smooth);
    figure;
    grid on;
    hold on;
    scatter(T, E_t, 40, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.2);
    plot(T_smooth, E_smooth, 'g-', 'LineWidth', 2.4);
    xlabel('Time','fontsize',18);
    ylabel('E(t)','fontsize',18);
    T = linspace(min(T), max(T), 1000);
    E_t = (T.^(Exact_N - 1) .* exp(-T ./ Taui)) ./ (gamma(Exact_N) .* Taui.^Exact_N);
    plot(T,E_t,'-b','LineWidth',2);
    title('RTD Curves Comparison', 'FontWeight', 'bold', 'FontSize', 18);
    legend('Experimental Data Points', 'Experimental Data Fit (Green)', 'Model Fit (Blue)', 'Location', 'northeast');
    hold off
    return;
end

% Calculating Damkohler Number and upper bound of predicting conversion

N = ceil(N);
if (n==0)
    Da = k*(Taui/Ca0);
    Conv = 1-((1-Da)^N);
else 
    Da = Taui*k*Ca0;
    numerator = ((1+(4*Da))^0.5)-1;
    denominator = 2*Da;
    Conv = 1 - ((numerator/denominator)^N);
end
UpperBound = Conv;

% Calculating Damkohler Number and lower bound of predicting conversion

N = N - 1;
if (n==0)
    Da = k*(Taui/Ca0);
    Conv = 1-((1-Da)^N);
else 
    Da = Taui*k*Ca0;
    numerator = ((1+(4*Da))^0.5)-1;
    denominator = 2*Da;
    Conv = 1 - ((numerator/denominator)^N);
end
LowerBound = Conv;

%% DISPLAY SECTION

fprintf('\nNumber of tanks calculated from the model : %f \n',Exact_N);
fprintf('\nUpper bound of Conversion predicted by tanks in series model is : %f %% \n',(UpperBound)*100);
fprintf('Lower bound of Conversion predicted by tanks in series model is : %f %% \n\n',(LowerBound)*100);
T_smooth = linspace(min(T), max(T), 500);
E_smooth = pchip(T, E_t, T_smooth);
figure;
grid on;
hold on;
scatter(T, E_t, 40, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.2);
plot(T_smooth, E_smooth, 'g-', 'LineWidth', 2.4);
xlabel('Time','fontsize',18);
ylabel('E(t)','fontsize',18);
T = linspace(min(T), max(T), 1000);
E_t = (T.^(Exact_N - 1) .* exp(-T ./ Taui)) ./ (gamma(Exact_N) .* Taui.^Exact_N);
plot(T,E_t,'-b','LineWidth',2);
title('RTD Curves Comparison', 'FontWeight', 'bold', 'FontSize', 18);
legend('Experimental Data Points', 'Experimental Data Fit (Green)', 'Model Fit (Blue)', 'Location', 'northeast');
hold off
