------------------------------------------------------------------------
--  ArrayMaxRun: machine language program for the Sigma16 architecture
------------------------------------------------------------------------

{- A machine language program for the Sigma16 architecture that
searches an array of natural numbers for the maximal element.  The
loop terminates when a negative element is encountered. -}

module Main where
import M1driver

main :: IO ()
main = run_Sigma16_program loadxitest 10000

------------------------------------------------------------------------

loadxitest :: [String]
loadxitest =
-- Machine Language  Addr    Assembly Language     Comment
-- ~~~~~~~~~~~~~~~~  ~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [
                  -- 0000 ; Test the operation of loadxi instruction
                  -- 0000
  "f200", "0002", -- 0000 lea    R2,2[R0]   ; R2 = 2
  "f127", "0005", -- 0002 loadxi R1,x[R2]   ; R1 = x[R2] = 000c; R2++
                  -- 0004
                  -- 0004 ; Expected register values after the above instructions:
                  -- 0004 ; R1 = 000c
                  -- 0004 ; R2 = 3
                  -- 0004
  "d000",         -- 0004 trap
                  -- 0005
                  -- 0005 ; Data area
  "000a",         -- 0005 x   data 10
  "000b",         -- 0006     data 11
  "000c",         -- 0007     data 12
  "000d",         -- 0008     data 13
  "000e",         -- 0009     data 14
  "000f"          -- 000a     data 15
 ]

------------------------------------------------------------------------
