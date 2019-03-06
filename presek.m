function [stikalo, tocka, indeksTocke] = presek(sezTock, trenutna)
%PRESEK izracuna morebitno presecisce tocke s prejsnjimi
%[stikalo, podatki] = PRESEK(sezTock, trenutna) vrne ali se premica, 
%ki gre od trenutne tocke do prejsnje seka s katerokoli premico izmed
%preostalih. Vrne tudi presecisce in indeks tocke
stikalo = false;
podatki = [0,0,0]';
zadnja = sezTock(:,end);
k1 = (trenutna(2)-zadnja(2))/(trenutna(1)-zadnja(1));
n1 = trenutna(2)-trenutna(1)*k1;
indeksTocke = 0;
indeks = 0;
tocka = [0,0]';
sezPresecisc = [0,0,0]';
for i = 1:length(sezTock(1,:))-2
    prva = sezTock(:,i);
    druga = sezTock(:,i+1);
    x1 = prva(1);x2=druga(1);
    y1 = prva(2);y2=druga(2);
    k2 = (druga(2)-prva(2))/(druga(1)-prva(1));
    n2 = druga(2)-druga(1)*k2;
    pomozniX = sort([floor(x1),floor(x2)]);
    pomozniY = sort([floor(y1),floor(y2)]);
    pomozniXint = sort([floor(trenutna(1)),floor(zadnja(1))]);
    pomozniYint = sort([floor(trenutna(2)),floor(zadnja(2))]);
    xpresek = intersect(pomozniX(1):pomozniX(2),pomozniXint(1):pomozniXint(2));
    ypresek = intersect(pomozniY(1):pomozniY(2),pomozniYint(1):pomozniYint(2));
    %preverimo, ce smo zadeli eno od prejnsnjih tock
    if ali_vsebuje(sezTock, trenutna)
        podatki(1:2) = trenutna';
        podatki(3) = i;
        stikalo = true;
        sezPresecisc = [sezPresecisc,podatki];
        break;
    end
    if length(xpresek) >= 1 && length(ypresek) >= 1
        if k2 == abs(Inf) %vemo, da gre za navpicno crto
            x = prva(1);
            y = n1-k1*x;
            if k1 == k2 %ce sta vzporedni, vzamemo sredinski y
                pomozna = sort([y1,y2,trenutna(2)]);
                y = pomozna(2);
            end
            if (min(y1,y2)<=y) && (y<=max(y1,y2)) && (trenutna(1) <= max(x1,x2))    
                podatki(1:2) = [x,y]';
                podatki(3) = i;
                stikalo = true;
                sezPresecisc = [sezPresecisc,podatki];
                disp('najdem presecisce x konstanta 2.0')
            end
        elseif k2 == 0 %vemo, da gre za vodoravno crto
            y = n2;
            x = (y-n1)/k1;
            if k1 == k2 %ce sta vzporedni, vzamemo max x
                x = max([x1,x2,trenutna(1)]);
            elseif k1 == abs(Inf)
                x = trenutna(1);
            end
            if (min(x1,x2)<=x) && (x<=max(x1,x2)) && (trenutna(2) >= max(y1,y2))
                podatki(1:2) = [x,y]';
                podatki(3) = i;
                stikalo = true;
                sezPresecisc = [sezPresecisc,podatki];
                disp('najdem presecisce y konstanta 2.0')
            end
        else %ce, gre za navadno premico
            x = (n2-n1)/(k1-k2);
            y = k1*x+n1;
            if abs(k1) == Inf %ce je trenutna navpicna
                x = trenutna(1);
                y = k2*x+n2;
            elseif k1 == k2 %ce sta vzporedni
                x = max([x1,x2,trenutna(1)]);
                y = min([y1,y2,trenutna(2)]);
            end
            %gledamo dolzine premic
            if norm(zadnja-trenutna) >= norm(prva-druga) 
                podatki(1:2) = [x,y]';
                podatki(3) = i;
                stikalo = true;
                sezPresecisc = [sezPresecisc,podatki];
                disp('najdem presecisce premic 2.0')
            else
                if sign(k1) ~= sign(k2) && k1~= 0
                    podatki(1:2) = [x,y]';
                    podatki(3) = i;
                    stikalo = true;
                    disp('najdem presecisce premic 2.0')
                    sezPresecisc = [sezPresecisc,podatki];
                end
            end
        end
    end
end
%ce imamo vec kot 2 presecisci
if length(sezPresecisc(1,:)) >= 2
    [tocka,indeks] = najblizje(sezPresecisc, trenutna);
    indeksTocke = sezPresecisc(end,indeks);
else
    tocka = sezPresecisc(1:2,:);
    indeksTocke = sezPresecisc(3,:);
end

end