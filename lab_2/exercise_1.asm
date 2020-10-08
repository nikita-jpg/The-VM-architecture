%include "io.inc"

section .data
;Vec1: Times 60 dd     10000000,             10000001,             10000002,        10000003,        10000004
;Vec2: Times 60 dd     16000000,             16000001,             16000002,        16000003,        16000004
;          160 000 000 000 000 + 160 000 026 000 001 + 160 000 052 000 004 + 
;          160 000 078 000 009 + 160 000 104 000 016 = 800 000 260 000 030
;в сумме 48 000 015 600 001 800

Vec1: Times 300 dd 16777215
Vec2: Times 300 dd 16777215
;в сумме 84 442 482 946 867 500

;максимальное количество бит равно 24бит * 2 + 9 (кол-во битов для числа 300)бит = 57 бит

length dw 300

sum1 dd 0; первые 24 бита суммы
sum2 dd 0; вторые 24 бита суммы

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
        
    loop l1
    
    ;вывод
    mov eax, [sum1]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum2]
    PRINT_UDEC 4, eax
ret