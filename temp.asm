[org 0x0100]
 
 jmp start
 
title: db 'TETRIS'
titlelength: dw 6

name1: db 'Abdullah Khawaja' 
name1len : dw 16

name2: db 'Syed Ammad Ali' 
name2len : dw 14

press: db 'Enter any key to play!' 
presslen: dw 22

nextshape : db 'NEXT SHAPE'
nextlen : dw 10

stime: db 'TIME LEFT'
timerlength: dw 9
time : db '01:58'
timelength : dw 5

sscore : db 'SCORE!' 
sscorelen: dw 6
score : db '00000018'
scorelen: dw 8


message: db 'GAME OVER!'
sp1: db '          '
msg2: db 'YOUR SCORE: 18'
sp2: db '              '
 
 

delay:

push cx
push dx

mov cx, 0xFFFF

now: 

mov dx, 0x001A

taha: 
dec dx
jnz taha

loop now

pop dx
pop cx

ret
 
clrscr: 
push ax
push cx
push es
push di

mov ax, 0xb800
mov es, ax
xor di, di
mov ax, 0x0720
mov cx, 2000

cld
rep stosw

pop di
pop es
pop cx
pop ax

ret

bg:

push ax
push es
push di
push cx

mov ax,0xb800
mov es, ax
mov di, 0
mov cx, 0

top: 
mov word [es:di], 0x7020
mov word [es:di+160], 0x7020
add di, 2
cmp di, 160
jne top


left:

mov word[es:di], 0x7020
mov word[es:di+2], 0x7020
mov word[es:di+4], 0x7020
add di, 160
cmp di, 3680
jne left
 

bottom:

mov word[es:di], 0x7020
mov word[es:di+160], 0x7020
add di, 2 
cmp di, 3840
jne bottom

 
right:
	mov di, 96
	add di, cx 
	mov ax, 3776
	add ax, cx
	
	grid:
		mov word [es:di], 0x7020
		add di, 160
		cmp di, ax
		jne grid		
		
		add cx, 2
		cmp cx, 64
		jne right
	
pop cx
pop di
pop es
pop ax
ret  

startscreen:
push ax
push cx
push es
push di

mov ax, 0xb800
mov es, ax
xor di, di
mov ax, 0x7020
mov cx, 2000

cld
rep stosw

mov ax, 0xb800
	mov es, ax
	mov di, 0

upborder:
	mov word[es:di], 0x4020
	add di, 2
	cmp di, 158
	je rightborder
	mov word[es:di], 0x2020
	add di, 2
	cmp di, 158
	je rightborder 
	mov word[es:di], 0x1020
	add di, 2
	cmp di, 158
	je rightborder
	
	jmp upborder

rightborder:

	mov word[es:di], 0x2020
	add di, 160
	cmp di, 3998
	je bottomborder
	mov word[es:di], 0x1020
	add di, 160
	cmp di, 3998
	je bottomborder 
	mov word[es:di], 0x4020
	add di, 160
	cmp di, 3998
	je bottomborder
	
	jmp rightborder

bottomborder:

	mov word[es:di], 0x2020
	sub di, 2
	cmp di, 3840
	je leftborder
	mov word[es:di], 0x1020
	sub di, 2
	cmp di, 3840
	je leftborder 
	mov word[es:di], 0x4020
	sub di, 2
	cmp di, 3840
	je leftborder
	jmp bottomborder

leftborder:
	mov word[es:di], 0x1020
	sub di, 160
	cmp di, 0
	je printtetris
	mov word[es:di], 0x4020
	sub di, 160
	cmp di, 0
	je printtetris
	mov word[es:di], 0x2020
	sub di, 160
	cmp di, 0
	je printtetris
	
	jmp leftborder
	
	
