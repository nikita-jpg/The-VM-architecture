%include "io.inc"

section .data
Vec1: Times 60 dd     1000,        1001,        1002,        1003,        1004
Vec2: Times 60 dd     2000,        2001,        2002,        2003,        2004
;               200 000 0 + 200 300 1 + 200 600 4 + 200 900 9 + 201 201 6 = 1 003 003 0
;� ����� 60 180 180 000

;2^32 2^29 2^28 2^26

length dw 300

prefix dd 4278190080 ;
perep dd 16777215 ;1��,23 ���� � �����. ��

sum1 dd 0; ������ 24 ���� �����
sum2 dd 0; ������ 24 ���� �����

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
        
        ;������ �������� � ���������� ��������
        add eax, [Vec1 + 4 * (ecx - 1)]
        add ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;����������� ��
        mul ebx
        mov ebx, eax
        
        ;���� ����� � edx >= perep
        cmp edx, perep
        JG lPerep
        JMP l2
        
        lPerep:
            ;�������� ����� ���, ����� 24�� ��� �������� �� 32�� �������
            sal edx, 8
            ;���� edx >= ����� �����(2^31), �� �� 32�� ������� 1, ����� 0
            cmp edx, 2147483648
            JG lUnit
            sar edx, 8
            JMP l2
        
        ;������ ������� ����� ��� 8������ ����� ���� ����� � 24�� �����
        lUnit:
            ;��������� 8�� ������
            add edx, 8388608
        
        l2:
            ;���������� � ��� ������������ ������
            mov eax, [sum1]
            add eax, ebx
            mov [sum1], eax
        
            mov eax, [sum2]
            adc eax, 0 
            mov [sum2], eax
    loop l1
    

    
    ;�����
    mov eax, [sum1]
    PRINT_UDEC 4, eax
    
    NEWLINE
    
    mov eax, [sum2]
    PRINT_UDEC 4, eax
ret