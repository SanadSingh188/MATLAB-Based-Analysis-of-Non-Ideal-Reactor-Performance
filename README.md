# Predicting Conversion in Non-Ideal Reactors Using Various Models

## Summary

This MATLAB-based tool predicts the conversion of a single reaction occurring in a non-ideal reactor. The user provides tracer concentration vs. time data and kinetic data (initial concentration, rate constant, and reaction order). Based on this, the tool simulates reactor performance using various models.

But which model should be used?

- Segregation Model and Maximum Mixedness Model are suitable for macrofluid systems.
- Tanks-in-Series Model is applicable to any non-ideal reactor. A higher number of tanks (n) suggests a lower degree of backmixing, while a higher n indicates reduced backmixing.
- Dispersion Model captures the effect of axial dispersion in tubular reactors and highlights deviations from ideal plug flow behavior.
- Two Adjustable Parameter Model addresses the impact of non-ideal flow patterns (dead zones or fluid bypassing) in CSTRs.

To aid in comparison:
- IDEAL_PFR Model evaluates conversion for an ideal plug flow reactor.
- IDEAL_CSTR Model evaluates conversion for an ideal continuous stirred tank reactor.



## Features

- Five models to simulate non-ideal behavior:
  - Segregation Model
  - Maximum Mixedness Model
  - Tanks-in-Series Model
  - Dispersion Model (1st order only)
  - Two Parameter Adjustable model

- Supports 0th, 1st, and 2nd order single reactions.
- Input requirements:
  - Tracer Concentration vs Timde data
  - Kinetic parameters (C₀, k, reaction order)

## Installation

No special installation needed.

1. Download or clone the repository.
2. Place all scripts and function files in a single folder.
3. Open MATLAB and run the main script.

## How to Use

- Follow prompts in the command window.
- For vector inputs (like tracer data), use square brackets:  
  Example: [0 0.1 0.3 0.2 0.05 0]

A sample screenshot is provided in the repository for reference.

## Limitations

- Only supports single reactions with orders 0, 1, or 2.
- Dispersion Model is limited to 1st order reactions only.
- No GUI – interaction is via command line.

## Assumptions

- Isothermal reactor operation  
- Incompressible, constant-density fluids  
- Steady-state flow  
- No chemical reaction in tracer experiments

## Credits

All mathematical formulations and reactor modeling approaches are derived from:

Elements of Chemical Reaction Engineering FIFTH EDITION by H. Scott Fogler

## How to Cite

This project is not published in a peer-reviewed journal but is available on GitHub. You may cite it as:

Sanad Singh, Predicting Conversion in Non-Ideal Reactors Using MATLAB, GitHub repository, 2025. [Online]. Available: https://github.com/SanadSingh188/MATLAB-Based-Analysis-of-Non-Ideal-Reactor-Performance

## License

This project is released under the MIT License.

## Author

Sanad Singh  
Chemical Engineering Undergraduate, NIT Warangal (India)  
[LinkedIn](https://www.linkedin.com/in/sanad-singh-818aab1ba/)
