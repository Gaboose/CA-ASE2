module Main where
import HDL.Hydra.Core.Lib
import Multiply


main = run_multiply test_data

test_data :: [[Int]]
test_data =
--     start  x    y
--     ~~~~~~~~~~~~~~
       [[1,  50,  75],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [0,   0,   0],
        [1, 100, 100],
        [0,   0,   0]]

run_multiply :: [[Int]] -> IO ()
run_multiply input = runAllInput input output
  where
    -- Size parameter
    k = 16
    -- Extract input signals from readable input
    start = getbit   input 0
    x     = getbin k input 1
    y     = getbin k input 2
    -- Connect the circuit to its inputs and outputs
    (rdy,prod,rx,ry,s) = multiply k start x y
    -- Format the signals for output
    output =
        [string "Input: ",
         bit start, bindec 4 x, bindec 4 y,
         string "  Output: ",
         bit rdy, bindec 6 prod, bindec 4 rx, bindec 6 ry, bindec 6 s]