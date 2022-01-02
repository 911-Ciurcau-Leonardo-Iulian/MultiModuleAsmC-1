bits 32

extern _scanf

global _ReadFirst

; int ReadFirst(int *n, char *s)
; n - the number of strings to be read
; s - the first string
; reads n and s, if n is <= 0, the function returns -1, otherwise 0

segment data use32
    formatInt db "%d",0
    formatString db "%s",0

segment code use32
_ReadFirst:
    ; creating a stack frame
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]      ; eax = the adress of n
    mov ebx, [ebp+12]     ; ebx = the adress of s
    
    push eax
    push ebx
    
    ; scanf("%d", n)
    push eax
    push dword formatInt
    call _scanf
    add esp, 4*2
    
    pop ebx
    pop eax
    
    mov ecx, [eax]  ; ecx = n
    
    cmp ecx, 0
    jle .SmallerOrEqual    
        ; if(n>0)
        
        ;scanf("%s", s)
        push ebx
        push dword formatString
        call _scanf
        add esp, 4*2
        
        mov eax, 0    ; the return value
    .SmallerOrEqual:
        mov eax, -1   ; the return value
    
    ; retrieving the old stack frame
    mov esp, ebp
    pop ebp
    ret