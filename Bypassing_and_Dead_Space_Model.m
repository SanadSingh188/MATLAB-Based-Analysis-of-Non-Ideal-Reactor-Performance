function Bypassing_and_Dead_Space_Model(C_t,T,n,k,Ca0,V,vo,Ct0)

%% COMPUTATION SECTION

% EVALUATING ALPHA AND BETA.


Y = log((Ct0)./(Ct0-C_t));
COEFF = polyfit(T,Y,1);
Tau = V/vo;
A = exp(-(COEFF(2)))/(Tau*COEFF(1));
B = 1 - exp(-COEFF(2));

syms C
Parameter = vo*(1-B)*(Ca0-C) - k*(C^n)*A*V;
Parameter = matlabFunction(Parameter);

% Calculating Cas i.e concentration of effluent leaving the reactor

Cas = fzero(Parameter,5);
Ca = B*Ca0 + (1-B)*Cas;

% Calculating Conversion
Conv = 1 - (Ca/Ca0);

%% DISPLAY SECTION
fprintf("\n\nConversion predicted by modelling Real CTSR using bypass and dead space : %f %%\n\n",Conv*100);




