%% STDATM_DEMO
% Demonstration of the 1976 Standard Atmosphere using stdatmf.
% Prompts user for altitude (feet) and displays atmospheric properties.
%
% Based on original work by W.H. Mason, Virginia Tech.
% Improved: input validation, error handling, formatted output.

clc;
clearvars;
close all;

%% Display header
fprintf('\n================================================\n');
fprintf('       1976 Standard Atmosphere (English units)\n');
fprintf('================================================\n\n');

%% Get altitude input (feet)
Z = input('  Enter altitude in feet: ');

% Validate input
if ~isscalar(Z) || ~isnumeric(Z) || Z < 0
    error('Altitude must be a non‑negative number.');
end

%% Call the stdatmf function
% k = 1  -> English units (feet, psf, slugs/ft^3, deg R)
k = 1;
[T, R, P, A, MU, TS, RR, PP, RM, QM, KK] = stdatmf(Z, k);

%% Check if altitude is too high (KK = 1)
if KK == 1
    fprintf('\n🚫 ERROR: Altitude exceeds maximum (282,152 ft / 84.85 km).\n');
    fprintf('   No valid atmospheric properties at this altitude.\n');
    return;    % Exit the script (cleaner than 'break')
end

%% Display results in a formatted table
fprintf('\n------------------------------------------------\n');
fprintf('  Atmospheric Properties at Z = %.2f ft\n', Z);
fprintf('------------------------------------------------\n');
fprintf('  Temperature,        T  = %10.4f deg R\n', T);
fprintf('  Pressure,           P  = %10.4f psf\n', P);
fprintf('  Density,            R  = %10.6f slugs/ft^3\n', R);
fprintf('  Speed of Sound,     A  = %10.2f ft/sec\n', A);
fprintf('  Coef. of Viscosity, MU = %10.6f slugs/(ft·sec)\n', MU);
fprintf('  T/T_sl,             TS = %10.6f\n', TS);
fprintf('  ρ/ρ_sl,             RR = %10.6f\n', RR);
fprintf('  P/P_sl,             PP = %10.6f\n', PP);
fprintf('  Re/Mach per foot,   RM = %10.6f 1/ft\n', RM);
fprintf('  q/Mach²,            QM = %10.4f psf\n', QM);
fprintf('------------------------------------------------\n');
fprintf('  Computation successful (KK = 0).\n\n');

function [T,R,P,A,MU,TS,RR,PP,RM,QM,KK] = stdatmf(Z,k)
% STDATMF 1976 Standard Atmosphere properties.
%   [...] = STDATMF(Z,k) returns atmospheric data at altitude Z.
%   k = 0 -> metric units, k ~= 0 -> English units.
%   See the main documentation for details.

    KK = 0;
    K_const = 34.163195;   % renamed to avoid conflict with input k
    T = 1;
    PP = 0;
    
    if k == 0
        % Metric sea‑level constants
        TL = 288.15;        % K
        PL = 101325;        % Pa
        RL = 1.225;         % kg/m^3
        C1 = 0.001;         % km/m
        AL = 340.294;       % m/s
        ML = 1.7894e-5;     % kg/(m·s)
        BT = 1.458e-6;      % Sutherland constant
    else
        % English sea‑level constants
        TL = 518.67;        % deg R
        PL = 2116.22;       % psf
        RL = 0.0023769;     % slugs/ft^3
        C1 = 3.048e-4;      % km/ft (since 1 ft = 0.0003048 km)
        AL = 1116.45;       % ft/s
        ML = 3.7373e-7;     % slugs/(ft·s)
        BT = 3.0450963e-8;  % Sutherland constant (English version)
    end
    
    % Geopotential height (km)
    H = C1 * Z / (1 + C1 * Z / 6356.766);
    
    % Piecewise temperature and pressure ratio
    if H < 11
        T = 288.15 - 6.5 * H;
        PP = (288.15 / T) ^ (-K_const / 6.5);
    elseif H < 20
        T = 216.65;
        PP = 0.22336 * exp(-K_const * (H - 11) / 216.65);
    elseif H < 32
        T = 216.65 + (H - 20);
        PP = 0.054032 * (216.65 / T) ^ K_const;
    elseif H < 47
        T = 228.65 + 2.8 * (H - 32);
        PP = 0.0085666 * (228.65 / T) ^ (K_const / 2.8);
    elseif H < 51
        T = 270.65;
        PP = 0.0010945 * exp(-K_const * (H - 47) / 270.65);
    elseif H < 71
        T = 270.65 - 2.8 * (H - 51);
        PP = 0.00066063 * (270.65 / T) ^ (-K_const / 2.8);
    elseif H < 84.852
        T = 214.65 - 2 * (H - 71);
        PP = 3.9046e-5 * (214.65 / T) ^ (-K_const / 2);
    else
        KK = 1;   % altitude out of range
        return;
    end
    
    % Compute derived quantities
    TS = T / 288.15;
    RR = PP / TS;
    MU = BT * T^1.5 / (T + 110.4);
    A = AL * sqrt(TS);
    
    % Scale to actual properties
    T = TL * TS;
    R = RL * RR;
    P = PL * PP;
    RM = R * A / MU;
    QM = 0.7 * P;
end