printtetris: 
	mov ax, 0xb800
	mov es, ax
	mov di, 1994
	mov word[es:di], 0x7154
	mov di, 1996
	mov word[es:di], 0x7245
	mov di, 1998
	mov word[es:di], 0x7454
	mov di, 2000
	mov word[es:di], 0x7152
	mov di, 2002
	mov word[es:di], 0x7249
	mov di, 2004
	mov word[es:di], 0x7453
	

	mov ax, 1498
	push ax
	mov ax, press
	push ax
	push word[presslen] 
	call prints
	pop ax
	 
	mov ax, 2464
	push ax
	mov ax, name1
	push ax
	push word[name1len] 
	call prints
	pop ax

	mov ax, 2626
	push ax
	mov ax, name2
	push ax
	push word[name2len] 
	call prints
	pop ax	
	
	
pop di
pop es
pop cx
pop ax

ret



shapeL:

push bp
mov bp, sp
push es
push ax
push di


mov ax, 0xb800
mov es, ax
xor di, di

mov al, 80 
mul byte [bp+4] 
add ax, [bp+6] 
shl ax, 1 

mov di,ax 


mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x2F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right


sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2

add di, 2
mov word[es:di], 0x2F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2

add di, 2
mov word[es:di], 0x2F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

add di, 160
mov word[es:di], 0x0F7C ; right
sub di, 2
mov word[es:di], 0x2F5F ; down
sub di, 2
mov word[es:di], 0x0F7C ; left

pop di
pop ax
pop es
pop bp

ret 4



shapesquare:

push bp
mov bp, sp
push es
push ax
push di

mov ax, 0xb800
mov es, ax
xor di, di

mov al, 80 
mul byte [bp+4] 
add ax, [bp+6] 
shl ax, 1 

mov di,ax 

mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x1F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right


sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
;mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x1F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

add di, 160
;mov word[es:di], 0x0F5F ;up
;add di, 160
;sub di, 2
mov word[es:di], 0x0F7C ; right
sub di, 2
mov word[es:di], 0x1F5F ; down
sub di, 2
mov word[es:di], 0x0F7C ; left

sub di, 2
mov word[es:di], 0x1F5F ; down
sub di, 2
mov word[es:di], 0x0F7C ; left

pop di
pop ax
pop es
pop bp

ret 4


shapestraight:

push bp
mov bp, sp
push es
push ax
push di


mov ax, 0xb800
mov es, ax
xor di, di

mov al, 80 
mul byte [bp+4] 
add ax, [bp+6] 
shl ax, 1 

mov di,ax 


mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x4F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right


sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2

add di, 2
mov word[es:di], 0x4F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2

add di, 2
mov word[es:di], 0x4F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2

add di, 2
mov word[es:di], 0x4F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right


pop di
pop ax
pop es
pop bp

ret 4

shapezee:
push bp
mov bp, sp
push es
push ax
push di


mov ax, 0xb800
mov es, ax
xor di, di

mov al, 80 
mul byte [bp+4] 
add ax, [bp+6] 
shl ax, 1 

mov di,ax 


;mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
;mov word[es:di], 0x0F7C ; left
add di, 2
;mov word[es:di], 0x4F5F ; down
add di, 2
;mov word[es:di], 0x0F7C ; right


sub di, 160
add di, 2
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x3F5F ; down
add di, 2
mov word[es:di], 0x0F7C ; right

add di, 160
mov word[es:di], 0x0F7C ; right
sub di, 2
mov word[es:di], 0x3F5F ; down
sub di, 2
mov word[es:di], 0x0F7C ; left

sub di, 162
mov word[es:di], 0x0F5F ;up
add di, 160
sub di, 2
mov word[es:di], 0x0F7C ; left
add di, 2
mov word[es:di], 0x3F5F ; down

add di, 162
mov word[es:di], 0x0F7C ; right
sub di, 2
mov word[es:di], 0x3F5F ; down
sub di, 2
mov word[es:di], 0x0F7C ; left



pop di
pop ax
pop es
pop bp

ret 4

prints:
push bp
mov bp, sp 
push es
push ax
push cx
push si 
push di 

