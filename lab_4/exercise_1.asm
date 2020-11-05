%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, 0 ;хранит результат сравнения
    mov ebx, 1 ;4294967295
    mov ecx, 2 ;4294967295
    mov edx, 3 ;4294967295
    call max
    PRINT_UDEC 4, eax
    xor eax, eax
    ret
    
    ;Кладёт в eax наибольшее из 3-х чисел
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
    
    ;sdx - one edx bigger
    sdx:
    mov eax, edx
    
    ;sax - second eax bigger
    sax:
    
    ret
    
