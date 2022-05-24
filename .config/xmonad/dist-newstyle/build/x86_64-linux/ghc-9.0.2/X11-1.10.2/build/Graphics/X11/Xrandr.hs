{-# LINE 1 "Graphics/X11/Xrandr.hsc" #-}
{-# LANGUAGE DeriveDataTypeable #-}
--------------------------------------------------------------------
-- |
-- Module    : Graphics.X11.Xrandr
-- Copyright : (c) Haskell.org, 2012
--             (c) Jochen Keil, 2012
-- License   : BSD3
--
-- Maintainer: Ben Boeckel <mathstuf@gmail.com>
--           , Jochen Keil <jochen dot keil at gmail dot com>
--
-- Stability : provisional
-- Portability: portable
--
--------------------------------------------------------------------
--
-- Interface to Xrandr API
--

module Graphics.X11.Xrandr (
  XRRScreenSize(..),
  XRRModeInfo(..),
  XRRScreenResources(..),
  XRROutputInfo(..),
  XRRCrtcInfo(..),
  XRRPropertyInfo(..),
  XRRMonitorInfo(..),
  compiledWithXrandr,
  Rotation,
  Reflection,
  SizeID,
  XRRScreenConfiguration,
  xrrQueryExtension,
  xrrQueryVersion,
  xrrGetScreenInfo,
  xrrFreeScreenConfigInfo,
  xrrSetScreenConfig,
  xrrSetScreenConfigAndRate,
  xrrConfigRotations,
  xrrConfigTimes,
  xrrConfigSizes,
  xrrConfigRates,
  xrrConfigCurrentConfiguration,
  xrrConfigCurrentRate,
  xrrRootToScreen,
  xrrSelectInput,
  xrrUpdateConfiguration,
  xrrRotations,
  xrrSizes,
  xrrRates,
  xrrTimes,
  xrrGetScreenResources,
  xrrGetOutputInfo,
  xrrGetCrtcInfo,
  xrrGetScreenResourcesCurrent,
  xrrSetOutputPrimary,
  xrrGetOutputPrimary,
  xrrListOutputProperties,
  xrrQueryOutputProperty,
  xrrConfigureOutputProperty,
  xrrChangeOutputProperty,
  xrrGetOutputProperty,
  xrrDeleteOutputProperty,
  xrrGetMonitors,
  ) where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import Control.Monad

import Graphics.X11.Xlib.Event
import Graphics.X11.Xlib.Internal
import Graphics.X11.Xlib.Types
import Graphics.X11.Types


{-# LINE 78 "Graphics/X11/Xrandr.hsc" #-}
import Data.Data

{-# LINE 80 "Graphics/X11/Xrandr.hsc" #-}

-- | Representation of the XRRScreenSize struct
data XRRScreenSize = XRRScreenSize
                     { xrr_ss_width   :: !CInt,
                       xrr_ss_height  :: !CInt,
                       xrr_ss_mwidth  :: !CInt,
                       xrr_ss_mheight :: !CInt }
                       deriving (Show)

-- | Representation of the XRRModeInfo struct
data XRRModeInfo = XRRModeInfo
    { xrr_mi_id         :: !RRMode
    , xrr_mi_width      :: !CUInt
    , xrr_mi_height     :: !CUInt
    , xrr_mi_dotClock   :: !CUInt
    , xrr_mi_hSyncStart :: !CUInt
    , xrr_mi_hSyncEnd   :: !CUInt
    , xrr_mi_hTotal     :: !CUInt
    , xrr_mi_hSkew      :: !CUInt
    , xrr_mi_vSyncStart :: !CUInt
    , xrr_mi_vSyncEnd   :: !CUInt
    , xrr_mi_vTotal     :: !CUInt
    , xrr_mi_name       :: !String
    , xrr_mi_modeFlags  :: !XRRModeFlags
    } deriving (Eq, Show)

-- | Representation of the XRRScreenResources struct
data XRRScreenResources = XRRScreenResources
    { xrr_sr_timestamp       :: !Time
    , xrr_sr_configTimestamp :: !Time
    , xrr_sr_crtcs           :: [RRCrtc]
    , xrr_sr_outputs         :: [RROutput]
    , xrr_sr_modes           :: [XRRModeInfo]
    } deriving (Eq, Show)

-- | Representation of the XRROutputInfo struct
data XRROutputInfo = XRROutputInfo
    { xrr_oi_timestamp      :: !Time
    , xrr_oi_crtc           :: !RRCrtc
    , xrr_oi_name           :: !String
    , xrr_oi_mm_width       :: !CULong
    , xrr_oi_mm_height      :: !CULong
    , xrr_oi_connection     :: !Connection
    , xrr_oi_subpixel_order :: !SubpixelOrder
    , xrr_oi_crtcs          :: [RRCrtc]
    , xrr_oi_clones         :: [RROutput]
    , xrr_oi_npreferred     :: !CInt
    , xrr_oi_modes          :: [RRMode]
    } deriving (Eq, Show)

-- | Representation of the XRRCrtcInfo struct
data XRRCrtcInfo = XRRCrtcInfo
    { xrr_ci_timestamp    :: !Time
    , xrr_ci_x            :: !CInt
    , xrr_ci_y            :: !CInt
    , xrr_ci_width        :: !CUInt
    , xrr_ci_height       :: !CUInt
    , xrr_ci_mode         :: !RRMode
    , xrr_ci_rotation     :: !Rotation
    , xrr_ci_outputs      :: [RROutput]
    , xrr_ci_rotations    :: !Rotation
    , xrr_ci_possible     :: [RROutput]
    } deriving (Eq, Show)

-- | Representation of the XRRPropertyInfo struct
data XRRPropertyInfo = XRRPropertyInfo
    { xrr_pi_pending      :: !Bool
    , xrr_pi_range        :: !Bool
    , xrr_pi_immutable    :: !Bool
    , xrr_pi_values       :: [CLong]
    } deriving (Eq, Show)

-- | Representation of the XRRMonitorInfo struct
data XRRMonitorInfo = XRRMonitorInfo
   { xrr_moninf_name      :: !Atom
   , xrr_moninf_primary   :: !Bool
   , xrr_moninf_automatic :: !Bool
   , xrr_moninf_x         :: !CInt
   , xrr_moninf_y         :: !CInt
   , xrr_moninf_width     :: !CInt
   , xrr_moninf_height    :: !CInt
   , xrr_moninf_mwidth    :: !CInt
   , xrr_moninf_mheight   :: !CInt
   , xrr_moninf_outputs   :: [RROutput]
   } deriving (Eq, Show)

-- We have Xrandr, so the library will actually work
compiledWithXrandr :: Bool
compiledWithXrandr = True



newtype XRRScreenConfiguration = XRRScreenConfiguration (Ptr XRRScreenConfiguration)

{-# LINE 174 "Graphics/X11/Xrandr.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 178 "Graphics/X11/Xrandr.hsc" #-}

instance Storable XRRScreenSize where
    sizeOf _ = (16)
{-# LINE 181 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_ss = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_ss_width xrr_ss
{-# LINE 186 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 4) p $ xrr_ss_height xrr_ss
{-# LINE 187 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_ss_mwidth xrr_ss
{-# LINE 188 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ xrr_ss_mheight xrr_ss
{-# LINE 189 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRScreenSize
        `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 0) p)
{-# LINE 192 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 4) p)
{-# LINE 193 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 8) p)
{-# LINE 194 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 12) p)
{-# LINE 195 "Graphics/X11/Xrandr.hsc" #-}

instance Storable XRRModeInfo where
    sizeOf _ = (80)
{-# LINE 198 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_mi = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_mi_id         xrr_mi
{-# LINE 203 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_mi_width      xrr_mi
{-# LINE 204 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ xrr_mi_height     xrr_mi
{-# LINE 205 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ xrr_mi_dotClock   xrr_mi
{-# LINE 206 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ xrr_mi_hSyncStart xrr_mi
{-# LINE 207 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 28) p $ xrr_mi_hSyncEnd   xrr_mi
{-# LINE 208 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ xrr_mi_hTotal     xrr_mi
{-# LINE 209 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 36) p $ xrr_mi_hSkew      xrr_mi
{-# LINE 210 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p $ xrr_mi_vSyncStart xrr_mi
{-# LINE 211 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 44) p $ xrr_mi_vSyncEnd   xrr_mi
{-# LINE 212 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p $ xrr_mi_vTotal     xrr_mi
{-# LINE 213 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 72) p $ xrr_mi_modeFlags  xrr_mi
{-# LINE 214 "Graphics/X11/Xrandr.hsc" #-}
        -- see comment in Storable XRRScreenResources about dynamic resource allocation
        (\hsc_ptr -> pokeByteOff hsc_ptr 64) p ( 0 :: CInt )
{-# LINE 216 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 56) p ( nullPtr :: Ptr CChar )
{-# LINE 217 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRModeInfo
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 220 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 221 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 12) p )
{-# LINE 222 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 16) p )
{-# LINE 223 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 24) p )
{-# LINE 224 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 28) p )
{-# LINE 225 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 32) p )
{-# LINE 226 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 36) p )
{-# LINE 227 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 40) p )
{-# LINE 228 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 44) p )
{-# LINE 229 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 48) p )
{-# LINE 230 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCStringLenIO ((\hsc_ptr -> peekByteOff hsc_ptr 64) p)
{-# LINE 231 "Graphics/X11/Xrandr.hsc" #-}
                              ((\hsc_ptr -> peekByteOff hsc_ptr 56) p)
{-# LINE 232 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 72) p )
{-# LINE 233 "Graphics/X11/Xrandr.hsc" #-}

instance Storable XRRMonitorInfo where
    sizeOf _ = (56)
{-# LINE 236 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_moninf = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_moninf_name      xrr_moninf
{-# LINE 241 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_moninf_primary   xrr_moninf
{-# LINE 242 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ xrr_moninf_automatic xrr_moninf
{-# LINE 243 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 20) p $ xrr_moninf_x         xrr_moninf
{-# LINE 244 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ xrr_moninf_y         xrr_moninf
{-# LINE 245 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 28) p $ xrr_moninf_width     xrr_moninf
{-# LINE 246 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ xrr_moninf_height    xrr_moninf
{-# LINE 247 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 36) p $ xrr_moninf_mwidth    xrr_moninf
{-# LINE 248 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p $ xrr_moninf_mheight   xrr_moninf
{-# LINE 249 "Graphics/X11/Xrandr.hsc" #-}
        -- see comment in Storable XRRScreenResources about dynamic resource allocation
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p ( 0 :: CInt )
{-# LINE 251 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p ( nullPtr :: Ptr RROutput )
{-# LINE 252 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRMonitorInfo
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 255 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 256 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 12) p )
{-# LINE 257 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 20) p )
{-# LINE 258 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 24) p )
{-# LINE 259 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 28) p )
{-# LINE 260 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 32) p )
{-# LINE 261 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 36) p )
{-# LINE 262 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 40) p )
{-# LINE 263 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 264 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 48) p)
{-# LINE 265 "Graphics/X11/Xrandr.hsc" #-}


instance Storable XRRScreenResources where
    sizeOf _ = (64)
{-# LINE 269 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_sr = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_sr_timestamp       xrr_sr
{-# LINE 274 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_sr_configTimestamp xrr_sr
{-# LINE 275 "Graphics/X11/Xrandr.hsc" #-}
        -- there is no simple way to handle ptrs to arrays or struct through ffi
        -- Using plain malloc will result in a memory leak, unless the poking
        -- function will free the memory manually
        -- Unfortunately a ForeignPtr with a Finalizer is not going to work
        -- either, because the Finalizer will be run after poke returns, making
        -- the allocated memory unusable.
        -- The safest option is therefore probably to have the calling function
        -- handle this issue for itself
        -- e.g.
        -- #{poke XRRScreenResources, ncrtc} p ( fromIntegral $ length $ xrr_sr_crtcs xrr_sr :: CInt )
        -- crtcp <- mallocArray $ length $ xrr_sr_crtcs xrr_sr
        -- pokeArray crtcp $ xrr_sr_crtcs xrr_sr
        -- #{poke XRRScreenResources, crtcs} p crtcp
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p ( 0 :: CInt )
{-# LINE 289 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p ( 0 :: CInt )
{-# LINE 290 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p ( 0 :: CInt )
{-# LINE 291 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p ( nullPtr :: Ptr RRCrtc      )
{-# LINE 292 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p ( nullPtr :: Ptr RROutput    )
{-# LINE 293 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 56) p ( nullPtr :: Ptr XRRModeInfo )
{-# LINE 294 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRScreenResources
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 297 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 298 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 299 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 24) p)
{-# LINE 300 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 32) p)
{-# LINE 301 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 40) p)
{-# LINE 302 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 48) p)
{-# LINE 303 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 56) p)
{-# LINE 304 "Graphics/X11/Xrandr.hsc" #-}


instance Storable XRROutputInfo where
    sizeOf _ = (96)
{-# LINE 308 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_oi = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_oi_timestamp      xrr_oi
{-# LINE 313 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_oi_crtc           xrr_oi
{-# LINE 314 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ xrr_oi_mm_width       xrr_oi
{-# LINE 315 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p $ xrr_oi_mm_height      xrr_oi
{-# LINE 316 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p $ xrr_oi_connection     xrr_oi
{-# LINE 317 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 50) p $ xrr_oi_subpixel_order xrr_oi
{-# LINE 318 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 84) p $ xrr_oi_npreferred     xrr_oi
{-# LINE 319 "Graphics/X11/Xrandr.hsc" #-}
        -- see comment in Storable XRRScreenResources about dynamic resource allocation
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p ( 0 :: CInt )
{-# LINE 321 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 52) p ( 0 :: CInt )
{-# LINE 322 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 64) p ( 0 :: CInt )
{-# LINE 323 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 80) p ( 0 :: CInt )
{-# LINE 324 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p ( nullPtr :: Ptr CChar    )
{-# LINE 325 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 56) p ( nullPtr :: Ptr RRCrtc   )
{-# LINE 326 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 72) p ( nullPtr :: Ptr RROutput )
{-# LINE 327 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 88) p ( nullPtr :: Ptr RRMode   )
{-# LINE 328 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRROutputInfo
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 331 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 332 "Graphics/X11/Xrandr.hsc" #-}
            `ap` peekCStringLenIO ((\hsc_ptr -> peekByteOff hsc_ptr 24) p)
{-# LINE 333 "Graphics/X11/Xrandr.hsc" #-}
                                  ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 334 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 32) p )
{-# LINE 335 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 40) p )
{-# LINE 336 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 48) p )
{-# LINE 337 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 50) p )
{-# LINE 338 "Graphics/X11/Xrandr.hsc" #-}
            `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 52) p)
{-# LINE 339 "Graphics/X11/Xrandr.hsc" #-}
                              ((\hsc_ptr -> peekByteOff hsc_ptr 56) p)
{-# LINE 340 "Graphics/X11/Xrandr.hsc" #-}
            `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 64) p)
{-# LINE 341 "Graphics/X11/Xrandr.hsc" #-}
                              ((\hsc_ptr -> peekByteOff hsc_ptr 72) p)
{-# LINE 342 "Graphics/X11/Xrandr.hsc" #-}
            `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 84) p )
{-# LINE 343 "Graphics/X11/Xrandr.hsc" #-}
            `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 80) p)
{-# LINE 344 "Graphics/X11/Xrandr.hsc" #-}
                              ((\hsc_ptr -> peekByteOff hsc_ptr 88) p)
{-# LINE 345 "Graphics/X11/Xrandr.hsc" #-}


instance Storable XRRCrtcInfo where
    sizeOf _ = (64)
{-# LINE 349 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_ci = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_ci_timestamp xrr_ci
{-# LINE 354 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_ci_x         xrr_ci
{-# LINE 355 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ xrr_ci_y         xrr_ci
{-# LINE 356 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ xrr_ci_width     xrr_ci
{-# LINE 357 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 20) p $ xrr_ci_height    xrr_ci
{-# LINE 358 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ xrr_ci_mode      xrr_ci
{-# LINE 359 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ xrr_ci_rotation  xrr_ci
{-# LINE 360 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p $ xrr_ci_rotations xrr_ci
{-# LINE 361 "Graphics/X11/Xrandr.hsc" #-}
        -- see comment in Storable XRRScreenResources about dynamic resource allocation
        (\hsc_ptr -> pokeByteOff hsc_ptr 36) p ( 0 :: CInt )
{-# LINE 363 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 52) p ( 0 :: CInt )
{-# LINE 364 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p ( nullPtr :: Ptr RROutput )
{-# LINE 365 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 56) p ( nullPtr :: Ptr RROutput )
{-# LINE 366 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRCrtcInfo
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 369 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 370 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 12) p )
{-# LINE 371 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 16) p )
{-# LINE 372 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 20) p )
{-# LINE 373 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 24) p )
{-# LINE 374 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 32) p )
{-# LINE 375 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 36) p)
{-# LINE 376 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 40) p)
{-# LINE 377 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 48) p )
{-# LINE 378 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ((\hsc_ptr -> peekByteOff hsc_ptr 52) p)
{-# LINE 379 "Graphics/X11/Xrandr.hsc" #-}
                          ((\hsc_ptr -> peekByteOff hsc_ptr 56) p)
{-# LINE 380 "Graphics/X11/Xrandr.hsc" #-}


instance Storable XRRPropertyInfo where
    sizeOf _ = (24)
{-# LINE 384 "Graphics/X11/Xrandr.hsc" #-}
    -- FIXME: Is this right?
    alignment _ = alignment (undefined :: CInt)

    poke p xrr_pi = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xrr_pi_pending   xrr_pi
{-# LINE 389 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 4) p $ xrr_pi_range     xrr_pi
{-# LINE 390 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xrr_pi_immutable xrr_pi
{-# LINE 391 "Graphics/X11/Xrandr.hsc" #-}
        -- see comment in Storable XRRScreenResources about dynamic resource allocation
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p ( 0 :: CInt )
{-# LINE 393 "Graphics/X11/Xrandr.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p ( nullPtr :: Ptr CLong )
{-# LINE 394 "Graphics/X11/Xrandr.hsc" #-}

    peek p = return XRRPropertyInfo
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 0) p )
{-# LINE 397 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 4) p )
{-# LINE 398 "Graphics/X11/Xrandr.hsc" #-}
        `ap` ( (\hsc_ptr -> peekByteOff hsc_ptr 8) p )
{-# LINE 399 "Graphics/X11/Xrandr.hsc" #-}
        `ap` peekCArrayIO ( (\hsc_ptr -> peekByteOff hsc_ptr 12) p)
{-# LINE 400 "Graphics/X11/Xrandr.hsc" #-}
                          ( (\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 401 "Graphics/X11/Xrandr.hsc" #-}


xrrQueryExtension :: Display -> IO (Maybe (CInt, CInt))
xrrQueryExtension dpy = wrapPtr2 (cXRRQueryExtension dpy) go
  where go False _ _                = Nothing
        go True eventbase errorbase = Just (fromIntegral eventbase, fromIntegral errorbase)
foreign import ccall "XRRQueryExtension"
  cXRRQueryExtension :: Display -> Ptr CInt -> Ptr CInt -> IO Bool

xrrQueryVersion :: Display -> IO (Maybe (CInt, CInt))
xrrQueryVersion dpy = wrapPtr2 (cXRRQueryVersion dpy) go
  where go False _ _        = Nothing
        go True major minor = Just (fromIntegral major, fromIntegral minor)
foreign import ccall "XRRQueryVersion"
  cXRRQueryVersion :: Display -> Ptr CInt -> Ptr CInt -> IO Bool

xrrGetScreenInfo :: Display -> Drawable -> IO (Maybe XRRScreenConfiguration)
xrrGetScreenInfo dpy draw = do
  p <- cXRRGetScreenInfo dpy draw
  if p == nullPtr
     then return Nothing
     else return (Just (XRRScreenConfiguration p))
foreign import ccall "XRRGetScreenInfo"
  cXRRGetScreenInfo :: Display -> Drawable -> IO (Ptr XRRScreenConfiguration)

xrrFreeScreenConfigInfo :: XRRScreenConfiguration -> IO ()
xrrFreeScreenConfigInfo = cXRRFreeScreenConfigInfo
foreign import ccall "XRRFreeScreenConfigInfo"
  cXRRFreeScreenConfigInfo :: XRRScreenConfiguration -> IO ()

xrrSetScreenConfig :: Display -> XRRScreenConfiguration -> Drawable -> CInt -> Rotation -> Time -> IO Status
xrrSetScreenConfig = cXRRSetScreenConfig
foreign import ccall "XRRSetScreenConfig"
  cXRRSetScreenConfig :: Display -> XRRScreenConfiguration -> Drawable -> CInt -> Rotation -> Time -> IO Status

xrrSetScreenConfigAndRate :: Display -> XRRScreenConfiguration -> Drawable -> CInt -> Rotation -> CShort -> Time -> IO Status
xrrSetScreenConfigAndRate = cXRRSetScreenConfigAndRate
foreign import ccall "XRRSetScreenConfigAndRate"
  cXRRSetScreenConfigAndRate :: Display -> XRRScreenConfiguration -> Drawable -> CInt -> Rotation -> CShort -> Time -> IO Status

xrrConfigRotations :: XRRScreenConfiguration -> IO (Rotation, Rotation)
xrrConfigRotations config =
  withPool $ \pool -> do rptr <- pooledMalloc pool
                         rotations <- cXRRConfigRotations config rptr
                         cur_rotation <- peek rptr
                         return (rotations, cur_rotation)
foreign import ccall "XRRConfigRotations"
  cXRRConfigRotations :: XRRScreenConfiguration -> Ptr Rotation -> IO Rotation

xrrConfigTimes :: XRRScreenConfiguration -> IO (Time, Time)
xrrConfigTimes config =
  withPool $ \pool -> do tptr <- pooledMalloc pool
                         time <- cXRRConfigTimes config tptr
                         cur_time <- peek tptr
                         return (time, cur_time)
foreign import ccall "XRRConfigTimes"
  cXRRConfigTimes :: XRRScreenConfiguration -> Ptr Time -> IO Time

xrrConfigSizes :: XRRScreenConfiguration -> IO (Maybe [XRRScreenSize])
xrrConfigSizes config =
  withPool $ \pool -> do intp <- pooledMalloc pool
                         p <- cXRRConfigSizes config intp
                         if p == nullPtr
                            then return Nothing
                            else do nsizes <- peek intp
                                    sizes <- if nsizes == 0
                                                then return Nothing
                                                else peekArray (fromIntegral nsizes) p >>= return . Just
                                    return sizes
foreign import ccall "XRRConfigSizes"
  cXRRConfigSizes :: XRRScreenConfiguration -> Ptr CInt -> IO (Ptr XRRScreenSize)

xrrConfigRates :: XRRScreenConfiguration -> CInt -> IO (Maybe [CShort])
xrrConfigRates config size_index =
  withPool $ \pool -> do intp <- pooledMalloc pool
                         p <- cXRRConfigRates config size_index intp
                         if p == nullPtr
                            then return Nothing
                            else do nrates <- peek intp
                                    rates <- if nrates == 0
                                                then return Nothing
                                                else peekArray (fromIntegral nrates) p >>= return . Just
                                    return rates
foreign import ccall "XRRConfigRates"
  cXRRConfigRates :: XRRScreenConfiguration -> CInt -> Ptr CInt -> IO (Ptr CShort)

xrrConfigCurrentConfiguration :: XRRScreenConfiguration -> IO (Rotation, SizeID)
xrrConfigCurrentConfiguration config =
  withPool $ \pool -> do rptr <- pooledMalloc pool
                         sizeid <- cXRRConfigCurrentConfiguration config rptr
                         rotation <- peek rptr
                         return (rotation, sizeid)
foreign import ccall "XRRConfigCurrentConfiguration"
  cXRRConfigCurrentConfiguration :: XRRScreenConfiguration -> Ptr Rotation -> IO SizeID

xrrConfigCurrentRate :: XRRScreenConfiguration -> IO CShort
xrrConfigCurrentRate = cXRRConfigCurrentRate
foreign import ccall "XRRConfigCurrentRate"
  cXRRConfigCurrentRate :: XRRScreenConfiguration -> IO CShort

xrrRootToScreen :: Display -> Window -> IO CInt
xrrRootToScreen = cXRRRootToScreen
foreign import ccall "XRRRootToScreen"
  cXRRRootToScreen :: Display -> Window -> IO CInt

xrrSelectInput :: Display -> Window -> EventMask -> IO ()
xrrSelectInput dpy window mask = cXRRSelectInput dpy window (fromIntegral mask)
foreign import ccall "XRRSelectInput"
  cXRRSelectInput :: Display -> Window -> CInt -> IO ()

xrrUpdateConfiguration :: XEventPtr -> IO CInt
xrrUpdateConfiguration = cXRRUpdateConfiguration
foreign import ccall "XRRUpdateConfiguration"
  cXRRUpdateConfiguration :: XEventPtr -> IO CInt

xrrRotations :: Display -> CInt -> IO (Rotation, Rotation)
xrrRotations dpy screen =
  withPool $ \pool -> do rptr <- pooledMalloc pool
                         rotations <- cXRRRotations dpy screen rptr
                         cur_rotation <- peek rptr
                         return (rotations, cur_rotation)
foreign import ccall "XRRRotations"
  cXRRRotations :: Display -> CInt -> Ptr Rotation -> IO Rotation

xrrSizes :: Display -> CInt -> IO (Maybe [XRRScreenSize])
xrrSizes dpy screen =
  withPool $ \pool -> do intp <- pooledMalloc pool
                         p <- cXRRSizes dpy screen intp
                         if p == nullPtr
                            then return Nothing
                            else do nsizes <- peek intp
                                    sizes <- if nsizes == 0
                                                then return Nothing
                                                else peekArray (fromIntegral nsizes) p >>= return . Just
                                    return sizes
foreign import ccall "XRRSizes"
  cXRRSizes :: Display -> CInt -> Ptr CInt -> IO (Ptr XRRScreenSize)

xrrRates :: Display -> CInt -> CInt -> IO (Maybe [CShort])
xrrRates dpy screen size_index =
  withPool $ \pool -> do intp <- pooledMalloc pool
                         p <- cXRRRates dpy screen size_index intp
                         if p == nullPtr
                            then return Nothing
                            else do nrates <- peek intp
                                    rates <- if nrates == 0
                                                then return Nothing
                                                else peekArray (fromIntegral nrates) p >>= return . Just
                                    return rates
foreign import ccall "XRRRates"
  cXRRRates :: Display -> CInt -> CInt -> Ptr CInt -> IO (Ptr CShort)

xrrTimes :: Display -> CInt -> IO (Time, Time)
xrrTimes dpy screen =
  withPool $ \pool -> do tptr <- pooledMalloc pool
                         time <- cXRRTimes dpy screen tptr
                         config_time <- peek tptr
                         return (time, config_time)
foreign import ccall "XRRTimes"
  cXRRTimes :: Display -> CInt -> Ptr Time -> IO Time

xrrGetScreenResources :: Display -> Window -> IO (Maybe XRRScreenResources)
xrrGetScreenResources dpy win = do
    srp <- cXRRGetScreenResources dpy win
    if srp == nullPtr
        then return Nothing
        else do
            res <- peek srp
            cXRRFreeScreenResources srp
            return $ Just res

foreign import ccall "XRRGetScreenResources"
    cXRRGetScreenResources :: Display -> Window -> IO (Ptr XRRScreenResources)

foreign import ccall "XRRFreeScreenResources"
    cXRRFreeScreenResources :: Ptr XRRScreenResources -> IO ()

xrrGetOutputInfo :: Display -> XRRScreenResources -> RROutput -> IO (Maybe XRROutputInfo)
xrrGetOutputInfo dpy xrr_sr rro = withPool $ \pool -> do
    -- XRRGetOutputInfo only uses the timestamp field from the
    -- XRRScreenResources struct, so it's probably ok to pass the incomplete
    -- structure here (see also the poke implementation for the Storable
    -- instance of XRRScreenResources)
    -- Alternative version below; This is extremely slow, though!
    {- xrrGetOutputInfo :: Display -> Window -> RROutput -> IO (Maybe XRROutputInfo)
       xrrGetOutputInfo dpy win rro = do
           srp <- cXRRGetScreenResources dpy win
           oip <- cXRRGetOutputInfo dpy srp rro
           cXRRFreeScreenResources srp
    -}
    oip <- pooledMalloc pool >>= \srp -> do
        poke srp xrr_sr
        cXRRGetOutputInfo dpy srp rro -- no need to free srp, because pool mem

    if oip == nullPtr
        then return Nothing
        else do
            oi <- peek oip
            _ <- cXRRFreeOutputInfo oip
            return $ Just oi

foreign import ccall "XRRGetOutputInfo"
    cXRRGetOutputInfo :: Display -> Ptr XRRScreenResources -> RROutput -> IO (Ptr XRROutputInfo)

foreign import ccall "XRRFreeOutputInfo"
    cXRRFreeOutputInfo :: Ptr XRROutputInfo -> IO ()

xrrGetCrtcInfo :: Display -> XRRScreenResources -> RRCrtc -> IO (Maybe XRRCrtcInfo)
xrrGetCrtcInfo dpy xrr_sr crtc = withPool $ \pool -> do
    -- XRRGetCrtcInfo only uses the timestamp field from the
    -- XRRScreenResources struct, so it's probably ok to pass the incomplete
    -- structure here (see also the poke implementation for the Storable
    -- instance of XRRScreenResources)
    cip <- pooledMalloc pool >>= \srp -> do
        poke srp xrr_sr
        cXRRGetCrtcInfo dpy srp crtc -- no need to free srp, because pool mem

    if cip == nullPtr
        then return Nothing
        else do
            ci <- peek cip
            cXRRFreeCrtcInfo cip
            return $ Just ci

foreign import ccall "XRRGetCrtcInfo"
    cXRRGetCrtcInfo :: Display -> Ptr XRRScreenResources -> RRCrtc -> IO (Ptr XRRCrtcInfo)

foreign import ccall "XRRFreeCrtcInfo"
    cXRRFreeCrtcInfo :: Ptr XRRCrtcInfo -> IO ()

foreign import ccall "XRRSetOutputPrimary"
    xrrSetOutputPrimary :: Display -> Window -> RROutput -> IO ()

foreign import ccall "XRRGetOutputPrimary"
    xrrGetOutputPrimary :: Display -> Window -> IO RROutput

xrrGetScreenResourcesCurrent :: Display -> Window -> IO (Maybe XRRScreenResources)
xrrGetScreenResourcesCurrent dpy win = do
    srcp <- cXRRGetScreenResourcesCurrent dpy win
    if srcp == nullPtr
        then return Nothing
        else do
            res <- peek srcp
            cXRRFreeScreenResources srcp
            return $ Just res

foreign import ccall "XRRGetScreenResourcesCurrent"
    cXRRGetScreenResourcesCurrent :: Display -> Window -> IO (Ptr XRRScreenResources)

xrrListOutputProperties :: Display -> RROutput -> IO (Maybe [Atom])
xrrListOutputProperties dpy rro = withPool $ \pool -> do
    intp <- pooledMalloc pool
    p <- cXRRListOutputProperties dpy rro intp
    if p == nullPtr
        then return Nothing
        else do
            nprop <- peek intp
            res <- fmap Just $ peekCArray nprop p
            _ <- xFree p
            return res

foreign import ccall "XRRListOutputProperties"
    cXRRListOutputProperties :: Display -> RROutput -> Ptr CInt -> IO (Ptr Atom)

xrrQueryOutputProperty :: Display -> RROutput -> Atom -> IO (Maybe XRRPropertyInfo)
xrrQueryOutputProperty dpy rro prop = do
    p <- cXRRQueryOutputProperty dpy rro prop
    if p == nullPtr
        then return Nothing
        else do
            res <- peek p
            _ <- xFree p
            return $ Just res

foreign import ccall "XRRQueryOutputProperty"
    cXRRQueryOutputProperty :: Display -> RROutput -> Atom -> IO (Ptr XRRPropertyInfo)

xrrConfigureOutputProperty :: Display -> RROutput -> Atom -> Bool -> Bool -> [CLong] -> IO ()
xrrConfigureOutputProperty dpy rro prop pend range xs = withArrayLen xs $
    cXRRConfigureOutputProperty dpy rro prop pend range . fromIntegral

foreign import ccall "XRRConfigureOutputProperty"
    cXRRConfigureOutputProperty :: Display -> RROutput -> Atom -> Bool -> Bool -> CInt ->  Ptr CLong -> IO ()

xrrChangeOutputProperty :: Display -> RROutput -> Atom -> Atom -> CInt -> CInt -> [Word32] -> IO ()
xrrChangeOutputProperty dpy rro prop typ format mode xs = withPool $ \pool -> do
    ptr <- case format of
        8 ->  pooledNewArray pool (map fromIntegral xs :: [Word8])
        16 -> castPtr `fmap` pooledNewArray pool (map fromIntegral xs :: [Word16])
        32 -> castPtr `fmap` pooledNewArray pool xs
        _  -> error "invalid format"

    cXRRChangeOutputProperty dpy rro prop typ format mode ptr (fromIntegral $ length xs)

foreign import ccall "XRRChangeOutputProperty"
    cXRRChangeOutputProperty :: Display -> RROutput -> Atom -> Atom -> CInt -> CInt -> Ptr Word8 -> CInt -> IO ()

-- | @xrrGetOutputProperty display output property offset length delete pending propertyType@
-- | returns @Maybe (actualType, format, bytesAfter, data)@.
xrrGetOutputProperty ::
    Display -> RROutput -> Atom -> CLong -> CLong -> Bool -> Bool -> Atom ->
    IO (Maybe (Atom, Int, CULong, [Word32]))
xrrGetOutputProperty dpy rro prop offset len delete preferPending reqType = withPool $ \pool -> do
    actualTypep <- pooledMalloc pool
    actualFormatp <- pooledMalloc pool
    nItemsp <- pooledMalloc pool
    bytesAfterp <- pooledMalloc pool
    datapp <- pooledMalloc pool
    status <- cXRRGetOutputProperty dpy rro prop offset len
        delete preferPending reqType
        actualTypep actualFormatp nItemsp bytesAfterp datapp

    if status /= 0
        then return Nothing
        else do
          format <- fmap fromIntegral (peek actualFormatp)
          nitems <- fmap fromIntegral (peek nItemsp)
          ptr <- peek datapp

          dat <- case format of
            0 -> return []
            8 -> fmap (map fromIntegral) $ peekArray nitems ptr
            16 -> fmap (map fromIntegral) $ peekArray nitems (castPtr ptr :: Ptr Word16)
            32 -> peekArray nitems (castPtr ptr :: Ptr Word32)
            _  -> error $ "impossible happened: prop format is not in 0,8,16,32 (" ++ show format ++ ")"

          _ <- if format /= 0
                  then xFree ptr
                  else return 0

          typ <- peek actualTypep
          bytesAfter <- peek bytesAfterp
          return $ Just (typ, format, bytesAfter, dat)

foreign import ccall "XRRGetOutputProperty"
    cXRRGetOutputProperty :: Display -> RROutput -> Atom -> CLong -> CLong -> Bool -> Bool
      -> Atom -> Ptr Atom -> Ptr CInt -> Ptr CULong -> Ptr CULong -> Ptr (Ptr Word8) -> IO CInt

xrrDeleteOutputProperty :: Display -> RROutput -> Atom -> IO ()
xrrDeleteOutputProperty = cXRRDeleteOutputProperty
foreign import ccall "XRRDeleteOutputProperty"
    cXRRDeleteOutputProperty :: Display -> RROutput -> Atom -> IO ()

xrrGetMonitors :: Display -> Drawable -> Bool -> IO (Maybe [XRRMonitorInfo])
xrrGetMonitors dpy draw get_active = withPool $ \pool -> do
    intp <- pooledMalloc pool
    p <- cXRRGetMonitors dpy draw get_active intp
    if p == nullPtr
        then return Nothing
        else do
            nmonitors <- peek intp
            res <- fmap Just $ peekCArray nmonitors p
            cXRRFreeMonitors p
            return res

foreign import ccall "XRRGetMonitors"
    cXRRGetMonitors :: Display -> Drawable -> Bool -> Ptr CInt -> IO (Ptr XRRMonitorInfo)

foreign import ccall "XRRFreeMonitors"
    cXRRFreeMonitors :: Ptr XRRMonitorInfo -> IO ()

wrapPtr2 :: (Storable a, Storable b) => (Ptr a -> Ptr b -> IO c) -> (c -> a -> b -> d) -> IO d
wrapPtr2 cfun f =
  withPool $ \pool -> do aptr <- pooledMalloc pool
                         bptr <- pooledMalloc pool
                         ret <- cfun aptr bptr
                         a <- peek aptr
                         b <- peek bptr
                         return (f ret a b)

peekCArray :: Storable a => CInt -> Ptr a -> IO [a]
peekCArray n = peekArray (fromIntegral n)

peekCArrayIO :: Storable a => IO CInt -> IO (Ptr a) -> IO [a]
peekCArrayIO n = join . liftM2 peekCArray n

peekCStringLenIO :: IO CInt -> IO (Ptr CChar) -> IO String
peekCStringLenIO n p = liftM2 (,) p (fmap fromIntegral n) >>= peekCStringLen
