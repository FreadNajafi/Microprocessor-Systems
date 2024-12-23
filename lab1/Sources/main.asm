********************************************************************
* Assembly Language Multiplication Program                         *
*                                                                  *
* This program multiplies two unsigned 8-bit numbers together      *
* and stores  the result in a 16-bit location ('PRODUCT')          *
* Author: Ahmad Najafi                                             *
********************************************************************
           
              XDEF Entry, _Startup    ; export ‘Entry’ symbol
              ABSENTRY Entry          ; for absolute assembly: mark
                                      ; this as the application entry point
              INCLUDE 'derivative.inc'; Include derivative-specific definitions
            
********************************************************************
* Data Section - Variables                                         *
********************************************************************

              ORG $3000               ; Start address for variables in RAM
MULTIPLICAND  FCB 05                  ; First Number
MULTIPLIER    FCB 05                  ; Second Number
PRODUCT       RMB 2                   ; Result of multiplication

********************************************************************
* The actual program starts here                                   *
********************************************************************

              ORG $4000
Entry:        
_Startup:
              LDAA MULTIPLICAND         ; Load first number into ACCA
              LDAB MULTIPLIER           ; Load second number into ACCB
              MUL                       ; Multiply ACCA by ACCB, result in D
              STAA PRODUCT              ; and store product
              SWI                       ; break to the monitor
              
********************************************************************
* Interrupt Vectors                                                *
********************************************************************

              ORG $FFFE
              FDB Entry                 ; Reset Vector

