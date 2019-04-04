data segment
num db 66
data ends
code segment
ASSUME DS:DATA,CS:CODE
start:
mov ax,data
mov ds,ax
mov al,num
cmp al,58
jg char
and al,0fh
jmp skip
char:
	sub al,31h
skip:
	mov bcd,al
	MOV Dl,Al
	ADD Dl,30H
	MOV AH,02H
	INT 21H
	mov ah,4ch
	int 21h
code ends
end start
