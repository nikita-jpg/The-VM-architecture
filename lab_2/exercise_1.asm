%include "io.inc"

section .data
Vec1: Times 60 dd     10000,        10010,        10020,        10030,        10040
Vec2: Times 60 dd     20000,        20010,        20020,        20030,        20040
;               200 000 000 + 200 300 100 + 200 600 400 + 200 900 900 + 201 201 600 = 1 003 003 000
;в сумме 60 180 180 000

length dw 300

prefix dd 4278190080 ;
perep dd 16777215 ;1ед,23 нуля в двоич. сс

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