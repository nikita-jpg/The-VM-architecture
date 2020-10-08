%include "io.inc"

section .data
Vec1: Times 60 dd     1000000000,        1001000000,        1002000000,        1003000000,        1004000000
Vec2: Times 60 dd     2000000000,        2001000000,        2002000000,        2003000000,        2004000000
;               2 000 000 000 000 000 000 + 2 003 001 000 000 000 000 + 2 006 004 000 000 000 000
; + 2 009 009 000 000 000 000 + 2 012 016 000 000 000 000 = 10 030 030 000 000 000 000
;в сумме 601 801 800 000 000 000 000

length dw 300

sum1 dd 0; первые 32 бита суммы
sum2 dd 0; вторые 32 бита суммы
sum3 dd 0; третьи 32 бита суммы

sum

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;зануляем регистры
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    ;находим свёртку
    mov ecx, [length]
    
    l1:    
        mov edx, 0
    
        ;достаём элементы с одинауовым индексом
        mov eax, [Vec1 + 4 * (ecx - 1)]
        mov ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;перемножаем их
        mul ebx
        mov ebx, eax
        
        ;складываем с уже существующей суммой
        mov eax, [sum1]
        add eax, ebx
        mov [sum1], eax
        
        mov eax, [sum2]
        adc eax, edx
        mov [sum2], eax
        
        mov eax, [sum3]
        adc eax, 0
        mov [sum3], eax
    loop l1
    
    ;вывод
    mov eax, [sum1]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum2]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum3]
    PRINT_UDEC 4, eax
ret