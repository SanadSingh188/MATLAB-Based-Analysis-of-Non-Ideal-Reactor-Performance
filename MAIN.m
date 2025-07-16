clc;
clear;

choice = '';
while ~strcmpi(choice, 'X')
    fprintf('\n\n--- Reactor Modeling Menu ---\n\n');
    
    % === Critical Unit Consistency Reminder ===
    fprintf('*** IMPORTANT: Ensure Unit Consistency ***\n');
    
    fprintf('The units of volume, rate constant, and reactant concentration must be consistent. \n');
    fprintf('Additionally, the time units used in the rate constant must match those used in the tracer concentration vs time data \n');
    fprintf('Failure to maintain consistency will lead to incorrect results.\n');
    fprintf('*******************************************\n\n');
    fprintf('1. Segregation Model\n');
    fprintf('2. Maximum Mixedness Model\n');
    fprintf('3. Tanks in Series Model\n');
    fprintf('4. Ideal CSTR\n');
    fprintf('5. Ideal PFR\n');
    fprintf('6. Two Adjustable Parameter Model(Bypassing and Dead Space Model)\n');
    fprintf('7. Dispersion Model\n');
    fprintf('X. Exit\n\n');
    
    choice = upper(input('Enter your choice: ', 's'));
    
    switch choice
        case '1'
            fprintf('\n--- Segregation Model ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');
            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            SEGREGATION_MODEL(C_t, T, n, k, Ca0);
            
        case '2'
            fprintf('\n--- Maximum Mixedness Model ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');

            fprintf('\n\nNote:\n');
            fprintf('The tracer concentration data for the Maximum Mixedness Model should:\n');
            fprintf('  - Start near zero\n');
            fprintf('  - Rise to a clear peak\n');
            fprintf('  - Return close to zero\n');
            fprintf('  - Ensure that you have at least ten data points\n');
            fprintf('This complete curve shape is essential for accurate fitting.\n');

            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            MAXIMUM_MIXEDNESS_MODEL(C_t, T, n, k, Ca0);

        case '3'
            fprintf('\n--- Tanks in Series Model ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');
            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            TANKS_IN_SERIES_MODEL(C_t, T, n, k, Ca0);

        case '4'
            fprintf('\n--- Ideal CSTR ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');
            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            IDEAL_CSTR(C_t, T, n, k, Ca0);

        case '5'
            fprintf('\n--- Ideal PFR ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');
            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            IDEAL_PFR(C_t, T, n, k, Ca0);

        case '6'
            fprintf('\n--- Two adjustable parameter model (Bypassing and Dead Space Model) ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - n     (order of reaction)\n');
            fprintf('  - k     (rate constant)\n');
            fprintf('  - Ca0   (initial concentration)\n');
            fprintf('  - V     (volume)\n');
            fprintf('  - vo    (volumetric flowrate)\n');
            fprintf('  - Ct0   (initial tracer concentration)\n');
            if ~confirmProceed(), continue; end
            [C_t, T, n, k, Ca0] = getCommonVars();
            V = input('Enter V (volume): ');
            vo = input('Enter vo (volumetric flowrate): ');
            Ct0 = input('Enter Ct0 (entering tracer concentration): ');
            TWO_ADJUSTABLE_PARAMETER_MODEL(C_t, T, n, k, Ca0, V, vo, Ct0);

        case '7'
            fprintf('\n--- Dispersion Model (Limited to first order reactions only) ---\nRequired variables:\n');
            fprintf('  - C_t   (vector of tracer concentration)\n');
            fprintf('  - T     (vector of time)\n');
            fprintf('  - k     (rate constant)\n');
            if ~confirmProceed(), continue; end
            C_t = input('Enter C_t (vector of tracer concentration): ');
            T = input('Enter T (vector of time): ');
            k = input('Enter k (rate constant): ');
            DISPERSION_MODEL(C_t, T, k);

        case 'X'
            fprintf('Exiting the program.\n');
        otherwise
            fprintf('Invalid input. Please select a valid option.\n');
    end
end

% --- Helper functions ---

function proceed = confirmProceed()
    reply = input("Press 'Y' to continue or 'B' to go back: ", 's');
    proceed = strcmpi(reply, 'Y');
end

function [C_t, T, n, k, Ca0] = getCommonVars()
    C_t = input('Enter C_t (vector of tracer concentration): ');
    T = input('Enter T (vector of time): ');
    n = input('Enter n (order of reaction): ');
    k = input('Enter k (rate constant): ');
    Ca0 = input('Enter Ca0 (initial concentration): ');
end
