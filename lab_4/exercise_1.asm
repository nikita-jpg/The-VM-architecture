%include "io.inc"

section .data
mask dd 2147483648 ;маска 10000000000000000000000000000000
first dd 4294967294 ;задаЄм первое число
second dd 4294967295 ;задаЄм второе число
fird dd 4294967293 ; задаЄм третье число

cur_bit db 31 ; текущий сравниваемый бит
result dq 0
flag db 0 ; Ќужен дл€ выхода из цикла сравнений чисел (не битов, а самих чисел)

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, 0
    mov ebx, 0 
    mov ecx, 0
    mov edx, 0 
   
   
    mov eax, [mask] ; храним номер текущего бита с помощью маски
    mov ebx, [first]
    mov ecx, [second]
    mov edx, [fird]

    ;ќсновна€ иде€ - побитовое сранвение чисел, начина€ со старшего бита
    max: 
    push ecx
    push ebx
    cmp eax, 0 ;если eax = 0, то все биты 2-х чисел одинаковые
    je bxb
    
    ;выдел€ем нужный бит 
    and ebx, eax
    and ecx, eax
    
    ;ѕровер€ем, будут ли текущие биты равны
    xor ebx, ecx
    cmp ebx, 0
    je le 
    
    ;если оказалось, что они не равны, то бит в одном из чисел 1, в другом 0. ¬ ecx бит не помен€лс€
    cmp ecx, 0
    jne cxb 
    jmp bxb 
         
                           
    le: ; le - label equal
        shr eax, 1
        pop ebx
        pop ecx
        jmp max
    
    cxb: ; cx - ecx bigger
        pop ebx
        pop ecx
        mov [result], ecx
        jmp c2
    
    bxb: ; bx - ebx bigger
        pop eax
        mov [result], eax
        pop eax
        
    c2: 
        cmp dword [flag], 1
        je end
        
        mov ebx, [result] ;в ebx загружаем наибольшее между 1 и 2 числами
        mov ecx, edx ;в ecx загружаем 3-е число
          
        mov dword [flag], 1
        mov eax, [mask]
        jmp max
 
     
    end:     
    PRINT_UDEC 4, [result]
    xor eax, eax
    ret