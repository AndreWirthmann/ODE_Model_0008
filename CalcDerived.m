% Derived results for each run.
% Stages still need to be implemented for Pars that change at Stage > 1

for n = 1:size(Result,2)
    MV = table; % Main Vars
    DV = table; % Derived Vars
    P = table; % Parameters
    
    MV = Result(n).MV;
    P = Result(n).P(1,:); % P for first Stage
    
    Vaones = ones(height(MV),1); % 1 vector for sT4 etc

    DV.T4_01 = + Vaones * P.sT4;
    DV.T4_02 = + P.rT4 * MV.V .* MV.T4 ./ (P.CT4 + MV.V);
    DV.T4_03 = - P.artkT4 * P.kT4 * MV.T4 .* MV.V;
    DV.T4_04 = - P.artkT4 * P.kT4Mi * MV.T4 .* MV.Mi;
    DV.T4_05 = - P.dT4 * MV.T4;
    DV.T4_All = DV.T4_01 + DV.T4_02 + DV.T4_03 + DV.T4_04 + DV.T4_05;

    DV.T4i_01 = + P.artkT4 * P.kT4 * MV.T4 .* MV.V;
    DV.T4i_02 = + P.artkT4 * P.kT4Mi * MV.T4 .* MV.Mi;
    DV.T4i_03 = - P.dT4iT8 * MV.T8 .* MV.T4i;
    DV.T4i_04 = - P.lT4i * MV.T4i;
    DV.T4i_05 = - P.dT4i * MV.T4i;
    DV.T4i_06 = + P.lraT4il * P.aT4il * MV.T4i;
    DV.T4i_All = DV.T4i_01 + DV.T4i_02 + DV.T4i_03 + DV.T4i_04 + DV.T4i_05 + DV.T4i_06;

    DV.T4il_01 = + P.lT4i * MV.T4i;
    DV.T4il_02 = - P.dT4ilT8 * MV.T8 .* MV.T4il;
    DV.T4il_03 = - P.lraT4il * P.aT4il * MV.T4il;
    DV.T4il_04 = - P.dT4il * MV.T4il;
    DV.T4il_All = DV.T4il_01 + DV.T4il_02 + DV.T4il_03 + DV.T4il_04;

    DV.T8_01 = + Vaones * P.sT8;
    DV.T8_02 = + P.rT8 * MV.V .* MV.T8 ./ (P.CT8 + MV.V);
    DV.T8_03 = - P.artkT8 * P.kT8 * MV.T8 .* MV.V;
    DV.T8_04 = - P.kT8T4i * MV.T8 .* MV.T4i;
    DV.T8_05 = - P.dT8M * MV.T8 .* MV.M;
    DV.T8_06 = - P.dT8 * MV.T8;
    DV.T8_07 = + P.rT8T4i * MV.T4i .* MV.T8 ./ (P.CT8T4i + MV.T4i);
    DV.T8_All = DV.T8_01 + DV.T8_02 + DV.T8_03 + DV.T8_04 + DV.T8_05 + DV.T8_06 + DV.T8_07;

    DV.M_01 = + Vaones * P.sM;
    DV.M_02 = + P.rM * MV.V .* MV.M ./ (P.CM + MV.V);
    DV.M_03 = - P.kM * MV.M .* MV.V;
    DV.M_04 = - P.dM * MV.M;
    DV.M_All = DV.M_01 + DV.M_02 + DV.M_03 + DV.M_04;

    DV.Mi_01 = + P.kM * MV.M .* MV.V;
    DV.Mi_02 = - P.dMiT8 * MV.Mi .* MV.T8;
    DV.Mi_03 = - P.dMiT4 * MV.Mi .* MV.T4;
    DV.Mi_04 = - P.dMi * MV.Mi;
    DV.Mi_All = DV.Mi_01 + DV.Mi_02 + DV.Mi_03 + DV.Mi_04;

    DV.VT4i = + P.artpT4i * P.pT4i * MV.T4i;
    DV.V_02 = + P.artpT8i * P.pT8i * MV.T8i;
    DV.VT4il = + P.pT4il * MV.T4il;
    DV.V_04 = + P.pDi * MV.Di;
    DV.VMi = + P.pMi * MV.Mi;
    DV.V_06 = + P.aVT4i * MV.T8 .* MV.T4i;
    DV.VdV = - P.dV * MV.V;
    DV.V_All = DV.VT4i + DV.VT4il + DV.VMi + DV.V_02 + DV.V_04 + DV.V_06 + DV.VdV;

    % Ratios
    DV.VT4iT4il   = DV.VT4i ./ DV.VT4il;
    DV.VT4iMi     = DV.VT4i ./ DV.VMi;
    DV.VT4ilMi    = DV.VT4il ./ DV.VMi;
    
    DV.T4_T8      = MV.T4 ./ MV.T8;
    DV.T4_T4i     = MV.T4 ./ MV.T4i;
    DV.T4_T4il    = MV.T4 ./ MV.T4il;
    DV.T4_M       = MV.T4 ./ MV.M;
    DV.T4_Mi      = MV.T4 ./ MV.Mi;
    DV.T4_V       = MV.T4 ./ MV.V;
    
    DV.T4i_T8     = MV.T4i ./ MV.T8;
    DV.T4i_T4il   = MV.T4i ./ MV.T4il;
    DV.T4i_M      = MV.T4i ./ MV.M;
    DV.T4i_Mi     = MV.T4i ./ MV.Mi;
    DV.T4i_V      = MV.T4i ./ MV.V;
    
    DV.T4il_T8    = MV.T4il ./ MV.T8;
    DV.T4il_M     = MV.T4il ./ MV.M;
    DV.T4il_Mi    = MV.T4il ./ MV.Mi;
    DV.T4il_V     = MV.T4il ./ MV.V;
    
    DV.T8_M       = MV.T8 ./ MV.M;
    DV.T8_Mi      = MV.T8 ./ MV.Mi;
    DV.T8_V       = MV.T8 ./ MV.V;
    
    DV.M_Mi       = MV.M ./ MV.Mi;
    DV.M_V        = MV.M ./ MV.V;
    
    DV.Mi_V       = MV.Mi ./ MV.V;

    Result(n).DV = DV;
end
clear MV DV P
return;