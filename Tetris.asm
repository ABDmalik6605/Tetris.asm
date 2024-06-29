;0x0720 for cls
[org 0x0100]
jmp start
; rndrep: dw 0 
; data:
intro:  db '                       Welcome to Tetris game                                  ',0  
message1:  db '                       IN AN ASSEMBLER FAR FAR AWAY',0          
message2:  db '               EXISTED A GAME WHICH NO ONE COULD EVER WIN',0
message3:  db '         IT WAS A FORETOLD A CHOSEN ONE WOULD COME TO CONQUER IT',0         
message4:  db '                         ARE YOU THE CHOSEN ONE?',0    
score: db 'SCORE: ',0
points: dw 0
next: db ' NEXT',0
timershow: db 'Time  :',0
time:dw 0
ending: db 'Congratulation!',0
ending1: db 'Played well ',0
ending2: db ', you have',0
ending3: db 'Defeated you ',0
ending4: db ', I could not',0
ending5: db 'NOW PRAY FOR YOUR FINALS',0
ending6:db ', I shall',0
ending7:db '"May the force be with you"',0
losing: db 'THE INEVITABLE HAS HAPPENED!',0
losing1: db 'Defeated you ',0
losing2: db ', I have easily',0
losing3: db 'NEXT TIME ',0
losing4:db ', come prepared',0
losing5:db 'Waiting for you ',0
losing6:db ', I shall be',0
losing7:db '"May the force be with you"',0
message8: db 'LOADING...Please Wait',0
message9: db 'Press any key to continue...',0
length:db 20
bar_length equ 30 
delay_count equ 65000 
tickcount: dw 0
tickcount2: dw 0
minute: dw 0
oldkb:dd   0 
rnd: dw 0
rndrep: dw 0 
rotatable: dw 0
sui: dw 0
timeEnd1: db'Your time is over',0
timeEnd2: db 'This is your',0
timeEnd3: db 'last move',0
timeEnd4: db 'Better make it count!',0
space: db'Oops! ran out of space',0
timegone: db 'Time Up!',0
music_length dw 6204
music_data incbin "headache.imf"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Code;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_loading_message:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	push ds
	pop es 
	mov di, [bp+4] 
	mov cx, 0xffff
	xor al, al
	repne scasb 
	mov ax, 0xffff 
	sub ax, cx 
	dec ax 
	jz exit 
	mov cx, ax
	mov ax, 0xb800
	mov es, ax 
	mov al, 80 
	mul byte [bp+8] 
	add ax, [bp+10]
	shl ax, 1 
	mov di,ax 
	mov si, [bp+4] 
	mov ah, [bp+6] 
	cld 
	nextchar: lodsb
	stosw 
	loop nextchar 
	exit: 
		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret 8
draw_loading_screen:
    pusha
    mov ax, 0xb800
    mov es, ax
    mov di, 60 * 30 
    mov cx, bar_length
    mov si, 0 
    mov dx, 0 

draw_bar:
    mov al, 0xA
    mov ah, 0xA;

    stosw 
    inc dx 
    cmp dx, bar_length 
    jge done 
    call sleep 
    loop draw_bar
done:
    popa
    ret
sleep:
    push cx
    mov cx, delay_count
	delay_loop:
		loop delay_loop
		  mov cx, delay_count
	delay_loop1:
		loop delay_loop1
		  mov cx, delay_count
	delay_loop2:
		loop delay_loop2
    pop cx
    ret

clrscr1:      
	push es               
	push ax               
	push di
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di, 0            
	nextloc1:      
		mov  word [es:di], 0x0720 
		add  di, 2             
		cmp  di, 4000           
		jne  nextloc1           
	pop  di          
	pop  ax            
	pop  es              
	ret  
clrarea:      
 push es               
 push ax               
 push di
 mov  ax, 0xb800   
 mov  es, ax         
 mov  di, 916            
	nextloc2:      
		mov  word [es:di], 0x3321
		add  di, 2             
		cmp  di, 934         
		jne  nextloc2
	mov di,1076
	nextloc3:      
		mov  word [es:di], 0x3321
		add  di, 2             
		cmp  di, 1094           
		jne  nextloc3
	mov di,1236
	nextloc4:      
		mov  word [es:di], 0x3321
		add  di, 2             
		cmp  di, 1254          
		jne  nextloc4
	mov di,1396
	nextloc5:      
		mov  word [es:di], 0x3321
		add  di, 2             
		cmp  di, 1414        
		jne  nextloc5
	pop  di          
	pop  ax            
	pop  es              
	ret  
border:
	push es               
	push ax               
	push di
	push bx
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di, 350  
	nextl:    
		mov bx,2
		mov  word [es:di], 0x677C 
		innerclr:
		mov  word [es:di+bx], 0x3321
		add bx,2
		cmp  bx,76
		jne innerclr
		add  di, 160             
		cmp  di, 3840           
		jle  nextl 
	next2:      
		mov  word [es:di], 0x675F 
		add  di, 2             
		cmp  di, 3946        
		jle  next2
	mov  di, 426;420
	next3:      
		mov  word [es:di], 0x677C 
		add  di, 160             
		cmp  di, 3900         
		jle  next3  
	pop  bx
	pop  di          
	pop  ax            
	pop  es              
	ret  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CLEAR SSCREEN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
clrscr:     
;	inc word [time]
	push es               
	push ax               
	push di
	mov  ax, 0xb800   
	mov  es, ax        
	mov di,160
	nextloc0
		mov  word [es:di], 0xEE19
		add di,2
		cmp di,320
		jne nextloc0
	mov  di, 320  ;19
	mov si,400
	nextloc:  
		cmp  word [es:di],0x777C 
		je ne
		cmp di,si
		jg leftarrow
		mov  word [es:di], 0x921A;211A;0xA11A;21 ;10 11
		jmp skip
	leftarrow mov  word [es:di], 0xA11B;B;0xA11B;21 
	skip	add  di, 2  
		jmp cp
	ne :add di,74
	cp:	push di
	check:
		cmp di,160
		jl skip2
		sub di,160
		jmp check
	skip2:
		cmp di,0
		jne skip3
		add si,160
	skip3:	
		pop di
		cmp  di,4000  		
		jne  nextloc   
	pop  di          
	pop  ax            
	pop  es    
	ret  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BOX PRINTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
box:
	push bp
	mov bp,sp
	push di
	push bx
	push ax
	push es
	push cx
	mov ax,0xb800
	mov es,ax	
	mov di,[bp+4]
	mov word [es:di],0x305F ;horizontal bar
	mov word [es:di+158],0x307C
	mov word [es:di+162],0x307C
	mov word [es:di+160],0x305F
	pop cx
	pop es
	pop ax
	pop bx
	pop di
	pop bp
	ret 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SHAPES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
boxes:
	push bp
	mov bp,sp
	push di
	push bx
	push ax
	push es
	push cx
	push si
	mov ax,0xb800
	mov es,ax
	mov di,[bp+4]
	mov si,di
	mov cx,[bp+6]
	cmp cx,4
	jle hline
	cmp cx,8
	jle vline
	cmp cx,10
	je dabba
	cmp cx,11
	jne anonymoushape1
	jmp anonymoushap2
