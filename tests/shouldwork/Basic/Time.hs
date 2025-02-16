module Time where

import Clash.Explicit.Prelude
import Clash.Explicit.Testbench

topEntity
  :: Clock System Source
  -> Reset System Asynchronous
  -> Signal System Int
  -> Signal System Int
topEntity clk rst ps = register clk rst 0 (ps + 1)
{-# NOINLINE topEntity #-}

testBench :: Signal System Bool
testBench = done
  where
    testInput      = stimuliGenerator clk rst (1 :> 2 :> 3 :> Nil)
    expectedOutput = outputVerifier clk rst (0 :> 2 :> 3 :> Nil)
    done           = expectedOutput (topEntity clk rst testInput)
    clk            = tbSystemClockGen (not <$> done)
    rst            = systemResetGen
