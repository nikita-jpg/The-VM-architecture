%include "io.inc"

section .data
Vec1: Times 60 dd     1000000000,        1001000000,        1002000000,        1003000000,        1004000000
Vec2: Times 60 dd     2000000000,        2001000000,        2002000000,        2003000000,        2004000000
;               2 000 000 000 000 000 000 + 2 003 001 000 000 000 000 + 2 006 004 000 000 000 000
; + 2 009 009 000 000 000 000 + 2 012 016 000 000 000 000 = 10 030 030 000 000 000 000
;� ����� 601 801 800 000 000 000 000

length dw 300

sum1 dd 0; ������ 32 ���� �����
sum2 dd 0; ������ 32 ���� �����
sum3 dd 0; ������ 32 ���� �����

sum

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;�������� ��������
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    
    ;������� ������
    mov ecx, [length]
    
    l1:    
        mov edx, 0
    
        ;������ �������� � ���������� ��������
        mov eax, [Vec1 + 4 * (ecx - 1)]
        mov ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;����������� ��
        mul ebx
        mov ebx, eax
        
        ;���������� � ��� ������������ ������
        mov eax, [sum1]
        add eax, ebx
        mov [sum1], eax
        
        mov eax, [sum2]
        adc eax, edx
        mov [sum2], eax
        
        mov eax, [sum3]
        adc eax, 0
        mov [sum3], eax
    loop l1
    
    ;�����
    mov eax, [sum1]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum2]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum3]
    PRINT_UDEC 4, eax
ret