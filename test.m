clc;close all;clear all;
Indeks_niezawodnosci=25.495
x = [-100:1:100];
norm = normpdf(x,0,1);%funkcja normpdf zwraca wektor wartosci rozk³adu Gaussa dla zadanego wektora x.srednia=0,sigma=1 
figure;
plot(x,norm)
suma=0;

for i=-100:1:100
    if (x(i+101)<Indeks_niezawodnosci)
    norm(i+101)
    suma=norm(i+101)+suma
    end
end
suma-1
