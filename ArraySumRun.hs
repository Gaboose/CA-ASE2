------------------------------------------------------------------------
--  ArrayMaxRun: machine language program for the Sigma16 architecture
------------------------------------------------------------------------

{- A machine language program for the Sigma16 architecture that
searches an array of natural numbers for the maximal element.  The
loop terminates when a negative element is encountered. -}

module Main where
import M1driver

main :: IO ()
main = run_Sigma16_program arraymax 10000

------------------------------------------------------------------------

arraymax :: [String]
arraymax =
-- Machine Language  Addr    Assembly Language     Comment
-- ~~~~~~~~~~~~~~~~  ~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [
                  -- 0000 ; ArraySum: find the maximum element of an array
                  -- 0000
                  -- 0000 ; The program is given
                  -- 0000 ;   *  a natural number n, assume n>0
                  -- 0000 ;   *  an n-element array x[0], x[1], ..., x[n-1]
                  -- 0000 ;  It calculates
                  -- 0000 ;   * sum = the sum of element in the array
                  -- 0000
                  -- 0000 ; Since n>0, the array x contains at least one
                  -- 0000 ;  element.
                  -- 0000
                  -- 0000 ; program ArraySum
                  -- 0000 ;   sum := x[0]
                  -- 0000 ;   for i := 1 to n-1 step 1
                  -- 0000 ;       sum := sum + x[i]
                  -- 0000
                  -- 0000 ; Register usage
                  -- 0000 ;   R1 = constant 1
                  -- 0000 ;   R2 = n
                  -- 0000 ;   R3 = i
                  -- 0000 ;   R4 = sum
                  -- 0000
                  -- 0000 ; Initialise
                  -- 0000
  "f100", "0001", -- 0000 start lea   R1,1[R0]      ; R1 = constant 1
  "f201", "0017", -- 0002       load  R2,n[R0]      ; R2 = n
  "f300", "0001", -- 0004       lea   R3,1[R0]      ; R3 = i = 1
  "f401", "0019", -- 0006       load  R4,x[R0]      ; R4 = sum = x[0]
                  -- 0008
                  -- 0008 ; Top of loop, determine whether to remain in loop
                  -- 0008
                  -- 0008 loop
  "4532",         -- 0008       cmplt R5,R3,R2      ; R5 = (i<n)
  "f504", "0014", -- 0009       jumpf R5,done[R0]   ; if i>=n then goto done
                  -- 000b
  "f537", "0019", -- 000b       loadxi R5,x[R3]      ; R5 = x[i]
  "0000",         -- 000d
  "0000", "0000", -- 000e
                  -- 0010
  "0445",         -- 0010       add   R4,R4,R5      ; sum := sum + x[i]
                  -- 0011
                  -- 0011 ; Bottom of loop, increment loop index
                  -- 0011
  "0000",         -- 0011 next   add   R3,R3,R1     ; i = i + 1
  "f003", "0008", -- 0012        jump  loop[R0]     ; go to top of loop
                  -- 0014
                  -- 0014 ; Exit from loop
                  -- 0014
  "f402", "0018", -- 0014 done   store R4,sum[R0]   ; sum = R4
  "d000",         -- 0016        trap  R0,R0,R0     ; terminate
                  -- 0017
                  -- 0017 ; Data area
  "0006",         -- 0017 n        data   6
  "0000",         -- 0018 sum      data   0
  "0012",         -- 0019 x        data  18
  "0003",         -- 001a          data   3
  "0015",         -- 001b          data  21
  "fffe",         -- 001c          data  -2
  "0028",         -- 001d          data  40
  "0019"          -- 001e          data  25
 ]

------------------------------------------------------------------------