anonymoushape1:
	push si 
	call box
	add si,160
	push si	
	call box
	add si,4
	push si	
	call box
	add si,160
	push si	
	call box
	jmp ppd
	hline:
		push si 
		call box
		add si,4
		push si	
		call box
		add si,4
		push si
		call box
		cmp cx,2
		je l2
		cmp cx,3
		je l3
		; cmp cx,4
		; je l4
		jmp ppd
	vline:
		push si 
		call box
		add si,160
		push si	
		call box
		add si,160
		push si
		call box
		cmp cx,6
		je l6
		cmp cx,7
		je l7
		cmp cx,8
		je l8
		jmp ppd
	dabba:
		push si 
		call box
		add si,4
		push si
		call box
		add di,160
		push di
		call box
		add di,4
		push di
		call box
		jmp ppd
	anonymoushap2:
		push si 
		call box
		add si,4
		push si
		call box
		add di,156
		push di
		call box
		add di,4
		push di
		call box
		jmp ppd
	l2:	
		add di,160
		push di
		call box
		jmp ppd
	l3:	
		add di,164
		push di
		call box
		jmp ppd
	l4:	
		add di,168
		push di
		call box
		jmp ppd
	l6:	
		add di,4
		push di
		call box
		jmp ppd
	l7:	
		add di,164
		push di
		call box
		jmp ppd
	l8:	
		add di,324
		push di
		call box
		jmp ppd	

	ppd:
		pop si
		pop cx
		pop es
		pop ax
		pop bx
		pop di
		pop bp
	ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;STRING PRINTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printstr:     
	push bp            
	mov  bp, sp   
	sub sp,2
	push es          
	push ax             
	push si            
	push di  
	push dx
    mov  ax, 0xb800           
    mov  es, ax           
	mov  di, [bp+6]              
	mov  si, [bp+4]
	mov  dx, [bp+8]  
	mov [bp-2],dx
	mov ah,[bp-2]
	nextchar2:    
		mov  al, [si]        
		mov  [es:di], ax       
		add  di, 2 
		cmp byte [si],0
		je pp
		add  si, 1              
		jmp nextchar2          
	pp:
		pop dx
		pop  di            
		pop  si                   
		pop  ax          
		pop  es  
		add sp,2
		pop  bp         
	ret  6 
delay:
	push cx
	push dx
	push ax
	MOV     CX, 0FH
	MOV     DX, 4240H
	MOV     AH, 86H
	INT     15H
	pop ax
	pop dx
	pop cx
	ret
delaybox:
	push cx
	push dx
	push ax
	MOV     CX, 5h
	MOV     DX, 4240H
	MOV     AH, 86H
	INT     15H
	pop ax
	pop dx
	pop cx
	ret
delay1:
	push cx
	push dx
	push ax
	MOV     CX, 0H
	MOV     DX, 0x500
	MOV     AH, 86H
	INT     15H
	pop ax
	pop dx
	pop cx
	ret
delayrow:
	push cx
	push dx
	push ax
	push di
	MOV     CX, 01H
	MOV     DX, 0x500
	MOV     AH, 86H
	INT     15H
	pop di
	pop ax
	pop dx
	pop cx
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

voiceover:  
	push cx
	push di
	push ax
	push dx
	mov dx,0x06
	mov cx,7
	mov di,3840
	intr:   
		call clrscr1  
		mov  ax, message1  
		push dx	
		push di
		push ax
		call printstr  
		mov  ax, message2   
		add di,160
		push dx
		push di
		push ax
		call printstr  
		mov  ax, message3   
		add di,160
		push dx
		push di
		push ax
		call printstr   
		mov  ax, message4   
		add di,160
		push dx
		push di
		push ax
		call printstr  
		sub di,960
		call delay
		loop intr
		pop dx
		pop ax
		pop di 
		pop cx	
	ret
	
inttimer:        
	push si
	push dx
	push ax
	push bx
	push cx
	mov si,[sui]
;	mov si, 1000 	
mov cx,3
delay90:
;	add si,12
;	.next_note:
		mov dx, 388h
		mov al, [si + music_data + 0]
		out dx, al
		mov dx, 389h
		mov al, [si + music_data + 1]
		out dx, al
		mov bx, [si + music_data + 2]
		mov dx, 388h
		mov al, [si + music_data + 3]
		out dx, al
		add si, 4
	; .repeat_delay:	
		; mov cx, 150
	; .delay:
		; mov ah, 1
		; int 16h
		; jnz .strtmusic
		; loop .delay
		; dec bx
		; jg .repeat_delay
		cmp si, [music_length]
		jb .strtmusic
		mov si,0
;	notendedyet:
;mov [sui],si
	.strtmusic:
	mov word [sui],si
dec cx
cmp cx,0
jne delay90
	
	push ax
	mov ax,0xb800
	mov es,ax
	pop ax
    inc  word [cs:tickcount]
	cmp word [cs:tickcount],18
	jl timeshow 
	inc  word [cs:tickcount2]
	mov  word [cs:tickcount],0
	cmp word [cs:tickcount2],60
	jl timeshow
	inc word [cs:minute]
	mov word [cs:tickcount2],0
	mov word [es:636],0xA11B
	timeshow:
	push 0x1E
	push 634
	push word [cs:tickcount2]  
    call printnum       
	push 0x1E
	push 630
	push word [cs:minute]  
    call printnum 	
    mov  al, 0x20      
	out  0x20, al          
	pop cx
	pop bx
	pop ax
	pop dx
	pop si
    iret 
	
timmer:
	push si
	push dx
	push bx
	push ax
	mov si,620
	mov dx,0x1E
	mov ax,timershow
	push dx
	push si
	push ax
	call printstr                       
	
	pop ax
	pop bx
	pop dx
	pop si
	ret
scoreboard:
	push bx
	push ax
	mov si,460
	mov dx,0x0c
	mov ax,score
	push dx
	push si
	push ax
	call printstr
	mov ax,[points]
	mov bx,0x07
	push bx
	mov bx,472
	push bx
	push ax
	call printnum
	pop ax
	pop bx
	ret
nextbox:
	push ax
	push si 
	call clrarea
	mov ax,next
	push dx
	add si,300
	push si
	push ax
	call printstr
	add si,162
	push cx
	push si
	call boxes
	pop si 
	pop ax
	ret
outro:
	push ax
	push di
	push si
	call delay
	mov ax,ending
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1646
	mov dx,0x04
	mov ax,ending1
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1668
	mov dx,0x03
	mov ax,ending2
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1802
	mov dx,0x03
	mov ax,ending3
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1826
	mov dx,0x04
	mov ax,ending4
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1954
	mov dx,0x04
	mov ax,ending5
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,2002
	mov dx,0x03
	mov ax,ending6
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,2120
	mov dx,0x02
	mov ax,ending7
	push dx
	push si
	push ax
	call printstr
	pop si
	pop di 
	pop ax
	ret
