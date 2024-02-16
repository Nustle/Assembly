assume cs:code, ds:data

data segment
    text1 db "Input first string: $"
    text2 db 13, 10, "Input second string: $"
    text3 db 13, 10, "Input n: $"
    newline db 0Dh, 0Ah, '$'
    str1 db 100, 99 dup('$')  
    str2 db 100, 99 dup('$')
    n db 100, 99 dup('$')
    buff db 11 dup(' ') , '$'
data ends

code segment

convertNum proc 
    push bp 
    mov bp, sp
    xor ax, ax 
    mov si, [bp+4]
    inc si
    mov cl, [si]
    mov dx, 1
    find_end:
        mov al, [si+1]
        cmp al, 13    
        je convert_loop   
        inc si         
        jmp find_end
    
    convert_loop:
        xor ax, ax 
        mov al, [si]
        sub al, '0'
        mul dl
        add bx, ax 
        mov ax, 10
        mul dx 
        mov dx, ax
        dec si
        loop convert_loop

    mov cx, bx
    pop bp
    ret
convertNum endp

print proc
    mov bx, ax
    mov ah, 09h
    mov dx, offset newline
    int 21h
    mov cx, 10
	mov di, offset buff + 10
    mov ax, bx
	test al, al
	jns printLoop
	
    mov dl, '-'
    mov ah, 02h
    int 21h
                      
    neg bl 
    mov ax, bx

    printLoop:
        xor dx, dx
        div cx
        add dl, '0'
        dec di
        mov [di], dl
        cmp ax, 0
        jnz printLoop

        mov dx, offset buff
        mov ah, 09h
        lea dx, [di]
        int 21h
        ret
print endp

strncmp proc
    push bp 
    mov bp, sp
    mov si, [bp+8] 
    mov di, [bp+6] 
    add si, 2
    add di, 2
    xor ax, ax
    xor dx, dx
    is_equal:
        cmp cl, 0
        je done
        mov al, [si]
        mov bl, [di]
        mov dl, al
        sub dl, bl
        cmp dl, 0
        jne done 
        inc si 
        inc di 
        dec cl
        jmp is_equal

    done:
        mov ax, dx
        pop bp
    ret	    
strncmp endp

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

    mov ah, 09h
    mov dx, offset text3
    int 21h
    
    mov ah, 0Ah
    mov dx, offset n
    int 21h

    push dx

    call convertNum
    call strncmp
    call print

    mov ax, 4C00h
    int 21h

code ends
end start
