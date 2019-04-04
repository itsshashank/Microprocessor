data segment
mat db 1h,2h,3h,4h,5h,6h,7h,8h,9h
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov bl,03h
mov cl,03h
mov si,offset mat
xor ax,ax
next:
	mov al,[si]
	add si,3
	MOV Dl,al
	ADD Dl,30H
	MOV AH,02H
	INT 21H
	loop next
	sub si,09h
	dec bl
	cmp bl,0h
	jz exit
again:
	inc si
	mov cl,03h
	jmp next
exit:
	mov ah,4ch
	int 21h
code ends
end start
