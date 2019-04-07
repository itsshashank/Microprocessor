mydata segment
    msg db "enter a char:",24h
    num db ?
    nl db 0ah
mydata ends
mycode segment
assume cs:mycode,ds:mydata
start:
    mov ax,mydata
    mov ds,ax

    mov dx,offset msg
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h

    mov num,al

    mov ah,02h
    mov dl,nl
    int 21h

    mov ah,02h
    mov dl,num
    int 21h

    mov ah,4ch
    int 21h
mycode ends
end start