endscreen:      
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di, 980   
	mov si,di
	add si,100
	mov cx,5
	clearing:
		nextbloc:      
			call delay1
			mov  word [es:di], 0x0720 
			add  di, 2             
			cmp  di, si           
			jne  nextbloc 
		sub di,102
		xchg di,si
		add di,158
		add si,160
		nextbloc2:      
			call delay1
			mov  word [es:di], 0x0720 
			sub  di, 2             
			cmp  di, si           
			jne  nextbloc2 
		add di,162
		add si,262
		loop clearing
	mov si,1342
	mov dx,0x03
	mov ax,score
	push dx
	push si
	push ax
	call printstr
	mov ax,[points]
	mov bx,0x03
	push bx
	mov bx,1354
	push bx
	push ax
	call printnum
	mov si,1494
	mov dx,0x04
	call outro
	pop si
	pop  di          
	pop  ax            
	pop  es              
	ret  
	
outro2:
	push ax
	push di
	push si
	call delay
	mov ax,losing
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1642
	mov dx,0x04
	mov ax,losing1
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1668
	mov dx,0x03
	mov ax,losing2
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1806
	mov dx,0x03
	mov ax,losing3
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1826
	mov dx,0x04
	mov ax,losing4
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1962
	mov dx,0x04
	mov ax,losing5
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,1994
	mov dx,0x03
	mov ax,losing6
	push dx
	push si
	push ax
	call printstr
	call delay
	mov si,2124
	mov dx,0x02
	mov ax,ending7
	push dx
	push si
	push ax
	call printstr
	pop si
	pop di 
	pop ax
	ret
losingscreen:      
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di, 980   
	mov si,di
	add si,100
	mov cx,5
	clearingl:
		nextblocl:      
			call delay1
			mov  word [es:di], 0x0720 
			add  di, 2             
			cmp  di, si           
			jne  nextblocl 
		sub di,102
		xchg di,si
		add di,158
		add si,160
		nextbloc2l:      
			call delay1
			mov  word [es:di], 0x0720 
			sub  di, 2             
			cmp  di, si           
			jne  nextbloc2l 
		add di,162
		add si,262
		loop clearingl
	mov si,1342
	mov dx,0x03
	mov ax,score
	push dx
	push si
	push ax
	call printstr
	mov ax,[points]
	mov bx,0x03
	push bx
	mov bx,1354
	push bx
	push ax
	call printnum
	mov si,1484
	mov dx,0x04
	call outro2
	pop si
	pop  di          
	pop  ax            
	pop  es              
	ret  
timeended:        
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di, 910            
	nextloc6:      
		mov  word [es:di],0x4020; 0x3321
		add  di, 2             
		cmp  di, 956         
		jne  nextloc6
	mov di,1070
	nextloc7:      
		mov  word [es:di], 0x0720
		add  di, 2             
		cmp  di, 1116         
		jne  nextloc7
	mov di,1230
	nextloc8:      
		mov  word [es:di],0x4020; 0x3321
		add  di, 2             
		cmp  di, 1276       
		jne  nextloc8
	mov di,1390
	nextloc9:      
		mov  word [es:di], 0x0720
		add  di, 2             
		cmp  di, 1436       
		jne  nextloc9
	push 0x40;30
	push 916
	push timeEnd1
	call printstr
	push 0x04
	push 1080
	push timeEnd2
	call printstr
	push 0x40;04
	push 1242
	push timeEnd3
	call printstr
	push 0x04
	push 1392
	push timeEnd4
	call printstr
	pop si
	pop  di          
	pop  ax            
	pop  es              
	ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Basically Phase two;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
clearline:
	push bp
	mov bp,sp
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di,[bp+4]
	sub di,2
	mov si,di
	add si,12
	firstline:
		cmp di,si
		jne diff1
		cmp word [es:di+2],0x305F
		jne diff1
		cmp word [es:di+4],0x307C
		je skip4
diff1:
		cmp word [es:di-160+4],0x307C
		je skip4
		cmp word [es:di-160],0x307C
		je skip4
		; cmp word [es:di-160],0x305F
		; je skip4
		cmp word [es:di-4],0x307C
		jne farighkarao1
		cmp word [es:di-2],0x305F
		je skip4
farighkarao1:
		cmp word [es:di],0x677C
		je skip4
		mov  word [es:di],0x3321 
skip4:	add  di, 2             
		cmp  di, si           
		jle  firstline  
	add di,146
	add si,160
	secondline:  
		cmp di,si
		jne diff2
		cmp word [es:di-160+2],0x305F
		jne diff2
		cmp word [es:di+2],0x305F
		jne diff2
		cmp word [es:di+4],0x307C
		je skip5
diff2:		
		cmp word [es:di-160-2],0x305F
		jne farighkarao2
		cmp word [es:di-4],0x307C
		jne farighkarao2
		; cmp word [es:di+14],0x307C
		; je skip4
		cmp word [es:di-2],0x305F
		je skip5
farighkarao2:
		mov  word [es:di],0x3321 
skip5:	add  di, 2              
		cmp  di, si           
		jle  secondline 
		call completebox
	pop si
	pop  di          
	pop  ax            
	pop  es   
	pop  bp
	ret 2
	
clearline1:
	push bp
	mov bp,sp
	push cx
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di,[bp+4]
	mov cx,3
l1:
	mov word [es:di],0x3321
	cmp word [es:di-4],0x305F
	jne noproblem1
	cmp word [es:di+156],0x305F
	jne noproblem1
	cmp word [es:di+154],0x307C
	je skip6
	noproblem1:
		mov word [es:di+158],0x3321
	skip6:
		cmp word [es:di+4],0x305F
		jne noproblem
		cmp word [es:di-160+2],0x305F
		je  skip7
		cmp word [es:di+164],0x305F
		jne noproblem
		cmp word [es:di+166],0x307C
		je skip7
	noproblem:
		mov word [es:di+162],0x3321
		; mov word [es:di+160],0x3321
		; mov word [es:di+160+158],0x3321
	skip7:	; mov word [es:di+162+160],0x3321
		add di,160
	loop l1
	mov word [es:di],0x3321
	call completebox
	pop si
	pop di          
	pop ax            
	pop es   
	pop cx
	pop bp
	ret 2

clearline2:
	push bp
	mov bp,sp
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di,[bp+4]
;	sub di,2
	mov si,di
	add si,6
	firstline2:
		cmp di,si
		jne diff3
		cmp word [es:di+2],0x305F
		jne diff3
		cmp word [es:di+4],0x307C
		je skipsq1
diff3:
		cmp word [es:di-4],0x307C
		jne farighkarao3
		cmp word [es:di-2],0x305F
		je skipsq1
farighkarao3:
		cmp word [es:di],0x677C
		je skipsq1
		mov  word [es:di],0x3321 
skipsq1:	add  di, 4            
		cmp  di, si           
		jle  firstline2  
	add di,150
	add si,160
	secondline2:  
		cmp di,si
		jne diff4
		cmp word [es:di-160+2],0x305F
		jne diff4
		cmp word [es:di+2],0x305F
		jne diff4
		cmp word [es:di+4],0x307C
		je skipsq2
diff4:		
		cmp word [es:di-160-2],0x305F
		jne farighkarao4
		cmp word [es:di-4],0x307C
		jne farighkarao4
		; cmp word [es:di+14],0x307C
		; je skip4
		cmp word [es:di-2],0x305F
		je skipsq2
farighkarao4:
		mov  word [es:di],0x3321 
