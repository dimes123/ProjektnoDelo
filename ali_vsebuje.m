function [stikalo] = ali_vsebuje(sezTock, tocka)
%ALI_VSEBUJE preveri, ce vrednost obstaja v seznamu
%[stikalo] = ALI_VSEBUJE(sezTock, tocka) vrne true, ce sezTock vsebuje
%tocko, sicer vrne false
stikalo = false;
for i = 1:length(sezTock(1,:))
    pomozna = sezTock(:,i);
    x = pomozna(1); y = pomozna(2);
    if x == tocka(1) && y == tocka(2)
        stikalo = true;
        break;
    end
end

end