module Multiply where

import HDL.Hydra.Core.Lib
import HDL.Hydra.Circuits.Combinational
import HDL.Hydra.Circuits.Register

multiply k start x y = (ready,prod,rx,ry,s)
  where
    rx = wlatch k (mux1w start (shr rx) x)
    ry = wlatch k (mux1w start (shl ry) y)
    prod = wlatch k (mux1w start (mux1w (lsb rx) prod s) (fanout k zero))
    (c,s) = rippleAdd zero (bitslice2 ry prod)
    ready = or2 (inv (orw rx)) (inv (orw ry))