skipsq2:	add  di, 2              
		cmp  di, si           
		jle  secondline2 
	add di,150
	add si,160
	thirdline:
		cmp di,si
		jne diff5
		cmp word [es:di+2],0x305F
		jne diff5
		cmp word [es:di+4],0x307C
		je skipsq3
diff5:		
		cmp word [es:di-4],0x307C
		jne farighkarao5
		; cmp word [es:di+14],0x307C
		; je skip4
		cmp word [es:di-2],0x305F
		je skipsq3
farighkarao5:
		mov  word [es:di],0x3321 
skipsq3:
		add  di, 2              
		cmp  di, si           
		jle  thirdline 
		call completebox
	pop si
	pop  di          
	pop  ax            
	pop  es   
	pop  bp
	ret 2
	
clearline3:
	push bp
	mov bp,sp
	push cx
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di,[bp+4]
	mov cx,3
l5:
	mov word [es:di],0x3321
	cmp word [es:di-4],0x305F
	jne noproblem3
	cmp word [es:di+156],0x305F
	jne noproblem3
	cmp word [es:di+154],0x307C
	je skip8
	noproblem3:
		mov word [es:di+158],0x3321
	skip8:
		; cmp word [es:di-160-2],0x305F
		; jne noproblem4
		cmp word [es:di-4],0x307C
		jne noproblem4
		; cmp word [es:di+14],0x307C
		; je skip4
		cmp word [es:di-2],0x305F
		je skip9
		; cmp word [es:di+164],0x305F
		; jne noproblem4
		; cmp word [es:di+166],0x307C
		; je skip9
	noproblem4:
		mov word [es:di+162],0x3321
	

	skip9:	; mov word [es:di+162+160],0x3321
		add di,160
	loop l5
	
	mov di,[bp+4]
	add di,164
	mov cx,2
l9:
	mov word [es:di],0x3321
	cmp word [es:di+156],0x305F
	jne noproblem5
	cmp word [es:di+154],0x307C
	je skip10
	noproblem5:
		mov word [es:di+158],0x3321
	skip10:
		cmp word [es:di+164],0x305F
		jne noproblem6
		cmp word [es:di+4],0x305F
		jne noproblem6
		cmp word [es:di+166],0x307C
		je skip11
	noproblem6:
		mov word [es:di+162],0x3321
		; mov word [es:di+160],0x3321
		; mov word [es:di+160+158],0x3321
	skip11:	; mov word [es:di+162+160],0x3321
		add di,160
	loop l9
	
	mov word [es:di],0x3321
	call completebox
	pop si
	pop di          
	pop ax            
	pop es   
	pop cx
	pop bp
	ret 2
clearline4:
	push bp
	mov bp,sp
	push es               
	push ax               
	push di
	push si
	mov  ax, 0xb800   
	mov  es, ax         
	mov  di,[bp+4]
	mov si,di
	add si,4
	.firstline2:
		cmp di,si
		jne .diff3
		cmp word [es:di+2],0x305F
		jne .diff3
		cmp word [es:di+4],0x307C
		je .skipsq1
.diff3:
		cmp word [es:di-4],0x307C
		jne .farighkarao3
		cmp word [es:di-2],0x305F
		je .skipsq1
		cmp word [es:di-160],0x307C
		je .skipsq1
.farighkarao3:
		cmp word [es:di],0x677C
		je .skipsq1
		mov  word [es:di],0x3321 
.skipsq1:	
	add  di, 4             
		cmp  di, si           
		jle  .firstline2  
	sub di,2
	add di,148
	add si,162
	cmp word [es:di],0x677C
	jne .secondline2
	add di,4
	.secondline2:  
		cmp di,si
		jne .diff4
		cmp word [es:di-160+2],0x305F
		jne .diff4
		cmp word [es:di+2],0x305F
		jne .diff4
		cmp word [es:di+4],0x307C
		je .skipsq2
.diff4:				
		cmp word [es:di-4],0x307C
		jne .farighkarao4
		; cmp word [es:di+14],0x307C
		; je skip4
		cmp word [es:di-2],0x305F
		je .skipsq2
.farighkarao4:
		mov  word [es:di],0x3321 
.skipsq2:	add  di, 2              
		cmp  di, si           
		jle  .secondline2 
	add di,146
	add si,156
	
	.thirdline:
		cmp di,si
		jne .diff5
		cmp word [es:di+2],0x305F
		jne .diff5
		cmp word [es:di+4],0x307C
		je .skipsq3
.diff5:		
		cmp word [es:di-4],0x307C
		jne .farighkarao5
		cmp word [es:di-160-2],0x305F
		jne .farighkarao5
		cmp word [es:di-2],0x305F
		je .skipsq3
.farighkarao5:
		mov  word [es:di],0x3321 
.skipsq3:
		add  di, 2              
		cmp  di, si           
		jle  .thirdline 
		call completebox
	pop si
	pop  di          
	pop  ax            
	pop  es   
	pop  bp
	ret 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ANIMATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
animation:
	push bp
	mov bp,sp
	push bx
	push cx
	push di
	push ax
	push es
	push si
	mov ax,0xb800
	mov es,ax
	mov cx,[bp+6]
	mov di,[bp+4]
	cmp cx,5
	jne chk2;pathtoverticalbar
	jmp pathtoverticalbar
chk2:
	cmp cx,10
	jne chk3;pathtosquare
	jmp pathtosquare
chk3:	
	cmp cx,9
	jne chk4;horizontalbar
jmp	pathtoanonymousshape
chk4:
	cmp cx,11
	jne horizontalbar
jmp anonymoushape2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HORIZONTAL BAR ANIMATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
horizontalbar:
	mov si,di
	add si,320
mov1:
	cmp word [es:si],0x675F
	je firstpathtoexit
	cmp word [es:di+160+158],0x307C
	jne ignore4
	cmp word [es:di+160+162],0x307C
	je firstpathtoexit
ignore4:
	cmp word [es:si],0x305F
	je firstpathtoexit2
	cmp word [es:si+4],0x305F
	je firstpathtoexit2
	cmp word [es:di+8+160+158],0x307C
	jne ignore2
	cmp word [es:di+8+160+162],0x307C
	je firstpathtoexit
ignore2:
	cmp word [es:si+8],0x305F
	je firstpathtoexit2
	call delaybox
	push di
	call clearline
	add di,160
	add si,160
	push cx
	push di
	call boxes
	cmp word [minute],3
	jl checkkey
	cmp word [tickcount2],1
	jl checkkey
	call timeended
checkkey:
	mov ah,01h     
	int 16h  
	jnz key 
	jmp nokey
	jmp key
	firstpathtoexit:
		jmp secondpathtoexit
	firstpathtoexit2:
		jmp secondpathtoexit2
key:
	cmp ah,0x4d;al,114
	jne leftkey
	push cx
	call checkright
	jmp more
leftkey:
	cmp ah,0x4B;al,108
	jne rotate
	push cx
	call checkleft
	jmp more
rotate:
	cmp al,32
	jne escape
	call checkrotate
	cmp word [rotatable],1
	jne more
	mov word [rotatable],0
	jmp verticalbar
escape:
	cmp al,27
	jne paused
	mov sp,0xFFFE
	jmp exit2
