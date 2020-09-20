%include "io.inc"

section .data
arr dw 5, 5, 4, 3, 2, 1
element dw 0
t dw 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    mov cx, [arr]

;����� � ���� ������ ��������    
part_1:;��������
    lEven:
        ;������ ������� ������� � ��������� � ����
        mov ax, cx
        mov bx, 2
        mul bx
        mov dx, [arr + eax]
        push dx
        
        
        ;��������� �������� �� ������ ������� ������� ������.
        mov ax,dx
        mov dx,0
        mov bx, 2
        div bx
       
        cmp dx, 0
        je lEven_even
        jmp lEven_unEven
        
        ;�������� �������� �������
    lEven_even:
        mov eax,0
        mov ax, cx
        mov bx, 2
        mul bx
        mov word [arr + eax], 0
        loop lEven
          jmp part_2
         
         ;�������� ����� ������� ������
        lEven_unEven:
          pop ax
          mov ax,0
          loop lEven
          jmp part_2

;����� � ���� ���������� �������� ��������                
 part_2:     
     mov cx,[arr]
         
     lUnEven:
        mov ax, cx
        mov bx, 2
        mul bx
        mov dx, [arr + eax]
        
        ;���������� ������� � 0. ���� 0,�� ������ �����,�������� �� ���� ����� ��� � �����,
        ;���� �� 0, �� ���������� �������� ����� � ����
        cmp dx, 0
        jne lEven_UnEven
        loop lUnEven
        jmp part_3
        
        lEven_UnEven:
        push dx
        loop lUnEven
        jmp part_3
      

;������ ��� �������� �� ����� � ����� � ������            
part_3:
     mov cx,[arr]
     extraction:
        mov ax, cx
        mov bx, 2
        mul bx

        pop dx
        mov word [arr + eax],dx
        
        loop extraction
        jmp part_4
        
part_4:
    mov cx,[arr]
    
    l1:
    mov ax,cx
    mov bx,2
    mul bx
    mov edx,[arr + eax]
    mov dword [t],edx
    PRINT_UDEC 2,[t]
    dec cx
    cmp cx,0
    jne l1
    
ret