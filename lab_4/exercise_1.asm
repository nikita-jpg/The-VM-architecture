%include "io.inc"

section .data
mask dd 2147483648 ;маска 10000000000000000000000000000000
first dd 1 ;задаЄм первое число
second dd 2 ;задаЄм второе число
fird dd 3 ; задаЄм третье число

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
   

    mov cx, 3     
    mov eax, [mask] ; храним номер текущего бита с помощью маски
    
    ;ќсновна€ иде€ - побитовое сранвение чисел, начина€ со старшего бита
    max: 
    cmp eax, 0 ;если eax = 0, то все биты 2-х чисел одинаковые
    je bxb
    
    mov ebx, [first]
    mov edx, [second]
    
    ;выдел€ем нужный бит 
    and ebx, eax
    and edx, eax
    
    ;ѕровер€ем, будут ли текущие биты равны
    xor ebx, edx
    cmp ebx, 0
    je le 
    
    ;если оказалось, что они не равны, то бит в одном из чисел 1, в другом 0. ¬ edx бит не помен€лс€
    cmp edx, 0
    jne dxb 
    jmp bxb 
         
                           
    le: ;le - label equal
        shr eax, 1
        jmp max
    
    dxb: ; dx - edx bigger
        mov eax, [second]
        mov [result], eax
        jmp c2
    
    bxb: ; bx - ebx bigger
        mov eax, [first]
        mov [result], eax
        
    c2: 
        cmp dword [flag], 1
        je end
        
        ;в first загружаем наибольшее между 1 и 2 числами
        mov eax, [result]
        mov [first], eax
        ;в second загружаем 3-е число
        mov eax, [fird]
        mov [second], eax
        
        
        mov dword [flag], 1
        mov eax, [mask]
        jmp max
     
    end:     
    PRINT_UDEC 4, [result]
    xor eax, eax
    ret