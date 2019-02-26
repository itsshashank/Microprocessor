data segment
    max dw 5
    temp dw 0
    k dw 0
data ends
code segment
assume ds:data,cs:code
proc printprime
       ; mov dx,ax
       ; mov ah,02h
       ; add dx,"00"
       ; int 21h
       mov ah,0h
       mov al,bl
       mov dl,10
       div dl
       add ax,"00"
       mov dx,ax
       mov ah,02h
       int 21h
       mov dl,dh
       int 21h
       mov dx,0
       int 21h
    ret
endp
proc isprime
    mov temp,ax
    mov dx,0

    mov k,2
    div k ; n/2

    mov cx,AX

    mov dx,0
    looptocheck:
        mov ax,temp
        mov dx,0    
        cmp cx,1
        JE E
        div CX
        CMP DX,0
        JE smallnum
        DEC CX
        cmp cx,1
        jne looptocheck
    E:  MOV DX,1
        ret
    smallnum:
        ret
endp
start:
    mov ax,data
    mov ds,ax
    
    mov ah,01h
    int 21h

    sub ax,"0"
    mov ah,0
    mov max,ax
    mov ah,02h
    add dx,13
    int 21h
    mov bx,2
    tilln:
        mov ax,bx
        call isprime
        cmp dx,0
        je equal
        mov ax,bx
        call printprime
        equal:
            inc bx 
            cmp bx,max
            jle tilln

    mov ah,4ch
    int 21h
    code ends
end start
