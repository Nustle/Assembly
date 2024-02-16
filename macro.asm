print macro string
    mov ah, 09h 
    mov dx, offset string
    int 21h
endm

input macro buff 
    mov ah, 0Ah 
    mov dx, offset buff
    int 21h
endm 

deleteDecimal macro string, result
    mov si, offset string
    mov cl, [si+1]
   
    mov di, offset result
    add si, 2
    add di, 2

    mov dl, 1

    deleteLoop:
        mov al, [si]
        cmp al, '9'
        jg nextChar
        cmp al, '0'
        jl nextChar

        shiftResult:
            dec di
            dec dl 
            mov bl, [di]
            cmp dl, 0
            je shiftString
            cmp bl, 32 
            jne shiftResult
            jmp shiftString
        
        shiftString:
            inc si 
            mov bl, [si]
            cmp bl, '$'
            je deleteLoopEnd
            cmp bl, 32
            jne shiftString
            
            jmp deleteLoopEnd

        nextChar:
            mov [di], al 

        deleteLoopEnd:
            inc di 
            inc si
            inc dl
            loop deleteLoop
endm
