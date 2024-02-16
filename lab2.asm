data segment	 
    mas dw 1, 1, 1, 1, 1, 1, 0, 1, 1, 0
    len dw ($-mas) / 2
    res dw 0
data ends

code segment	 
start:	 
    assume cs:code, ds:data	 
    mov ax, data	 
    mov ds, ax	 
    mov cx, len	
    mov si, 0
    mov di, 0

counter:
    mov bl, byte ptr [si]
    add si, 2

    cmp bl, 1
    je one
    cmp di, [res]
    jle reset

    mov [res], di
    jmp reset

one:
    inc di
    loop counter 

reset:
    xor di, di
    loop counter

    mov ax, [res]
    add ax, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    mov ax, 4C00h
    int 21h 

code ends	 
end start
