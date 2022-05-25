# Laborator-ASC

Fisierul 1:

Fie dat ca input un sir hexa, se cere sa se afiseze la standard output instructiunea assembly de
executat.

De exemplu, pentru inputul A78801C00A7890EC04, se va afisa la standard output x 1 let x-14 div.

Fisierul 2:

Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat, se
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, in instructiune
nu exista variabile, ea fiind formata doar din numere intregi si operatii.

De exemplu, poate fi data instructiunea 2 10 mul 5 div 7 6 sub add

Fisierul 3:

Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat. Se
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, spre deosebire
de cerinta 2, se folosesc variabile introduse prin let.

Un exemplu de input poate fi x 1 let 2 x add y 3 let x y add mul.

Fisierul 4:

O matrice poate fi reprezentata in forma

nrLinii nrColoane nrLinii*nrColoane_elemente

Operatiile pe care le putem utiliza pe matrice sunt:

• add - adunam toate elementele din matrice cu valoarea operandului <\br>
• sub - scadem din toate elementele din matrice valoarea operandului <\br>
• mul - inmultim toate elementele din matrice cu valoarea operandului <\br>
• div - impartim toate elementele din matrice la valoarea operandului <\br>
• rot90d - rotim matricea la 90 de grade spre dreapta

Un exemplu de input poate fi: *x 2 3 1 2 3 4 5 6 let x -2* add sau: *x 2 3 -1 0 1 2 3 4 let rot90d*
