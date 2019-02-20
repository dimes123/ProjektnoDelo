function [stikalo, tocka, indeksTocke] = presek(sezTock, trenutna)
%PRESEK izracuna morebitno presecisce tocke s prejšnjimi
%[stikalo, tocka] = PRESEK(sezTock, trenutna) vrne ali se premica, 
%ki gre od trenutne tocke do prejsnje seka s katerokoli premico izmed
%preostalih.
stikalo = false;
tocka = [0,0]';
zadnja = sezTock(:,end);
k1 = (trenutna(2)-zadnja(2))/(trenutna(1)-zadnja(1));
n1 = trenutna(2)-trenutna(1)*k1;
indeksTocke = 0;
for i = 1:length(sezTock(1,:))-2
    prva = sezTock(:,i);
    druga = sezTock(:,i+1);
    k2 = (druga(2)-prva(2))/(druga(1)-prva(1));
    n2 = druga(2)-druga(1)*k2;
    x1 = prva(1);x2=druga(1);
    y1 = prva(2);y2=druga(2);
    if k2 == Inf || k2 == -Inf %vemo, da gre za navpicno crto
        x = prva(1);
        y = n1-k1*x;
        if k1 == k2 %ce sta vzporedni, vzamemo sredinski y
                pomozna = sort([y1,y2,trenutna(2)]);
                y = pomozna(2);
        end
        if (min(y1,y2)<=y) && (y<=max(y1,y2)) && (trenutna(1) <= max(x1,x2))    
            tocka = [x,y]';
            indeksTocke = i;
            stikalo = true;
            disp('najdem presecisce x konstanta 2.0')
            break
        end
    elseif k2 == 0 %vemo, da gre za vodoravno crto
        y = n2;
        x = (y-n1)/k1;
        if k1 == k2 %ce sta vzporedni, vzamemo max x
            x = max([x1,x2,trenutna(1)]);
        end
        if (min(x1,x2)<=x) && (x<=max(x1,x2)) && (trenutna(2) >= max(y1,y2))
            tocka = [x,y]';
            indeksTocke = i;
            stikalo = true;
            disp('najdem presecisce y konstanta 2.0')
            break
        end
    else %ce, gre za navadni dve premici
        x = (n2-n1)/(k1-k2);
        y = (k1*n2 - k2*n1)/(k1-k2);
        if k1 == k2
            x = max([x1,x2,trenutna(1)]);
            y = min([y1,y2,trenutna(2)]);
        end
        if (min(x1,x2)<=x) && (x<=max(x1,x2))
            if (min(y1,y2)<=y) && (y<=max(y1,y2))
                tocka = [x,y]';
                indeksTocke = i;
                stikalo = true;
                disp('najdem presecisce premic 2.0')
            	break
            end
        end
    end
end
end