paused:
	cmp al,112
	jne more
	push ax
	push es
	mov ax,0xb800
	mov es,ax
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		infi:
		mov ah,01
		int 0x16
		jz infi
		mov ah,0
		int 0x16
		cmp al,115
		jne infi
		xor  ax, ax         
		mov  es, ax        
		mov  ax, [es:8*4]         
		mov  [oldkb], ax      
		mov  ax, [es:8*4+2]     
		mov  [oldkb+2], ax
		cli                    
		mov  word [es:8*4], inttimer
		mov  [es:8*4+2], cs    
		sti 
	pop es
	pop ax
more:
	mov ah,01h
	int 16h
	jz nokey
	mov ah,0
	int 16h
	jmp more
nokey:	
	jmp mov1
pathtoverticalbar:
	jmp verticalbar
pathtosquare:
	jmp square
pathtoanonymousshape:
	jmp anonymousshape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;VERTICAL BAR ANIMATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
verticalbar:
	mov si,di
	add si,640
mov2:
	cmp word [es:si],0x675F
	jne checknext
	jmp secondpathtoexit
checknext:
	cmp word [es:si+2],0x307C
	jne ignore3
	cmp word [es:si-2],0x307C 
	jne ignore3
	cmp word [es:si],0x305F
	jne ignore3
	jmp secondpathtoexit
ignore3:
	cmp word [es:si],0x305F
	jne allok
	jmp secondpathtoexit2
allok:
	call delaybox
	push di
	call clearline1
	add di,160
	add si,160
	push cx
	push di
	call boxes
	cmp word [minute],3
	jl checkkey1
	cmp word [tickcount2],1
	jl checkkey1
	call timeended
checkkey1:
	mov ah,01h     
	int 16h  
	jnz key1 
	jmp nokey1
	inc ax
	jmp mov2
key1:
	cmp ah,0x4d
	jne leftkey1
	push cx
	call checkright
	jmp more1
leftkey1:
	cmp ah,0x4B
	jne rotate1
	push cx
	call checkleft
	jmp more1
rotate1:
	cmp al,32
	jne escape1
	call checkrotate
	cmp word [rotatable],1
	jne more1
	mov word [rotatable],0
	jmp horizontalbar
escape1:
	cmp al,27
	jne paused1
	mov sp,0xFFFE
	jmp exit2
paused1:
	cmp al,112
	jne more1
	push ax
	push es
	mov ax,0xb800
	mov es,ax
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		infi1:
		mov ah,01
		int 0x16
		jz infi1
		mov ah,0
		int 0x16
		cmp al,115
		jne infi1
		xor  ax, ax         
		mov  es, ax        
		mov  ax, [es:8*4]         
		mov  [oldkb], ax      
		mov  ax, [es:8*4+2]     
		mov  [oldkb+2], ax
		cli                    
		mov  word [es:8*4], inttimer
		mov  [es:8*4+2], cs    
		sti 
	pop es
	pop ax
more1:
	mov ah,01h
	int 16h
	jz nokey1
	mov ah,0
	int 16h
	jmp more1
nokey1:	
	jmp mov2
secondpathtoexit:
	jmp thirdpathtoexit
secondpathtoexit2:
	jmp thirdpathtoexit2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SQUARE ANIMATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
square:
	mov si,di
	add si,480
mov3:
	cmp word [es:si],0x675F
	jne chcknxt
	jmp thirdpathtoexit
	; cmp word [es:si+4],0x675F     not needed 
	; je ending9
chcknxt:
	cmp word [es:si],0x305F
	jne chcknxt2
	jmp thirdpathtoexit2
chcknxt2:
	cmp word [es:si+4],0x305F
	jne chcknxt3
	jmp thirdpathtoexit2
chcknxt3:
	call delaybox
	push di
	call clearline2
	add di,160
	add si,160
	push cx
	push di
	call boxes
	cmp word [minute],3
	jl checkkey2
	cmp word [tickcount2],1
	jl checkkey2
	call timeended
checkkey2:
	mov ah,01h     
	int 16h  
	jnz key2
	jmp nokey2
key2:
	cmp ah,0x4d
	jne leftkey2
	push cx
	call checkright
	jmp more2
leftkey2:
	cmp ah,0x4B
	jne escape2
	push cx
	call checkleft
escape2:
	cmp al,27
	jne paused2
	mov sp,0xFFFE
	jmp exit2
paused2:
	cmp al,112
	jne more2
	push ax
	push es
	mov ax,0xb800
	mov es,ax
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		infi2:
		mov ah,01
		int 0x16
		jz infi2
		mov ah,0
		int 0x16
		cmp al,115
		jne infi2
		xor  ax, ax         
		mov  es, ax        
		mov  ax, [es:8*4]         
		mov  [oldkb], ax      
		mov  ax, [es:8*4+2]     
		mov  [oldkb+2], ax
		cli                    
		mov  word [es:8*4], inttimer
		mov  [es:8*4+2], cs    
		sti 
	pop es
	pop ax
more2:
	mov ah,01h
	int 16h
	jz nokey2
	mov ah,0
	int 16h
	jmp more2
	
nokey2:	
	jmp mov3
thirdpathtoexit:
	jmp fourthpathtoexit
thirdpathtoexit2:
	jmp fourthpathtoexit2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ANONYMOUS SHAPE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
anonymousshape:
	mov si,di
	add si,644
mov4:
	cmp word [es:si],0x675F
	jne movetonext
	jmp fourthpathtoexit
movetonext:
	cmp word [es:si],0x305F
	jne gotonxtcheck
	jmp fourthpathtoexit2
gotonxtcheck:
	cmp word [es:si-164],0x305F
	jne allok2
	jmp fourthpathtoexit2
allok2:
	call delaybox
	push di
	call clearline3
	add di,160
	add si,160
	push cx
	push di
	call boxes
	cmp word [minute],3
	jl checkkey3
	cmp word [tickcount2],1
	jl checkkey3
	call timeended
checkkey3:
	mov ah,01h     
	int 16h  
	jnz key3
	jmp nokey3
key3:
	cmp ah,0x4d
	jne leftkey3
	push cx
	call checkright
	jmp more3
leftkey3:
	cmp ah,0x4B
	jne rotate2
	push cx
	call checkleft
	jmp more3
rotate2:
	cmp al,32
	jne escape3
	call checkrotate
	cmp word [rotatable],1
	jne more3
	mov word [rotatable],0
	jmp anonymoushape2
escape3:
	cmp al,27
	jne paused3
	mov sp,0xFFFE
	jmp exit2
paused3:
	cmp al,112
	jne more3
	push ax
	push es
	mov ax,0xb800
	mov es,ax
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		infi3:
		mov ah,01
		int 0x16
		jz infi3
		mov ah,0
		int 0x16
		cmp al,115
		jne infi3
		xor  ax, ax         
		mov  es, ax        
		mov  ax, [es:8*4]         
		mov  [oldkb], ax      
		mov  ax, [es:8*4+2]     
		mov  [oldkb+2], ax
		cli                    
		mov  word [es:8*4], inttimer
		mov  [es:8*4+2], cs    
		sti 
	pop es
	pop ax
more3:
	mov ah,01h
	int 16h
	jz nokey3
	mov ah,0
	int 16h
	jmp more3
	
 nokey3:	
	jmp mov4
