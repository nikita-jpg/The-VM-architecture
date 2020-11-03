%include "io.inc"

section .data
array1 dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
array2 dd 0, 1, 2, 3, 4, 5, 6, 7, 8
array3 dd 0, 1, 2, 3, 4, 5, 6, 7
array4 dd 0, 1, 2, 3, 4, 5, 7

length1 dd 10
length2 dd 9
length3 dd 8
length4 dd 7

ip dd 0
copyEax dd 0
copyEbx dd 0
copyEcx dd 0

value dd 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    JMP SKIP_FUNC_MAX
    
    ;записывает в edx последнее четное в массиве или -1 если не найдено
    ;вверху стека кладётся ссылка массива 
    ;дальше в стеке хранится длина массива
    FindLastEvenInArray:
        ;сохраняет значения регистров, которые будут исользоваться
        mov [copyEax], eax
        mov [copyEbx], ebx
        mov [copyEcx], ecx
 
        ;достаём значение IP регистра
        pop eax
        mov [ip], eax
        
        pop ecx ;достаём длину массива
        pop ebx ;достаем массив
        
        l1:
            mov edx, 0
        
            mov eax, [ebx + 4 * (ecx - 1)]
            
            mov [value], eax
            
            push ebx ;сохраняем ссылку на массив
            
            mov ebx, 2
            div ebx
            
            pop ebx ;достаём ссылку на массив
            
            cmp edx, 0
            jne continue
                mov edx, [value]
                jmp break
            
            continue:
            
            mov edx, -1
        loop l1
        break:
        
        ;возвращаем значение IP регистра
        mov eax, [ip]
        push eax
        
        ;возвращает значения регистров, которые были сохранены
        mov eax, [copyEax]
        mov ebx, [copyEbx]
        mov ecx, [copyEcx]
    ret
    
    SKIP_FUNC_MAX:
    
    mov eax, array1
    push eax
    mov eax, [length1]
    push eax
    call FindLastEvenInArray
    PRINT_DEC 4, edx
    NEWLINE
    
    mov eax, array2
    push eax
    mov eax, [length2]
    push eax
    call FindLastEvenInArray
    PRINT_DEC 4, edx
    NEWLINE
    
    mov eax, array3
    push eax
    mov eax, [length3]
    push eax
    call FindLastEvenInArray
    PRINT_DEC 4, edx
    NEWLINE
    
    mov eax, array4
    push eax
    mov eax, [length4]
    push eax
    call FindLastEvenInArray
    PRINT_DEC 4, edx
    NEWLINE
    
    ret