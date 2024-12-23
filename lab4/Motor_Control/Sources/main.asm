
;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry                  ; mark this as application entry point

; Include derivative-specific definitions 
		        INCLUDE 'derivative.inc' 

ROMStart    EQU  $4000  ; absolute address to place code/constant data

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.


; code section
            ORG   ROMStart

;************************************************************
;*                     Main Program                         *
;************************************************************

Entry:
_Startup:
           
;***************************
;*      Motor Control      *
;***************************

            BSET DDRA,%00000011  ; Set first two bits of DDRA to output (controls direction)
            BSET DDRT,%00110000  ; Set bits 4 and 5 of DDRT to output (controls power)
            
            ; Demonstrate motor control functions
            JSR STARFWD          ; Set starboard motor direction to forward
            JSR PORTFWD          ; Set port motor direction to forward
            JSR STARON           ; Turn on the starboard motor
            JSR PORTON           ; Turn on the port motor
            JSR STARREV          ; Set starboard motor direction to reverse
            JSR PORTREV          ; Set port motor direction to reverse
            JSR STAROFF          ; Turn off the starboard motor
            JSR PORTOFF          ; Turn off the port motor
            
            
            BRA *                ; Infinite loop to halt further execution
            
;************************************************************
;*                 Motor Control Subroutines                *
;************************************************************

;Starboard (Star): The right side of the robot when you are facing forward.
;Port: The left side of the robot when you are facing forward.

;Turn the starboard (right) motor on          
STARON      LDAA PTT
            ORAA #%00100000 ;20 
            STAA PTT
            RTS
            
;Turn the starboard (right) motor off           
STAROFF     LDAA PTT
            ANDA #%11011111 ; DF - 1315 
            STAA PTT
            RTS
            
;Turn the port (left) motor on 
PORTON      LDAA PTT
            ORAA #%00010000  ; 10
            STAA PTT
            RTS
            
;Turn the port (left) motor off            
PORTOFF     LDAA PTT
            ANDA #%11101111  ;   EF - 1415
            STAA PTT
            RTS
            
;Set the starboard motor direction to move forward 
STARFWD     LDAA PORTA
            ANDA #%11111101 ; FD - 1513
            STAA PORTA
            RTS

; Set Starboard Motor Direction to Reverse           
STARREV    LDAA PORTA            
            ORAA #%00000010 ; 2
            STAA PORTA
            RTS

; Set Port Motor Direction to Forward
PORTFWD     LDAA PORTA
            ANDA #%11111110  ; FE - 1514
            STAA PORTA
            RTS
            
; Set Port Motor Direction to Reverse            
PORTREV     LDAA PORTA
            ORAA #%00000001   ; 1
            STAA PORTA
            RTS

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