fourthpathtoexit:
	jmp fifthpathtoexit
fourthpathtoexit2:
	jmp fifthpathtoexit2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ANONYMOUS SHAPE 2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
anonymoushape2:
	mov si,di
	add si,480
mov5:
	cmp word [es:si],0x675F
	jne chknxt
	jmp fifthpathtoexit
	chknxt:
	cmp word [es:si],0x305F
	jne ignore 
;	jmp fifthpathtoexit2
;	chknxt2:
	cmp word [es:si-2-4],0x307C
	jne ignore
	cmp word [es:si+2-4],0x307C
	jne ignore
	jmp fifthpathtoexit
	ignore:
	cmp word [es:si],0x305F
	jne checkthenext
	jmp fifthpathtoexit2
checkthenext:
	cmp word [es:si-4],0x305F
	jne checkthenext2
	jmp fifthpathtoexit2
checkthenext2:
	cmp word [es:si-160+4],0x305F
	jne allok3
	jmp fifthpathtoexit2
	; cmp word [es:si],0x305F
	; je fifthpathtoexit2
	; cmp word [es:si-4],0x305F
	; je fifthpathtoexit2
allok3:
	call delaybox
	push di
	call clearline4
	add di,160
	add si,160
	push cx
	push di
	call boxes
	cmp word [minute],3
	jl checkkey4
	cmp word [tickcount2],1
	jl checkkey4
	call timeended
checkkey4:
	mov ah,01h    
	int 16h  
	jnz key4
	jmp nokey4
key4:
	cmp ah,0x4d
	jne leftkey4
	push cx
	call checkright
	jmp more4
leftkey4:
	cmp ah,0x4B
	jne rotate3
	push cx
	call checkleft
rotate3:
	cmp al,32
	jne escape4
	call checkrotate
	cmp word [rotatable],1
	jne more4
	mov word [rotatable],0
	jmp anonymousshape
escape4:
	cmp al,27
	jne paused4
	mov sp,0xFFFE
	jmp exit2
paused4:
	cmp al,112
	jne more4
	push ax
	push es
	mov ax,0xb800
	mov es,ax
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		infi4:
		mov ah,01
		int 0x16
		jz infi4
		mov ah,0
		int 0x16
		cmp al,115
		jne infi4
		xor  ax, ax         
		mov  es, ax        
		mov  ax, [es:8*4]         
		mov  [oldkb], ax      
		mov  ax, [es:8*4+2]     
		mov  [oldkb+2], ax
		cli                    
		mov  word [es:8*4], inttimer
		mov  [es:8*4+2], cs    
		sti 
	pop es
	pop ax
more4:
	mov ah,01h
	int 16h
	jz nokey4
	mov ah,0
	int 16h
	jmp more4
nokey4:	
	jmp mov5
fifthpathtoexit:
	jmp ending9
fifthpathtoexit2:
	jmp ending8
ending8:
	cmp cx,5
	je nope
	cmp cx,10
	je nope2
	cmp cx,9
	je nope3
	cmp cx,11
	je nope4
	push di
	call clearline
	add di,160
	push cx
	push di
	call boxes
	jmp ending9
	nope:
		push di
		call clearline1
		add di,160
		push cx
		push di
		call boxes
		jmp ending9
	nope2:
		push di
		call clearline2
		add di,160
		push cx
		push di
		call boxes
		jmp ending9
	nope3:
		push di
		call clearline3
		add di,160
		push cx
		push di
		call boxes
		jmp ending9
	nope4:
		push di
		call clearline4
		add di,160
		push cx
		push di
		call boxes
ending9:	
pop si
pop es
pop ax
pop di
pop cx
pop bx
pop bp
	ret 4
	
pausing:
;	push ax
;	push es
;	mov ax,0xb800
;	mov es,ax
		; cli              
		; xor  ax, ax         
		; mov  es, ax  
		; mov ax,[oldkb]
		; mov  word [es:8*4], ax
		; mov ax,[oldkb+2]
		; mov  word [es:8*4+2],ax   
		; sti 
		; call delaybox
		; ; infi:
		; ; mov ah,01
		; ; int 0x16
		; ; jz infi
		; ; mov ah,0
		; ; int 0x16
		; ; cmp al,99
		; ; jne infi
		; xor  ax, ax         
		; mov  es, ax        
		; mov  ax, [es:8*4]         
		; mov  [oldkb], ax      
		; mov  ax, [es:8*4+2]     
		; mov  [oldkb+2], ax
		; cli                    
		; mov  word [es:8*4], inttimer
		; mov  [es:8*4+2], cs    
		; sti 
;	pop es
;	pop ax
	ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; RIGHT CHECK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
checkright:
	push bp
	mov bp,sp
	cmp word [bp+4],5
	je verticalright
	cmp word [bp+4],10
	je jumpsqright
	cmp word [bp+4],9
	je jumpanonymousright
	cmp word [bp+4],11
	jne horizontalright
	jmp anonymous2right
	horizontalright:
		cmp word [es:di+14],0x677C
		je shortcut;noright
		cmp word [es:di+14],0xA11B
		je shortcut;noright
		cmp word [es:di+14],0x307C
		je shortcut;noright
		push di
		call clearline
		sub di,160
		sub si,160
		add di,4
		add si,4
		push cx
		push di
		call boxes
		shortcut: 
			jmp shortcut2
	jumpsqright:
		jmp sqright
	jumpanonymousright:
		jmp anonymousright
	verticalright:
		cmp word [es:di+4],0x677C
		je shortcut2
		cmp word [es:di+4],0xA11B
		je shortcut2
		cmp word [es:di+4],0x305F;7C
		je shortcut2
		cmp word [es:di+160+4],0x305F;7C
		je shortcut2
		; cmp word [es:di+320+4],0x305F;7C
		; je shortcut2
		push di
		call clearline1
		sub di,160
		sub si,160
		add di,4
		add si,4
		push cx
		push di
		call boxes
		shortcut2:
			jmp noright
	sqright:
		cmp word [es:di+8],0x677C
		je shortcut3
		cmp word [es:di+8],0xA11B
		je shortcut3
		cmp word [es:di+8],0x305F;7C
		je shortcut3
		cmp word [es:di+160+8],0x305F;7C
		je shortcut3
		push di
		call clearline2
		sub di,160
		sub si,160
		add di,4
		add si,4
		push cx
		push di
		call boxes
		shortcut3:
			jmp noright
	anonymousright:
		cmp word [es:di+4+166],0x677C
		je noright
		cmp word [es:di+4+166],0xA11B
		je noright
		cmp word [es:di+4],0x305F
		je noright
		cmp word [es:di+160+8],0x305F;7C
		je noright
		cmp word [es:di+320+8],0x305F;7C
		je noright
		push di
		call clearline3
		sub di,160
		sub si,160
		add di,4
		add si,4
		push cx
		push di
		call boxes
		jmp noright
	anonymous2right:
		cmp word [es:di+8],0x677C
		je noright
		cmp word [es:di+8],0xA11B
		je noright
		cmp word [es:di+8],0x305F;7C
		je noright
		cmp word [es:di+320+4],0x305F;7C
		je noright
		push di
		call clearline4
		sub di,160
		sub si,160
		add di,4
		add si,4
		push cx
		push di
		call boxes
		jmp noright
	noright:
		pop bp
		ret 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LEFT CHECK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