mov ax, 0xb800
mov es, ax
mov di, [bp+8]
mov si,[bp+6] 
mov cx,[bp+4] 
mov ah, 0x70

nextchar: 
mov al, [si]
mov [es:di], ax
add di , 2
add si, 1
loop nextchar

pop di 
pop si 
pop cx
pop ax
pop es
pop bp 
ret 4 

nextpanel:

push ax
push es
push di
push dx
push cx

mov di, 424
mov dx, di

mov ax, 0xb800
mov es, ax

mov ax, 7

mov cx, 24
l1: mov word[es:di], 0x0720
add di, 2
loop l1

add dx, 160
mov di, dx
mov cx, 24
dec ax
jnz l1

mov ax, 62
push ax
mov ax, 5
push ax
call shapesquare

mov ax, 598
push ax
mov ax, nextshape
push ax
push word[nextlen] 
call prints
pop ax


pop cx
pop dx
pop di
pop es
pop ax

ret

timepanel:
 
push ax
push es
push di
push dx
push cx

mov di, 1864
mov dx, di

mov ax, 0xb800
mov es, ax

mov ax, 5

mov cx, 24
l2: mov word[es:di], 0x0720
add di, 2
loop l2

add dx, 160
mov di, dx
mov cx, 24
dec ax
jnz l2
 
mov ax, 2038
push ax
mov ax, stime
push ax
push word[timerlength] 
call prints
pop ax

mov ax, 2362
push ax
mov ax, time
push ax
push word[timelength]
call prints 
pop ax
 
 
pop cx
pop dx
pop di
pop es
pop ax

ret
 
scorepanel:
 
push ax
push es
push di
push dx
push cx

mov di, 2984
mov dx, di

mov ax, 0xb800
mov es, ax

mov ax, 5

mov cx, 24
l3: mov word[es:di], 0x0720
add di, 2
loop l3

add dx, 160
mov di, dx
mov cx, 24
dec ax
jnz l3
 
mov ax, 3162
push ax
mov ax, sscore
push ax
push word[sscorelen] 
call prints
pop ax

mov ax, 3480
push ax
mov ax, score
push ax
push word[scorelen]
call prints 
pop ax
 
 
pop cx
pop dx
pop di
pop es
pop ax

ret



endscr:
push ax
push es
push bx
push cx
push di
push bp
push dx


mov ah, 0
int 0x16

call delay
call clrscr

mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 0xF
mov dx, 0x0C1F ; row and then column 
mov cx, 10 ; length of string
push cs
pop es ; segment of string
mov bp, message ; offset of string
int 0x10 ; call BIOS video service

mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 0xF
mov dx, 0x0E1F ; row and then column 
mov cx, 14 ; length of string
push cs
pop es ; segment of string
mov bp, msg2 ; offset of string
int 0x10 ; call BIOS video service



mov di, 1150
mov dx, di

mov ax, 0xb800
mov es, ax
mov ax, 0xCE5F

mov cx, 12

left1: mov [es:di], ax
add di, 2
mov [es:di], ax
sub di, 2
add di, 160
loop left1

mov cx, 43
cld
rep stosw


mov di, dx
mov cx, 43
cld
rep stosw

mov cx, 12

mov [es:di], ax
add di, 2
mov [es:di], ax
sub di, 2

right1: add di, 160
mov [es:di], ax
add di, 2
mov [es:di], ax
sub di, 2
loop right1



mov ax, 6 ;column position
push ax
mov ax, 3 ;row position
push ax
call shapezee




mov ax, 68 ;column position
push ax
mov ax, 4 ;row position
push ax
call shapestraight



mov ax, 70 ;column position
push ax
mov ax, 20 ;row position
push ax
call shapeL


mov ax, 5 ;column position
push ax
mov ax, 20 ;row position
push ax
call shapesquare



pop dx
pop bp
pop di
pop cx
pop bx 
pop es
pop ax

