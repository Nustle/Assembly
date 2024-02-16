assume CS:code, DS:data

data segment
    a db 50
    b db 5
    c db 40
    d db 2
    res10 db 3 dup(), 10, '$'
    res16 db 2 dup(), '$'
data ends

code segment
start:
    mov AX, data
    mov DS, AX
    mov AX, 0h 

    ; a*b - (c*d)/4
    mov CL, 2
    mov al, c
    mul d
    shr AX, CL
    mov BX, AX
    mov al, a
    mul b
    sub AX, BX
    mov CX, AX

    ; перевод в десятичную систему
    mov BL, 10
    mov SI, 2
convert_loop_10:
    xor AH, AH
    div BL
    mov res10[SI], AH
    add res10[SI], '0'
    dec SI
    test AL, AL
    jnz convert_loop_10

    ; вывод в десятичной системе
    mov DX, offset res10
    mov AH, 09h
    int 21h

    ; перевод в шестнадцатиричную систему
    mov AX, CX
    mov BL, 16
    mov SI, 1
convert_loop_16:
    xor AH, AH
    div BL
    cmp AH, 10
    jl digit
    jge symbol
digit:
    add AH, '0'
    jmp continue
symbol:
    add AH, 55
continue:
    mov res16[SI], AH
    dec SI
    test AL, AL
    jnz convert_loop_16

    ; вывод в шестнадцатиричной системе
    mov DX, offset res16
    mov AH, 09h
    int 21h
    
    mov AX, 4C00h
    int 21h
code ends
end start
