function MAXIMUM_MIXEDNESS_MODEL(C_t,T,n,k,Ca0)

                       

%% FORMING EXPERIMENTAL RTD AND PLOTTING IT
Integral = trapz(T, C_t);
E_t_exp = C_t / Integral;
T_smooth = linspace(min(T), max(T), 500);
E_smooth = pchip(T, E_t_exp, T_smooth);

figure;
grid on;
hold on;

scatter(T, E_t_exp, 40, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.2);
h_exp = plot(T_smooth, E_smooth, 'g-', 'LineWidth', 2);

xlabel('Time', 'FontWeight', 'bold', 'FontSize', 18);
ylabel('E(t)', 'FontWeight', 'bold', 'FontSize', 18);
title('RTD Curves Comparison- Maximum Mixedness Model', 'FontWeight', 'bold', 'FontSize', 18);

%% COMPUTATION SECTION

[~, id_max] = max(C_t);
First_half_C_t = C_t(1:id_max);
First_half_T = T(1:id_max);
FIT1 = polyfit(First_half_T, First_half_C_t, 3);
C_t1 = polyval(FIT1, linspace(First_half_T(1), First_half_T(end), 1000));
C_t1(end) = C_t(id_max);

Second_half_C_t = C_t(id_max:end);
Second_half_T = T(id_max:end);
FIT2 = polyfit(Second_half_T, Second_half_C_t, 3);
C_t2 = polyval(FIT2, linspace(Second_half_T(1), Second_half_T(end), 1000));
C_t2(1) = C_t(id_max);

A = linspace(First_half_T(1), First_half_T(end), 1000);
B = linspace(Second_half_T(1), Second_half_T(end), 1000);
New_C_t = [C_t1(1:end-1), C_t2(1:end)];
New_T = [A(1:end-1), B(1:end)];

Integral = trapz(New_T, New_C_t);
E_t = New_C_t / Integral;
F_t = cumtrapz(New_T, E_t);
F_t(end) = 0.99999999990;

%% BACKWARDS INTEGRATION TO GET CONVERSION

Loop_Count = numel(E_t);
Loop_X = 0;

while (Loop_Count > 1)
    Delta_T = New_T(Loop_Count) - New_T(Loop_Count - 1);
    Loop_X = -(Delta_T * (-1 * (k * (Ca0^(n-1) * (1 - Loop_X)^n)) + ((E_t(Loop_Count) * Loop_X) / (1 - F_t(Loop_Count))))) + Loop_X;
    Loop_Count = Loop_Count - 1;
end

Conv = Loop_X;

%% DISPLAY SECTION

fprintf('\n\nConversion predicted from Maximum Mixedness Model is : %f %%\n\n', Conv * 100);

h_model = plot(New_T, E_t, 'b-', 'LineWidth', 2);

legend('Experimental Data Points', 'Experimental Data Fit (Green)', 'Model Fit (Blue)', 'Location', 'northeast');

hold off
