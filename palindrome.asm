data segment
    msg1 db "enter A string:",24h
    pal db "string is a palindrome",24h
    notpal db "string is not a palindrome",24h
    str1 db 25 dup('-')
    len db ?
data ends
code segment
assume cs:code,ds:data
print macro m
mov ah,09h
mov dx,offset m
int 21h
endm
start:
    mov ax,data
    mov ds,ax

    print msg1
    call accept_string
    mov si,offset str1
    mov cl,str1+1        ;store the length
    mov ch,00h
    mov len,cl
    inc si
    add si,cx            
    mov di,offset str1   
    add di,0002h         
    mov cl,len ;load counter
    cmpagain: 
            mov al,[si]
            mov ah,[di]
            inc di
            dec si
            cmp al,ah
            jne nopalin
            dec cl
            jnz cmpagain
                
            print pal
            jmp skip		
    nopalin: 
            print notpal		
    skip:
    mov ah,4ch
    int 21h
   
accept_string proc near
    mov ah,0ah          
    mov dx,offset str1 
    int 21h
    ret
accept_string endp
code ends
end start
