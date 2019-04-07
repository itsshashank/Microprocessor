data segment
	n dw 1234
	dig dw 4
	divi dw 1000
data ends
code segment
 	assume cs:code,ds:data
 	start:
	mov ax,data
	mov ds,ax

	mov si,divi
	mov di,10
	mov bx,n
pshlop: mov ax,bx
	mov dx,0
	div si
	push ax
	mov bx,dx
	MOV AX,SI
	mov dx,0
	div di
	mov si,ax
	cmp si,0
	jne pshlop
	mov cx,dig
poplop: pop dx
	add dx,"0"
	mov ah,02h
	int 21h
	dec cx
	jnz poplop
mov ah,4ch
int 21h
code ends
end start
