include macro.asm

assume cs:code, ds:data

data segment
    text db "Input string: $"
    newline db 0Dh, 0Ah, '$'
    string db 100, 99 dup('$')  
    result db 100, 99 dup('$')  
data ends

code segment

start:
    mov ax, data
    mov ds, ax

    print text
    input string

    deleteDecimal string, result

    print newline
    print result+2

    mov ax, 4C00h
    int 21h
code ends
end start