checkleft:
	push bp
	mov bp,sp
	cmp word [bp+4],5
	je verticalleft
	cmp word [bp+4],10
	je jumpsqleft
	cmp word [bp+4],9
	je jumpanonymousleft
	cmp word [bp+4],11
	jne horizontalleft
	jmp anonymousleft2
	horizontalleft:
		cmp word [es:di-6],0x677C
		je shortcutl;noleft
		cmp word [es:di-6],0x921A
		je shortcutl;noleft
	;	cmp word [es:di-4],0x677C
	;	je shortcutl;noleft
		cmp word [es:di-6],0x307C
		je shortcutl;noleft
		push di
		call clearline
		sub di,164
		sub si,164
		push cx
		push di
		call boxes
		shortcutl:
			jmp shortcut2l
	jumpsqleft:
		jmp sqleft
	jumpanonymousleft:
		jmp anonymousleft
	verticalleft:
		cmp word [es:di-4],0x677C
		je shortcut2l
		cmp word [es:di-4],0x921A
		je shortcut2l
		cmp word [es:di-4],0x305F;7C
		je shortcut2l
		cmp word [es:di+160-4],0x305F
		je shortcut2l
	;	cmp word [es:di+320-4],0x305F
	;	je shortcut2l
		push di
		call clearline1
		sub di,164
		sub si,164
		push cx
		push di
		call boxes
		 shortcut2l:
			jmp noleft
	sqleft:
		cmp word [es:di-4],0x677C
		je shortcut3l
		cmp word [es:di-4],0x921A
		je shortcut3l
		cmp word [es:di-4],0x305F;7C
		je shortcut3l
		cmp word [es:di+160-4],0x305F
		je shortcut3l
		push di
		call clearline2
		sub di,164
		sub si,164
		push cx
		push di
		call boxes
		shortcut3l:
			jmp noleft
	anonymousleft:
		cmp word [es:di-4],0x677C
		je noleft
		cmp word [es:di-4+160],0xA11B
		je noleft
		cmp word [es:di-4],0x305F
		je noleft
		cmp word [es:di-4+160],0x305F
		je noleft
		push di
		call clearline3
		sub di,164
		sub si,164
		push cx
		push di
		call boxes
		jmp noleft
	anonymousleft2:
		cmp word [es:di+160-8],0x677C
		je noleft
		cmp word [es:di+160-8],0x921A
		je noleft
		cmp word [es:di+160-8],0x305F;7C
		jne noprob;noleft
		cmp word [es:di+160-10],0x307C
		je noleft
	noprob;	cmp word [es:di-4],0x305F
		; je noleft
		push di
		call clearline4
		sub di,164
		sub si,164
		push cx
		push di
		call boxes
		jmp noleft
 noleft:
	pop bp
	ret 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ROTATION CHECK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
checkrotate:
	cmp cx,1
	jne comp2
	cmp di,3290 
	jg comp3
	cmp word [es:di+480],0x305F
	jne khairhai
	jmp morer
	khairhai:
	push di
	call clearline
	mov cx,5
	push cx
	push di
	call boxes
	mov word [rotatable],1
	jmp morer
	comp2:
		cmp cx,5
		jne comp3
		cmp word [es:di+8],0x3321;0x677C
		jne morer
		; cmp word [es:di+8],0x3321;0xA11B
		; jne comp3
		cmp word [es:di+4],0x3321;0x677C
		jne morer
		; cmp word [es:di+4],0x3321;0xA11B
		; jne comp3
		; cmp word [es:di+8+160],0x3321;0x677C
		; jne comp3
		cmp word [es:di+8+160],0x3321;0xA11B
		jne morer
		push di
		call clearline1
		sub di,160
		mov word [rotatable],1
		mov cx,1
		push cx
		push di
		call boxes
		jmp morer
	;	call delaybox
	comp3:
		cmp cx,11
		jne comp4
		cmp word [es:di+480+4],0x3321;0x677C
		jne morer
		push di
		call clearline4
		sub di,160
		mov word [rotatable],1
		mov cx,9
		push cx
		push di
		call boxes
		jmp morer
	comp4:
		cmp word [es:di+6],0x3321;0x677C
		jne morer
		cmp word [es:di+160-4],0x3321;0x677C
		jne morer
		push di
		call clearline3
		sub di,160
		mov word [rotatable],1
		mov cx,11
		push cx
		push di
		call boxes
	morer:
		mov ah,01h
		int 16h
		jz bhago
		mov ah,0
		int 16h
		jmp morer
	bhago:
		ret
completebox:
	push bp
	mov bp,sp
	push bx
	push cx
	push di
	push ax
	push es
	push si
	mov ax,0xb800
	mov es,ax
	mov di,0
	mov cx,2000
l:
	cmp word [es:di],0x305f
	jne age
	cmp word [es:di+158],0x307C
	jne age
	cmp word [es:di+162],0x307C
	jne age
	cmp word [es:di+320],0x675F
	je age
	cmp word [es:di+320],0x305F
	je age
	cmp word [es:di+318],0x307C
	jne doit
	cmp word [es:di+322],0x307C
	je age 
doit:
	mov word [es:di+160],0x305F
	age:
		add di,2
	loop l
mov di,0
mov cx,2000
ll:
	cmp word [es:di],0x305F
	jne age2
	cmp word [es:di-160],0x3321
	jne age2
	cmp word [es:di+162],0x3321
	jne age2
	cmp word [es:di-4],0x305F
	jne age2
	cmp word [es:di-4+158],0x307C
	jne age2
	cmp word [es:di-4+162],0x307C
	jne age2
	cmp word [es:di-4+160],0x305F
	jne age2
	mov word [es:di+160],0x305F
	mov word [es:di+162],0x307C
	age2:
		add di,2
	loop ll
; mov di,0
; mov cx,2000
; ll:
	; cmp word [es:di],0x305f
	; jne age2
	; cmp word [es:di+158],0x307C
	; jne age2
	; cmp word [es:di-160],0x3321
	; jne age2
	; mov word [es:di+162],0x307C
	; mov word [es:di+160],0x305F
	; age2:
		; add di,2
	; loop ll
; mov di,0
; mov cx,2000
; lll:
	; cmp word [es:di],0x305f
	; jne age3
	; cmp word [es:di-160],0x3321
	; jne age3
	; cmp word [es:di+158],0x3321
	; jne age3
; ;	cmp word [es:di+162],0x3321
; ;	jne age3
	; mov word [es:di+158],0x307C
	; mov word [es:di+162],0x307C
	; mov word [es:di+160],0x305F
	; age3:
		; add di,2
	; loop lll
; mov di,0
; mov cx,2000
; llll:
	; cmp word [es:di],0x305f
	; jne age4
	; cmp word [es:di+4],0x3321
	; jne age4
	; cmp word [es:di+160],0x305f
	; jne age4
	; cmp word [es:di+158],0x307C
	; jne age4
	; cmp word [es:di+162],0x307C
	; jne age4
	; cmp word [es:di+164],0x305f
	; jne age4
	; cmp word [es:di+322],0x307C
	; jne age4
	; cmp word [es:di+326],0x307C
	; jne age4
	; cmp word [es:di+324],0x305f
	; jne age4
	; cmp word [es:di+482],0x307C
	; jne age4
	; cmp word [es:di+486],0x307C
	; jne age4
	; cmp word [es:di+484],0x305f
	; jne age4
	; mov word [es:di+318],0x307C
	; mov word [es:di+320],0x305F
