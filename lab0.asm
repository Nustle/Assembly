assume CS:code, DS:data

data segment
    a db 5
    b db 3
    c db 4
    d db 1
data ends

code segment
start:
    mov AX, data 
    mov DS, AX
    mov CL, 2
    
    mov al, c
    mul d

    shr AX, CL 

    mov BX, AX

    mov al, a
    mul b
    
    sub AX, BX
    mov ah, 4Ch
    int 21h
code ends

end start
