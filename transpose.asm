data segment
    MSG1 DB "MATRIX",0AH,24H
    MSG2 DB "AFTER TRANSPOSE",0AH,24H
    M db 1,2,3,4
    n db 4 dup()
    nl db 0ah
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    mov bl,2
    mov cl,2
    mov si,offset M
    xor ax,ax
    MOV AH,09H
    MOV DX,offset MSG1
    INT 21h

    mrow:
        mov dl,[si]
        inc si
        add dl,30h
        mov ah,02h
        int 21h
        loop mrow
        dec bl
        jz tra
    mcol:
        mov ah,02h
        mov dl,nl
        int 21h
        mov cl,2
        jmp mrow
    tra:
    mov ah,02h
    mov dl,nl
    int 21h
    mov bl,2
    mov cl,2
    mov si,offset M
    mov di,offset n
    xor ax,ax
    row:
        mov al,[si]
        add si,2
        mov [di],al
        inc di
        loop row
        sub si,4
        dec bl
        cmp bl,0
        jz printn
    col:
        inc si
        mov cl,2
        jmp row
    printn:
    mov bl,2
    mov cl,2
    mov si,offset n
    xor ax,ax
    MOV AH,09H
    MOV DX,offset MSG2
    INT 21h
    
    nrow:
        mov dl,[si]
        inc si
        add dl,30h
        mov ah,02h
        int 21h
        loop nrow
        dec bl
        jz skip
    ncol:
        mov ah,02h
        mov dl,nl
        int 21h
        mov cl,2
        jmp nrow

    skip:
    mov ah,4ch
    int 21h
code ends
end start
