%include "io.inc"

section .data
Vec1: Times 60 dd     10000,        10010,        10020,        10030,        10040
Vec2: Times 60 dd     20000,        20010,        20020,        20030,        20040
;               200 000 000 + 200 300 100 + 200 600 400 + 200 900 900 + 201 201 600 = 1 003 003 000
;� ����� 60 180 180 000

length dw 300

prefix dd 4278190080 ;
perep dd 16777215 ;1��,23 ���� � �����. ��

sum1 dd 0; ������ 32 ���� �����
sum2 dd 0; ������ 32 ���� �����

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