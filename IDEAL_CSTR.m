function IDEAL_CSTR(C_t,T,n,k,Ca0)

%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);

% Calculating Mean Residence Time and Variance
Tm = trapz(T,(T.*(E_t)));


Tau = Tm;
% Tau = V/vo;

syms x

Parameter = Tau - ((x)/(k*(Ca0^(n-1))*((1-x)^n)));
Parameter = matlabFunction(Parameter);
X = fzero(Parameter,0.5);

%% DISPLAY SECTION

fprintf("\n\nConversion obtained in Ideal CSTR is : %f %% \n\n",(X*100));