clc;close all;clear all;
disp('Program do liczenia indeksu niezawodnoœci i prawdopodobieñstwa zniszczenia belki rozci¹ganej o przekroju ko³owym dr¹¿onym');
%%%wczytanie danych
disp('podaj sredni promien zewnetrzny w mm');
srednie_r = input(' ');
disp('podaj sredni promien wewnetrzny w mm');
srednie_R = input(' ');
disp('podaj sredni¹ si³ê w kN');
srednie_P = input(' ');
disp('podaj srednie naprê¿enia dopuszczalne w MPa');
srednie_Kdop = input(' ');
disp('podaj odchylenie standardowe promienia zewnetrznego w mm');
odchylenie_r = input(' ');
disp('podaj odchylenie standardowe promienia wewnetrznego w mm');
odchylenie_R = input(' ');
disp('podaj odchylenie standardowe si³y w kN');
odchylenie_P = input(' ');
disp('podaj odchylenie standardowe Kdop w MPa');
odchylenie_Kdop = input(' ');
% disp('podaj odchylenie standardowe naprê¿eñ dopuszczalnych w MPa');
% odchylenie_Kdop = input(' ');

Pole_przekroju=3.14159265*((srednie_r^2)-(srednie_R^2));%liczenie pola przekroju
Mis=1000000000*srednie_P./Pole_przekroju;%srednie obci¹¿enie
if (srednie_Kdop*1000000>Mis)
    disp('œrednia obci¹¿alnoœæ jest wiêksza od œredniego obci¹¿enia')
elseif (srednie_Kdop*1000000<Mis)
    disp('œrednia obci¹¿alnoœæ nie jest wiêksza od œredniego obci¹¿enia.Konstrukcja najprawdopodobniej ulegnie uszkodzeniu')
end
Pochodna_S_po_P=1./(3.1415*((srednie_r^2)-(srednie_R^2)))%wynik w [1/mm^2]
Pochodna_S_po_r=1000*(srednie_P*2*3.1415*srednie_r)./((3.1415*((srednie_r^2)-(srednie_R^2)))^2)%wynik w [N/mm^3]
Pochodna_S_po_R=1000*(srednie_P*2*3.1415*srednie_R)./((3.1415*((srednie_r^2)-(srednie_R^2)))^2)%wynik w [N/mm^3]
kwadrat_odchylenia_obciazenia=(Pochodna_S_po_P^2)*((odchylenie_P*1000)^2)+(Pochodna_S_po_r^2)*(odchylenie_r^2)+(Pochodna_S_po_R^2)*(odchylenie_R^2)%wynik w MPa^2
% a=(Pochodna_S_po_P^2)*((odchylenie_P*1000)^2)
% b=(Pochodna_S_po_r^2)*(odchylenie_r^2)
% c=(Pochodna_S_po_R^2)*(odchylenie_R^2)
Indeks_niezawodnosci=(srednie_Kdop-Mis./1000000)./((odchylenie_Kdop^2)+kwadrat_odchylenia_obciazenia).^0.5
%ustalenia prawdopodobienstwa zniszczenia konstrukcji
x = [-100:1:100];
norm = normpdf(x,0,1);%funkcja normpdf zwraca wektor wartosci rozk³adu Gaussa dla zadanego wektora x.srednia=0,sigma=1 
figure;
plot(x,norm)
fi_beta=0;

for i=-100:1:100
    if (x(i+101)<Indeks_niezawodnosci)
    fi_beta=norm(i+101)+fi_beta;
    end
end
fi_beta
if fi_beta<1
prawdopodobienstwo_uszkodzenia=1-fi_beta
elseif fi_beta==1
  prawdopodobienstwo_uszkodzenia=0   
  elseif fi_beta>1
   prawdopodobienstwo_uszkodzenia=0    
end
