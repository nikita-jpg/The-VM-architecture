%include "io.inc"

section .data
;Vec1: Times 300 dd 1
;Vec2: Times 300 dd 1
;� ����� 300

;Vec1: Times 300 dd 8388607
;Vec2: Times 300 dd 8388607
;� ����� 21 110 618 220 134 750

;Vec1: Times 300 dd -8388607
;Vec2: Times 300 dd -8388607
;� ����� 21 110 618 220 134 750

;Vec1: Times 300 dd -1
;Vec2: Times 300 dd -1
;� ����� 300

;Vec1: Times 300 dd 1
;Vec2: Times 300 dd -1
;� ����� -300

;Vec1: Times 300 dd -8388607
;Vec2: Times 300 dd 8388607
;� ����� - 21 110 618 220 134 750

Vec1: Times 50 dd -8388607, -8388607, -8388607, -8388607, -8388607, -8388607
Vec2: Times 50 dd 8388607, 8388607, 8388607, -8388607, -8388607, -8388607
;� ����� 0

;������������ ���������� ��� ����� 23��� * 2 + 1���(��� �����) + 9 (���-�� ����� ��� ����� 300)��� = 56 ���

length dw 300

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
        mov edx, 0
    
        ;������ �������� � ���������� ��������
        mov eax, [Vec1 + 4 * (ecx - 1)]
        mov ebx, [Vec2 + 4 * (ecx - 1)]
        
        ;����������� ��
        imul ebx
        mov ebx, eax
        
        ;���������� � ��� ������������ ������
        mov eax, [sum1]
        add eax, ebx
        mov [sum1], eax
        
        mov eax, [sum2]
        adc eax, edx
        mov [sum2], eax
        
    loop l1
    
    ;�����
    PRINT_HEX 4, [sum2]
    PRINT_CHAR " "
    PRINT_HEX 4, [sum1]
ret