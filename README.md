[Română :romania:](#forma-poloneză-postfixată)

[English :eu:](#reverse-polish-notation)

# Forma poloneză postfixată

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

• add - adunam toate elementele din matrice cu valoarea operandului </br>
• sub - scadem din toate elementele din matrice valoarea operandului </br>
• mul - inmultim toate elementele din matrice cu valoarea operandului </br>
• div - impartim toate elementele din matrice la valoarea operandului </br>
• rot90d - rotim matricea la 90 de grade spre dreapta

Un exemplu de input poate fi: *x 2 3 1 2 3 4 5 6 let x -2* add sau: *x 2 3 -1 0 1 2 3 4 let rot90d*


# Reverse polish notation

File 1:

Given an input hexadecimal string, the task is to display the assembly instruction to be executed on standard output.

For example, for the input A78801C00A7890EC04, the output on standard output will be x 1 let x-14 div.

File 2:

Given an instruction in the assembly language of the arithmetic processor, the task is to display the evaluation of the instruction on standard output. For this requirement, there are no variables in the instruction, it consists only of integers and operations.

For example, the given instruction may be 2 10 mul 5 div 7 6 sub add

File 3:

Given an instruction in the assembly language of the arithmetic processor, the task is to display the evaluation of the instruction on standard output. For this requirement, unlike requirement 2, variables are used which are introduced using the let keyword.

An example of input can be x 1 let 2 x add y 3 let x y add mul.

File 4:

A matrix can be represented in the form

number_of_rows number_of_columns number_of_rows*number_of_columns_elements

The operations that can be used on the matrix are:

• add - add the operand value to all the elements in the matrix
• sub - subtract the operand value from all the elements in the matrix
• mul - multiply all the elements in the matrix by the operand value
• div - divide all the elements in the matrix by the operand value
• rot90d - rotate the matrix 90 degrees to the right

An example of input can be: *x 2 3 1 2 3 4 5 6 let x -2* add or: *x 2 3 -1 0 1 2 3 4 let rot90d*
