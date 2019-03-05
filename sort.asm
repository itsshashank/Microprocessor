DATA SEGMENT
	STRING db 03,02,04,06,05
    MSG1 DB "Initial array$"
	MSG2 DB "Array after sort$"
    incj dw 0
    max dw 0
    maxmi dw 0
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
PRINT MACRO MSG
    MOV AH,09H
    LEA DX,MSG
    INT 21H
ENDM
proc printNO
       mov dx,ax
       mov ah,02h
       add dx,"0"
       int 21h
    ret
endp
START:
	MOV AX,DATA
	MOV DS,AX
    
    mov ah,01h
    int 21h

    sub ax,"0"
    mov ah,0
    mov max,ax

    dec ax
    mov maxmi,ax

    LEA SI,STRING
    mov cx,0
    PRINT MSG1
    tillnread:
            ;mov ax,si
            ;add ax,cx
            ;mov si,ax
            mov ax,[si]
            CALL printNO
            inc cx
            inc si
            cmp cx,max
            jl tillnread
    mov cx,0
    mov incj,0
    LEA SI,STRING
    UP2:

    UP1:
        MOV AL,[SI]
        MOV BL,[SI+1]
        CMP AL,BL
        JC DOWN
        MOV DL,[SI+1]
        XCHG [SI],DL
        MOV [SI+1],DL
    DOWN:
        INC incj
        inc si
        mov ax,incj
        cmp ax,max
        JL UP1
        inc cx
        cmp cx,maxmi
        je lopp
        loop UP2
    lopp:
    LEA SI,STRING
    mov cx,0
    PRINT MSG2        
    tillnprint:
            ;mov ax,si
            ;add ax,cx
            ;mov si,ax
            mov ax,[si]
            CALL printNO
            inc cx
            inc si
            cmp cx,max
            jl tillnprint

    MOV AH,4CH
	INT 21H
CODE ENDS
END START
