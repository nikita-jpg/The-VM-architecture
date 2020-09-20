%include "io.inc"

section .data
arr dw 5, 8, 7, 9, 10, 6
sum dw 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    mov cx, [arr]
    
    l1:
        ;достаём элемент массива
        mov ax, cx
        mov bx, 2
        mul bx
        mov dx, [arr + eax]
        
        ;прибавляем к sum элемент массива
        mov ax, [sum]
        add ax, dx
        mov [sum], ax
    loop l1
   
    mov ax, [sum]
    PRINT_UDEC 2, ax
Ret