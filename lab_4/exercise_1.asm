%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, 0 ;������ ��������� ���������
    mov ebx, 4294967295 ;4294967295
    mov ecx, 4294967295 ;4294967295
    mov edx, 4294967295 ;4294967295
    call max
    PRINT_UDEC 4, eax
    xor eax, eax
    ret
    
    ;���������� ����� 1,2,3 � ����������� �� ������ ����������� �� 3-� �����. 0, ���� ��� ����� �����
max:
    c1:
    cmp ebx, ecx
    jge fbx
    
    ;fcx - first ecx bigger
    fcx:
    mov eax, ecx
    jmp c2
    
    ;fbx - first ebx bigger
    fbx:
    mov eax, ebx
   
    
    c2:
    cmp eax, edx
    jge sax
    
    ;tedb - one edx bigger
    sdx:
    mov eax, edx
    
    ;seab - second eax bigger
    sax:
    
    ret
    
