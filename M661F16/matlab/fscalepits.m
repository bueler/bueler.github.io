function [f, df, Hf] = fscalepits(x)
% FSCALEPITS Scale the output of PITS.

[f, df, Hf] = pits(x);
f = 7 * f;
df = 7 * df;
Hf = 7 * Hf;
end

