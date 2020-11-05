%include "io.inc"

section .data
mask dd 2147483648 ;����� 10000000000000000000000000000000
first dd 1 ;����� ������ �����
second dd 2 ;����� ������ �����
fird dd 3 ; ����� ������ �����

cur_bit db 31 ; ������� ������������ ���
result dq 0
flag db 0 ; ����� ��� ������ �� ����� ��������� ����� (�� �����, � ����� �����)

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
    mov eax, [mask] ; ������ ����� �������� ���� � ������� �����
    
    ;�������� ���� - ��������� ��������� �����, ������� �� �������� ����
    max: 
    cmp eax, 0 ;���� eax = 0, �� ��� ���� 2-� ����� ����������
    je bxb
    
    mov ebx, [first]
    mov edx, [second]
    
    ;�������� ������ ��� 
    and ebx, eax
    and edx, eax
    
    ;���������, ����� �� ������� ���� �����
    xor ebx, edx
    cmp ebx, 0
    je le 
    
    ;���� ���������, ��� ��� �� �����, �� ��� � ����� �� ����� 1, � ������ 0. � edx ��� �� ���������
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
        
        ;� first ��������� ���������� ����� 1 � 2 �������
        mov eax, [result]
        mov [first], eax
        ;� second ��������� 3-� �����
        mov eax, [fird]
        mov [second], eax
        
        
        mov dword [flag], 1
        mov eax, [mask]
        jmp max
     
    end:     
    PRINT_UDEC 4, [result]
    xor eax, eax
    ret