 function MAXIMUM_MIXEDNESS_MODEL(C_t,T,n,k,Ca0)


%% COMPUTATION SECTION

% PieceWise Curve fitting

% 1st half

[~, id_max] = max(C_t);
First_half_C_t = C_t(1:id_max);
First_half_T = T(1:id_max);
FIT1 = polyfit(First_half_T,First_half_C_t,3);
C_t1 = polyval(FIT1,linspace(First_half_T(1),First_half_T(end),1000));
C_t1(end) = C_t(id_max);

% 2nd half

Second_half_C_t = C_t(id_max:end);
Second_half_T = T(id_max:end);
FIT2 = polyfit(Second_half_T,Second_half_C_t,3);
C_t2 = polyval(FIT2,linspace(Second_half_T(1),Second_half_T(end),1000));
C_t2(1) = C_t(id_max);


% COMBINING THEM
A = linspace(First_half_T(1),First_half_T(end),1000);
B = linspace(Second_half_T(1),Second_half_T(end),1000);

New_C_t = [C_t1(1:end-1),C_t2(1:end)];
New_T = [A(1:end-1),B(1:end)];


% FORMING THE RTD

Integral = trapz(New_T, New_C_t);
E_t = (New_C_t)/(Integral);
F_t = cumtrapz(New_T,E_t);
F_t(end) = 0.99999999990;


dem = (E_t)./((1-F_t));


% BACKWARDS INTEGRATION TO GET CONVERSION
Loop_Count = numel(E_t);
Delta_T = New_T;
Loop_X = 0;
A = zeros(1,95);

while(Loop_Count > 1)
    Delta_T = New_T(Loop_Count) - New_T(Loop_Count-1);
    Loop_X = -(Delta_T*(-1*(k*(Ca0^(n-1)*(1-Loop_X)^n))+((E_t(Loop_Count)*Loop_X)/(1-F_t(Loop_Count))))) + Loop_X;
    Loop_Count = Loop_Count - 1;
end


Conv = Loop_X ;
fprintf('\n\nConversion predicted from Maximum Mixedness Model is : %f %%\n\n',Conv*100);

