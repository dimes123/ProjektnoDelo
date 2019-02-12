function rez = ploscina(sezTock)
%PLOSCINA irazcuna ploscino polinoma
%rez = ploscina(sezTock) izracuna ploscino polinoma
%podanega s tockami shranjeni v sezTock
%ploscino racunamo po formuli pl =
%|(x1y2-y1x2)+(x2y3-y2x3)+...+(xny1-ynx1)|*1/2

rez = 0;
n = length(sezTock);
j = n;
for i = 1:n
    rez = rez + (sezTock(1,j)+sezTock(1,i))*(sezTock(2,j)-sezTock(2,i));
    j = i;
end
rez = abs(rez*1/2);


end