; ;	mov word [es:di+160],0x305F
	; age4:
		; add di,2
	; loop llll
	pop si
	pop es
	pop ax
	pop di
	pop cx
	pop bx
	pop bp
	ret

getrand: ; generate a rand no using the system time
	push ax
	push dx
	push cx
	MOV AH, 00h ; interrupts to get system time        
	INT 1AH ; CX:DX now hold number of clock ticks since midnight   
	mov ax, dx
	xor dx, dx
	mov cx, 4 
	div cx ; here dx contains the remainder of the division - from 0 to 9
	add al, '0' ; to ascii from '0' to '9'
	mov dh,0
	mov bx,dx
 pop cx
 pop dx
 pop ax
RET
getrand2: ; generate a rand no using the system time
	push ax
	push dx
	push cx
	MOV AH, 00h ; interrupts to get system time        
	INT 1AH ; CX:DX now hold number of clock ticks since midnight   
	mov ax, dx
	xor dx, dx
	mov cx, 10 
	div cx ; here dx contains the remainder of the division - from 0 to 9
	add al, '0' ; to ascii from '0' to '9'
	mov dh,0
	mov bx,dx
 pop cx
 pop dx
 pop ax
RET
	
RANDGEN: ; generate a rand no using the system time
RANDSTART:
	 push ax
	 push dx
	push bx
	inc word [rnd]
	cmp word[rnd],5
	jl shapedecide
cut:
	sub  word[rnd],5
	cmp word[rnd],5
	jge cut

	
shapedecide:
	cmp word [rnd],0
	jne rnd2
	mov cx,1
	jmp nikal
rnd2:	
	cmp word[rnd],1
	jne rnd3
	mov cx,5
	jmp nikal
rnd3:	
	cmp word[rnd],2
	jne rnd4
	mov cx,9
	jmp nikal
rnd4:	
	cmp word[rnd],3
	jne rnd5
	mov cx,10
	jmp nikal
rnd5:	
	cmp word[rnd],4
	jne nikal
	mov cx,11
	
 nikal:

 pop bx
 pop dx
 pop ax
ret
checkRows:
push bp
mov bp,sp
sub sp,2
mov ax,0xb800
mov es,ax
pusha
	mov cx,22
	mov di,3712
	mov si,3784
lup:
	mov dx,di
	samerow:
		cmp word [es:di],0x3321
		je nxtrow
		cmp word [es:di],0x305F
		jne dontstop
		cmp word [es:di-160],0x305F
		jne nxtrow
	dontstop:
		add di,2
		cmp di,si
		jle samerow
	add word [points],100
	mov di,dx
	push si
	push di
	call removerow
	push cx
	push si
	push di
	call scrollrow
	call removeedges
	add dx,160
	add si,160
	inc cx
	nxtrow:
		mov di,dx
		sub di,160
		sub si,160
	loop lup
popa
add sp,2
mov sp,bp
pop bp
ret
removerow:
push bp
mov bp,sp
pusha
mov ax,0xb800
mov es,ax
mov di,[bp+4]
mov si,[bp+6]
lup2:
	mov word [es:di],0x3321 
	call delayrow
	add di,2
	cmp di,si
	jle lup2
popa
mov sp,bp
pop bp
ret 4
scrollrow:
push bp
mov bp,sp
sub sp,2
pusha
mov ax,0xb800
mov es,ax
mov cx,[bp+8]
dec cx
mov di,[bp+4]
mov si,[bp+6]
outerloop:
	mov dx,di
	lup3:
		mov ax,[es:di-160] 
		mov word [es:di-160],0x3321
		mov [es:di],ax
		call delay1
		add di,2
		cmp di,si
		jle lup3
		mov di,dx
		sub di,160
		sub si,160
		loop outerloop
popa
add sp,2
mov sp,bp
pop bp
ret 6

removeedges:
pusha
	mov ax,0xb800
	mov es,ax
	xor di,di
	mov cx,2000
lup4:
	cmp word [es:di],0x305F
	jne moveon
	cmp word [es:di-160],0x305F
	je moveon
	cmp word [es:di+160],0x305F
	je moveon
	mov word [es:di],0x3321
	moveon: add di,2
	loop lup4
popa
ret

start:	
	
	call clrscr1
	mov ax, 8
	push ax 
	mov ax, 8
	push ax
	mov ax, 0xA
	push ax 
	mov ax, message8
	push ax
	call print_loading_message
	call draw_loading_screen
	mov ax,8
	push ax 
	mov ax, 12
	push ax 
	mov ax, 0xA 
	push ax 
	mov ax, message9
	push ax
	call print_loading_message
	mov ah,01
	int 0x21
	call voiceover
	call clrscr
	call border
	call clrscr	
	
	
	xor  ax, ax         
    mov  es, ax        
	mov  ax, [es:8*4]         
	mov  [oldkb], ax      
	mov  ax, [es:8*4+2]     
	mov  [oldkb+2], ax
	cli                    
	mov  word [es:8*4], inttimer
	mov  [es:8*4+2], cs    
	sti 
 	

	
	 mov dx,0x40
	 mov di,0
	 push dx
	 push di
	 mov ax,intro
	 push ax
	 call printstr
	 call getrand2
	call RANDGEN
	add word [rnd],bx
	mov ax,0xb800
	mov es,ax
	 mov di,358;1010;998;1038;700;998(remember)
;	 mov bx,word [rndrep]
;	mov cx,10
	screen:
		call clrscr
		call border
		call scoreboard
		call timmer
	game:
		 push cx
		 push di
		 call boxes
		mov bx,word [rndrep]
		add word [rndrep],17
		add bx,17
		add word [rnd],bx
		 push cx
		call RANDGEN
		call nextbox
		 push di
		 call animation
		call checkRows
		call scoreboard
		chechingmasla:
		cmp word [es:di+640],0x3321
		jne masla
		cmp word [es:di+640-4],0x3321
		jne masla
		cmp word [es:di+640+4],0x3321
		jne masla
		jmp noproblemo
		masla:
		add di,8
		cmp di,414
		jg ranoutofspace 
		jmp chechingmasla
	noproblemo:
		cmp word [minute],3
		jl game
	
	push 0xC0
	push 1168
	push timegone
	call printstr 
	call delay
	call delay
	jmp exit2
ranoutofspace:
	mov ax,space
	push 0xC0
	push 1164
	push space
	call printstr 
	call delay
	call delay
exit2:	
		cli              
		xor  ax, ax         
		mov  es, ax  
		mov ax,[oldkb]
		mov  word [es:8*4], ax
		mov ax,[oldkb+2]
		mov  word [es:8*4+2],ax   
		sti 
		cmp word [points],0
		jne won
		call losingscreen
		jmp finalexit
won:
		call endscreen
finalexit:
mov ah,0x1
int 0x21
mov ax,0x4c00
int 0x21
