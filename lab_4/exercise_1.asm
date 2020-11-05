%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, 0 ;хранит результат сравнения
    mov ebx, 4294967295 ;4294967295
    mov ecx, 4294967295 ;4294967295
    mov edx, 4294967295 ;4294967295
    call max
    PRINT_UDEC 4, eax
    xor eax, eax
    ret
    
    ;возвращает цифру 1,2,3 в зависимости от номера наибольшего их 3-х чисел. 0, если все числа равны
max:
    c1:
    cmp ebx, ecx
    jge fbx
    
    ;fcx - first ecx bigger
    fcx:
    mov eax, ecx
    jmp c2
    
    ;fbx - first ebx bigger
    fbx:
    mov eax, ebx
   
    
    c2:
    cmp eax, edx
    jge sax
    
    ;tedb - one edx bigger
    sdx:
    mov eax, edx
    
    ;seab - second eax bigger
    sax:
    
    ret
    
