%include "io.inc"

section .data
;Vec1: Times 300 dd 1
;Vec2: Times 300 dd 1
;в сумме 300

;Vec1: Times 300 dd 8388607
;Vec2: Times 300 dd 8388607
;в сумме 21 110 618 220 134 750

;Vec1: Times 300 dd -8388607
;Vec2: Times 300 dd -8388607
;в сумме 21 110 618 220 134 750

;Vec1: Times 300 dd -1
;Vec2: Times 300 dd -1
;в сумме 300

;Vec1: Times 300 dd 1
;Vec2: Times 300 dd -1
;в сумме -300

;Vec1: Times 300 dd -8388607
;Vec2: Times 300 dd 8388607
;в сумме - 21 110 618 220 134 750

Vec1: Times 50 dd -8388607, -8388607, -8388607, -8388607, -8388607, -8388607
Vec2: Times 50 dd 8388607, 8388607, 8388607, -8388607, -8388607, -8388607
;в сумме 0

;максимальное количество бит равно 23бит * 2 + 1бит(для знака) + 9 (кол-во битов для числа 300)бит = 56 бит

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
        mov edx, 0
    
        ;достаём элементы с одинаковым индексом
        mov eax, [Vec1 + 4 * (ecx - 1)]
        mov ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;перемножаем их
        imul ebx
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
    PRINT_HEX 4, [sum2]
    PRINT_CHAR " "
    PRINT_HEX 4, [sum1]
ret