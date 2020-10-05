%include "io.inc"

section .data
arr dw 5, 5, 40000, 3, 2, 1
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    mov cx, [arr]

;Кладём в стек чётные значения    
part_1:;работает
    lEven:
        ;достаём элемент массива и сохраняем в стек
        mov ax, cx
        mov bx, 2
        mul bx
        mov edx, [arr + eax]
        push edx
        
        ;проверяем является ли данный элемент массива чётным.
        mov ax,dx
        mov dx,0
        mov bx, 2
        div bx
       
        mov ax, dx
        cmp ax, 0
        je lEven_even
        jmp lEven_unEven
        
        ;зануляем ненужный элемент
    lEven_even:
        mov eax,0
        mov ax, cx
        mov bx, 2
        mul bx
        mov word [arr + eax], 0
        loop lEven
        jmp part_2
         
         ;нечётное число остаётся внутри
     lEven_unEven:
        pop eax
        mov eax,0
        loop lEven
        jmp part_2

;Кладём в стек оставшиеся нечётные значения                
 part_2:     
     mov cx,[arr]
         
     lUnEven:
        mov ax, cx
        mov bx, 2
        mul bx
        mov edx, [arr + eax]
        
        ;сравниваем элемент с 0. Если 0,то чётное число,стоявшее на этом месте уже в стеке,
        ;если не 0, то отправляем нечётное число в стек
        mov ax, dx
        cmp ax, 0
        jne lEven_UnEven
        loop lUnEven
        jmp part_3
        
        lEven_UnEven:
        push edx
        loop lUnEven
        jmp part_3
      

;Достаём все значения из стека и кладём в массив            
part_3:
     mov cx,[arr]
     extraction:
        mov ax, cx
        mov bx, 2
        mul bx

        pop edx
        mov word [arr + eax],dx
        
        loop extraction
        jmp part_4
        
;Выводим данные      
part_4:
    mov cx,[arr]
    
    l1:
    mov ax,cx
    mov bx,2
    mul bx
    mov edx,[arr + eax]
    PRINT_UDEC 2,edx
    PRINT_CHAR ' '
    dec cx
    mov ax, cx
    cmp ax,0
    jne l1
    
ret