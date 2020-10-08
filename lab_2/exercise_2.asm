%include "io.inc"

section .data
Vec1: Times 60 dd     1000,        1001,        1002,        1003,        1004
Vec2: Times 60 dd     2000,        2001,        2002,        2003,        2004
;               200 000 0 + 200 300 1 + 200 600 4 + 200 900 9 + 201 201 6 = 1 003 003 0
;в сумме 60 180 180 000

;2^32 2^29 2^28 2^26

length dw 300

prefix dd 4278190080 ;
perep dd 16777215 ;1ед,23 нуля в двоич. сс

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
        
        ;достаём элементы с одинаковым индексом
        add eax, [Vec1 + 4 * (ecx - 1)]
        add ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;перемножаем их
        mul ebx
        mov ebx, eax
        
        ;если число в edx >= perep
        cmp edx, perep
        JG lPerep
        JMP l2
        
        lPerep:
            ;сдвигаем влево так, чтобы 24ый бит оказался на 32ой позиции
            sal edx, 8
            ;если edx >= этого числа(2^31), то на 32ой позиции 1, иначе 0
            cmp edx, 2147483648
            JG lUnit
            sar edx, 8
            JMP l2
        
        ;сейчас регистр имееи вид 8единиц потом наше число в 24ёх битах
        lUnit:
            ;обнуляемя 8мь единиц
            add edx, 8388608
        
        l2:
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