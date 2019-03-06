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
disp('Dobrodosel v programu')
while true
    prompt = 'Vnesi tocko v obliki [x,y]: ';
    podatki = input(prompt);
    if length(podatki) > 2 %preverimo pravilnost podatkov
        disp('Na zalost ta program deluje samo za 2D :(')
    else
        x = podatki(1); y = podatki(2);
        %Najprej dodamo tri tocke v seznam
        if ((x>10) || (x<-10))||((y>10) || (y<-10))
            disp('Koordinate morajo biti od -10 do 10')
            break;
        end
        if stevec <=3
            sezTock(1,stevec) = x;
            sezTock(2, stevec) = y;
            %ko imamo vec kot eno tocko, zacnemo povezovati
            if stevec > 1 
                plot(sezTock(1,1:stevec),sezTock(2,1:stevec), '-d','MarkerSize',10, 'MarkerFaceColor','green')
                hold on; 
                axis ([-10 10 -10 10]);
                grid on;
            end
        else
            trenutna = [x,y]';
            [stikalo, tocka, indeks] = presek(sezTock(:, 1:stevec-1), trenutna);
            if stikalo
                sezTock(1,stevec)= tocka(1);
                sezTock(2,stevec)= tocka(2);
                rez = sezTock(:,indeks:stevec);
                sezTock(1,stevec)= trenutna(1);
                sezTock(2,stevec)= trenutna(2);
                sezTock = sezTock(:,1:stevec);
                plot(sezTock(1,1:stevec),sezTock(2,1:stevec), '-d','MarkerSize',10, 'MarkerFaceColor','green')
                break
            end
            sezTock(1,stevec) = trenutna(1);
            sezTock(2,stevec) = trenutna(2);
            plot(sezTock(1,1:stevec),sezTock(2,1:stevec), '-d','MarkerSize',10, 'MarkerFaceColor','green')
        end
    stevec = stevec +1;
    end
end
   
    %risanje
    x_rez = rez(1,:);
    y_rez = rez(2,:);
    fill(x_rez,y_rez,'b');
    plosc = ploscina(rez);
    hold off

end