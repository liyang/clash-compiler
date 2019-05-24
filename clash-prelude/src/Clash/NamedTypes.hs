{- |
Copyright  :  (C) 2017, Myrtle Software Ltd, QBayLogic, Google Inc.
License    :  BSD2 (see the file LICENSE)
Maintainer :  Christiaan Baaij <christiaan.baaij@gmail.com>

Add inline documentation to types:

@
fifo
  :: Clock domain gated
  -> Reset domain synchronous
  -> SNat addrSize
  -> "read request" ::: Signal domain Bool
  -> "write request" ::: Signal domain (Maybe (BitVector dataSize))
  -> ( "q"     ::: Signal domain (BitVector dataSize)
     , "full"  ::: Signal domain Bool
     , "empty" ::: Signal domain Bool
     )
@

which can subsequently be inspected in the interactive environment:

>>> import Clash.Explicit.Prelude
>>> :t fifo @System
fifo @System
  :: Clock System gated
     -> Reset System synchronous
     -> SNat addrSize
     -> ("read request" ::: Signal System Bool)
     -> ("write request" ::: Signal System (Maybe (BitVector dataSize)))
     -> ("q" ::: Signal System (BitVector dataSize),
         "full" ::: Signal System Bool, "empty" ::: Signal System Bool)

-}

{-# LANGUAGE DataKinds      #-}
{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE PolyKinds      #-}
{-# LANGUAGE TypeOperators  #-}

{-# LANGUAGE Safe #-}

{-# OPTIONS_HADDOCK show-extensions #-}

module Clash.NamedTypes
  ( (:::)
  , name
  )
where

import GHC.TypeLits (Symbol)


type (name :: k) ::: a = a
-- ^ Annotate a type with a name


-- | Name entity (VHDL) or module (Verilog) instantiation (best-effort)
--
-- Do
--
-- @
-- 'name' \@"foo" f x y
-- @
--
-- To label that particular instantiation of /f/ with /foo/
name :: forall (name :: Symbol) a . a -> name ::: a
name = id
{-# NOINLINE name #-}

{- $setup
>>> :set -XDataKinds -XTypeOperators -XNoImplicitPrelude
>>> import Clash.Explicit.Prelude
>>> :{
let fifo
      :: Clock domain gated
      -> Reset domain synchronous
      -> SNat addrSize
      -> "read request" ::: Signal domain Bool
      -> "write request" ::: Signal domain (Maybe (BitVector dataSize))
      -> ( "q"     ::: Signal domain (BitVector dataSize)
         , "full"  ::: Signal domain Bool
         , "empty" ::: Signal domain Bool
         )
    fifo = Clash.Explicit.Prelude.undefined
:}

-}
