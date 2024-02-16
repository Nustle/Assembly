assume cs:code, ds:data

data segment
    text1 db "Input first string: $"
    text2 db 13, 10, "Input second string: $"
    newline db 0Dh, 0Ah, '$'
    str1 db 100, 99 dup('$')  
    str2 db 100, 99 dup('$')
data ends

code segment

strcat proc
    push bp 
    mov bp, sp
    mov si, [bp+6] ; str1
    
    
    add si, 2
    mov bx, si 
    find_end:
        mov al, [si]
        cmp al, '$'    
        je found_end   
        inc si         
        jmp find_end

    found_end:
        mov di, [bp+4] ; str2
        add di, 2      

        concat_loop:
            mov al, [di]
            cmp al, '$' 
            je done     
            mov [si], al
            inc di
            inc si
            jmp concat_loop

    done:
        mov byte ptr [si], '$' 
    pop bp
    mov ax, bx
    pop bx
    push ax 
    push bx 
    ret	    
strcat endp


start:
    mov ax, data
    mov ds, ax

    mov ah, 09h
    mov dx, offset text1
    int 21h

    mov ah, 0Ah
    mov dx, offset str1
    int 21h
    
    push dx

    mov ah, 09h
    mov dx, offset text2
    int 21h
    
    mov ah, 0Ah
    mov dx, offset str2
    int 21h
    
    push dx
    
    call strcat

    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    
    mov ah, 09h
    pop dx
    int 21h

    mov ax, 4C00h
    int 21h

code ends
end start