ret
 
 
 
 
 printnum:     
	push bp            
    mov  bp, sp 
	add sp,2
	push es       
	push ax        
	push bx         
	push cx          
	push dx           
    push di  
	mov dx,[bp+8]
	mov [bp-2],dx
    mov  ax, 0xb800        
	mov  es, ax   
	mov  ax, [bp+4]        
	mov  bx, 10            
	mov  cx, 0   
	nextdigit:   
	mov  dx, 0       
	div  bx             
	add  dl, 0x30        
	push dx                
	inc  cx            
	cmp  ax, 0              
	jnz  nextdigit         
    mov  di, [bp+6] 
	nextpos:      
		pop  dx               
		mov  dh, [bp+8]       
		mov [es:di], dx        
		add  di, 2           
		loop nextpos          
		pop  di         
		pop  dx          
		pop  cx           
		pop  bx           
		pop  ax            
		pop  es  
		sub sp,2
		pop  bp         
	ret  6  
 
 
 
 
scrolldown: 
	push bp 
	 mov bp,sp 
	 push ax 
	 push cx 
	 push si 
	 push di 
	 push es 
	 push ds 
	 
	 
	 mov ax, 0xb800
	 mov es, ax
	 
	 xor di, di
	 
	 l8: add di, 2
	 ;cmp word[es:di], 0x0720



	 mov ax, [es:di]
	 cmp ax, 0x0720
	 jne l8
	 sub di, 2
	 
	 mov si, di ;starting position stored
	 ;shr si, 1
	 ;push si
	 shl si, 1 ; converted to byte offset
	 mov bx, si
	 
	 
	xor di, di
	 
	l9:  add di, 2
	cmp word[es:di], 0x0720
	je l9

	sub di, 2
	shr di, 1 ;no. of cols in one line to be scrolled; stored
	mov cx, di
	push cx

	shl di, 1

	sub di, 2
	add bx, di ;actual si

	redo: add di, 160
	cmp word[es:di], 0x0720
	jne exit8

	mov dx, di ; saving val of di in dx like saved val of si in bx

	mov si, bx
	mov ax, 0xb800 
	mov es, ax ; point es to video base 
	mov ds, ax ; point ds to video base 
	 
	 std ; set auto decrement mode 
	 rep movsw ; scroll up 

	 mov ax, 0x0720 ; space in normal attribute 
	 pop cx
	 push cx
	 rep stosw ; clear the scrolled space 
	pop cx

	mov di, dx
	mov si, bx
	add bx, 160
	jmp redo


 
 exit8:
 pop ds 
 pop es 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop bp 
 ret 
 
 
 start:
 
 call clrscr
 
 ; call startscreen
 
 ; mov ah, 0x1
 ; int 0x21
 
 ; call delay
 ; call clrscr
 
 
 call bg
 call nextpanel
 call timepanel
 call scorepanel
 
mov ax, 74
push ax
mov ax, title
push ax
push word[titlelength] 
call prints


mov ax, 4
push ax
mov ax, 20
push ax
call shapesquare

mov ax, 9
push ax
mov ax, 21
push ax
call shapestraight
 
mov ax, 13 ;column position
push ax
mov ax, 20 ;row position
push ax
call shapeL

mov ax, 20
push ax
mov ax, 21
push ax
call shapestraight

mov ax, 29
push ax
mov ax, 20
push ax
call shapesquare

mov ax, 37
push ax
mov ax, 21
push ax
call shapestraight 

mov ax, 42 ;column position
push ax
mov ax, 20 ;row position
push ax
call shapeL

mov ax, 30 ;column position
push ax
mov ax, 12 ;row position
push ax
call shapezee

 mov ax,0xb800
 mov es,ax
	 mov bx,0x1E
	push bx
	push 320
	push word [es:4]
    call printnum

;call scrolldown

;call endscr
 

mov ax, 0x4c00 
int 0x21