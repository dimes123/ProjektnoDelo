function [plosc] = poligon()
%POLIGON racuna ploscino poligona in izrise poligon
%ploscina = POLIGON(t) vrne ploscino poligona, ko se ta prvi? zapre.
%To se zgodi, ko se premici, ki potekajo skozi tocke, ki jih risemo
%na povrsini, prvic sekajo.
sezTock = zeros(2,100);
rez = zeros(2,100);
stevec = 1;
tocka = [0,0]';
stikalo = false;
vsebuje = false;
indeks = 0;

%Ce je uporabnik izbral vnos s tipkovnico
while true
    prompt = 'Vnesi tocko v obliki [x,y]: ';
    podatki = input(prompt);
    if length(podatki) > 2 %preverimo pravilnost podatkov
        disp('Na zalost ta program deluje samo za 2D :(')
    else
        x = podatki(1); y = podatki(2);
        plot(x,y,'*r')
        %Najprej dodamo tri tocke v seznam
        if stevec <=3
            if stevec > 1
                sezTock(1,stevec) = x;
                sezTock(2, stevec) = y;
                plot(sezTock(1,1:stevec),sezTock(2,1:stevec), 'g-x')
                hold on; 
                axis on;
            end
        else
            trenutna = [x,y]';
            %najprej preverimo, ce smo slucajno zadeli tocko
            [vsebuje, indeks] = ali_vsebuje(sezTock, trenutna);
            vsebuje
            if vsebuje
                indeks;
                rez = sezTock(:, indeks:stevec-1);
                sezTock = sezTock(:,1:stevec-1);
                %plot(sezTock(1,1:stevec),sezTock(2,1:stevec), 'g-x')
                break;
            else
                [stikalo, tocka, indeks] = presek(sezTock(:, 1:stevec-1), trenutna);
                stikalo
                if stikalo
                    sezTock(1,stevec)= tocka(1);
                    sezTock(2,stevec)= tocka(2);
                    rez = sezTock(:,indeks+1:stevec);
                    sezTock(1,stevec)= trenutna(1);
                    sezTock(2,stevec)= trenutna(2);
                    sezTock = sezTock(:,1:stevec);
                    plot(sezTock(1,1:stevec),sezTock(2,1:stevec), 'g-x')
                    break;
                end
            end
            sezTock(1,stevec) = trenutna(1);
            sezTock(2,stevec) = trenutna(2);
            plot(sezTock(1,1:stevec),sezTock(2,1:stevec), 'g-x')
        end
    stevec = stevec +1;
    end
end
   
    %risanje
    x_rez = rez(1,:);
    y_rez = rez(2,:);
    x_tocke = sezTock(1,1:end);
    y_tocke = sezTock(2,1:end);
    
    %plot(x_tocke,y_tocke,'g-x');
    %hold on
    %grid on
    %plot(x_rez,y_rez,'y-*');
    fill(x_rez,y_rez,'r');
    plosc = ploscina(rez);
    hold off

end