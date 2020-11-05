%include "io.inc"

section .data
mask dd 2147483648 ;����� 10000000000000000000000000000000
first dd 4294967294 ;����� ������ �����
second dd 4294967295 ;����� ������ �����
fird dd 4294967293 ; ����� ������ �����

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
   
   
    mov eax, [mask] ; ������ ����� �������� ���� � ������� �����
    mov ebx, [first]
    mov ecx, [second]
    mov edx, [fird]

    ;�������� ���� - ��������� ��������� �����, ������� �� �������� ����
    max: 
    push ecx
    push ebx
    cmp eax, 0 ;���� eax = 0, �� ��� ���� 2-� ����� ����������
    je bxb
    
    ;�������� ������ ��� 
    and ebx, eax
    and ecx, eax
    
    ;���������, ����� �� ������� ���� �����
    xor ebx, ecx
    cmp ebx, 0
    je le 
    
    ;���� ���������, ��� ��� �� �����, �� ��� � ����� �� ����� 1, � ������ 0. � ecx ��� �� ���������
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
        
        mov ebx, [result] ;� ebx ��������� ���������� ����� 1 � 2 �������
        mov ecx, edx ;� ecx ��������� 3-� �����
          
        mov dword [flag], 1
        mov eax, [mask]
        jmp max
 
     
    end:     
    PRINT_UDEC 4, [result]
    xor eax, eax
    ret