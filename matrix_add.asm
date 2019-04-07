data segment
    MSG1 DB "enter MATRIX ",0AH,24H
    MSG2 DB "SUM",0AH,24H
    M db 4 dup()
    n db 4 dup()
    sum db 4 dup()
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
        mov ah,01h
        int 21h
        mov [si],al
        inc si
        loop mrow
        dec bl
        jz nin
    mcol:
        mov ah,02h
        mov dl,nl
        int 21h
        mov cl,2
        jmp mrow
    nin:
    mov ah,02h
    mov dl,nl
    int 21h
    mov bl,2
    mov cl,2
    mov si,offset n
    MOV AH,09H
    MOV DX,offset MSG1
    INT 21h
    nrow:
        mov ah,01h
        int 21h
        mov [si],al
        inc si
        loop nrow
        dec bl
        jz msum
    ncol:
        mov ah,02h
        mov dl,nl
        int 21h
        mov cl,2
        jmp nrow
    
    msum:
    mov bl,2
    mov cl,2
    mov si,0
    mov di,offset sum
    xor ax,ax
    row:
        mov al,[si+M]
        mov ah,[si+n]
        add al,ah
        sub al,30h
        mov [di],al
        inc di
        inc si
        loop row
        dec bl
        cmp bl,0
        jz printn
    col:
        mov cl,2
        jmp row
    printn:
    mov ah,02h
    mov dl,nl
    int 21h
    mov bl,2
    mov cl,2
    mov si,offset sum
    xor ax,ax
    MOV AH,09H
    MOV DX,offset MSG2
    INT 21h
    
    sumrow:
        mov dl,[si]
        inc si
        mov ah,02h
        int 21h
        loop sumrow
        dec bl
        jz skip
    sumcol:
        mov ah,02h
        mov dl,nl
        int 21h
        mov cl,2
        jmp sumrow

    skip:
    mov ah,4ch
    int 21h
code ends
end start
