------------------------------------------------------------------------
--  MulRun: machine language program for the Sigma16 architecture
------------------------------------------------------------------------

{- A machine language program for the Sigma16 architecture that
performs a number of multiplications with the mul instruction. -}

module Main where
import M1driver

main :: IO ()
main = run_Sigma16_program multest 10000

------------------------------------------------------------------------

multest :: [String]
multest =
-- Machine Language  Addr    Assembly Language     Comment
-- ~~~~~~~~~~~~~~~~  ~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [
                    -- 0000 ; Mul: multiply several pairs of numbers and
                    -- 0000 ; save the results into registers 3 to 7.
                    -- 0000
                    -- 0000 ; Register usage
                    -- 0000 ; R1, R2 - multiplication factors
                    -- 0000 ; R3, R4, R5, R6, R7 - products for 5 mul operations
                    -- 0000
                    -- 0000
                    -- 0000 ; Multiply two small numbers
    "f100", "0002", -- 0000 lea R1,2[R0]     ; R1 = 2
    "f200", "0004", -- 0002 lea R2,4[R0]     ; R2 = 4
    "2321",         -- 0004 mul R3,R2,R1     ; R3 = 2*4 = 8        (0x0008)
                    -- 0005
                    -- 0005 ; Multiply a positive number with a negative number
    "f100", "0003", -- 0005 lea R1,3[R0]     ; R1 = 3
    "f200", "ffff", -- 0007 lea R2,ffff[R0]  ; R2 = -1
    "2421",         -- 0009 mul R4,R2,R1     ; R4 = 3*(-1) = -3    (0xfffd)
                    -- 000a
                    -- 000a ; Multiply two negative numbers
    "f100", "fffb", -- 000a lea R1,fffb[R0]  ; R1 = -5
    "f200", "ffff", -- 000c lea R2,ffff[R0]  ; R2 = -1
    "2521",         -- 000e mul R5,R2,R1     ; R5 = (-5)*(-1) = 5  (0x0005)
                    -- 000f
                    -- 000f ; Multiply two relatively large numbers
    "f100", "007f", -- 000f lea R1,7f[R0]    ; R1 = 127
    "f200", "0101", -- 0011 lea R2,101[R0]   ; R2 = 257
    "2621",         -- 0013 mul R6,R2,R1     ; R6 = 127 * 257 = 32639 (in dec)
                    -- 0014                  ;       7f * 101 =  7f7f (in hex)
                    -- 0014
                    -- 0014 ; Multiply two numbers that are too large
    "f100", "00ff", -- 0014 lea R1,ff[R0]    ; R1 = 255
    "f200", "1001", -- 0016 lea R2,1001[R0]  ; R2 = 4097
    "2721",         -- 0018 mul R7,R2,R1     ; R7 = 255 * 4097 % 65536  = 1044735 % 65536 = 61695 (in dec)
                    -- 0019                  ;                              61695 - 65536 =  -384 (in 2s-complement)
                    -- 0019                  ;       ff * 1001 % 10000  =   ff0ff % 10000 =  f0ff (in hex)
                    -- 0019                  ; The product overflows here.
                    -- 0019                  ; The effect is as if we used a modulus 0x10000 operation.
                    -- 0019
                    -- 0019 ; A table of expected multiplication products for reference:
                    -- 0019 ; R3 = 0008
                    -- 0019 ; R4 = fffd
                    -- 0019 ; R5 = 0005
                    -- 0019 ; R6 = 7f7f
                    -- 0019 ; R7 = f0ff
                    -- 0019
    "d000"          -- 0019 trap
 ]

 ------------------------------------------------------------------------