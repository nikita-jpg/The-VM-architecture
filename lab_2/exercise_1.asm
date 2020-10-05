%include "io.inc"

section .data
Vec1: Times 60 dd     10000,        10010,        10020,        10030,        10040
Vec2: Times 60 dd     20000,        20010,        20020,        20030,        20040
;               200 000 000 + 200 300 100 + 200 600 400 + 200 900 900 + 201 201 600 = 1 003 003 000
;в сумме 60 180 180 000

length dw 300

sum1 dd 0; первые 32 бита суммы
sum2 dd 0; вторые 32 бита суммы

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
        adc eax, 0 
        mov [sum2], eax
    loop l1
    
    ;вывод
    mov eax, [sum1]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum2]
    PRINT_UDEC 4, eax
ret