function TANKS_IN_SERIES_MODEL(C_t,T,n,k,Ca0)

%% COMPUTATION SECTION

% FORMING THE RTD

Integral = trapz(T,C_t);
E_t = (C_t)/(Integral);

% FINDING THE NUMBER OF TANKS I.E 'N'


Tm = trapz(T,(T.*(E_t)));
Var = trapz(T,((T-Tm).^2).*(E_t));
N = ((Tm^2)/Var);
Taui = Tm/N;


if (n==1)
    Da = Taui*k;
    Conv = 1 - (1/((1+Da)^N));
    fprintf('\n\nConversion predicted by Tanks-In-Series Model is : %f %%\n\n',Conv*100);
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

fprintf('\n\nUpper bound of Conversion predicted by tanks in series model is : %f %% \n',(UpperBound)*100);
fprintf('\n\nLower bound of Conversion predicted by tanks in series model is : %f %% \n\n',(LowerBound)*100);