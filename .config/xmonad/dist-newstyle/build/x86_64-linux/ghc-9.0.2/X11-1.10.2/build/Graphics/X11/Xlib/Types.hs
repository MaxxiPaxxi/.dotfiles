{-# LINE 1 "Graphics/X11/Xlib/Types.hsc" #-}
{-# LANGUAGE DeriveDataTypeable #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.X11.Xlib.Types
-- Copyright   :  (c) Alastair Reid, 1999-2003
-- License     :  BSD-style (see the file libraries/base/LICENSE)
--
-- Maintainer  :  libraries@haskell.org
-- Stability   :  provisional
-- Portability :  portable
--
-- A collection of type declarations for interfacing with Xlib.
--
-----------------------------------------------------------------------------

-- #hide
module Graphics.X11.Xlib.Types(
        Display(..), Screen(..), Visual(..), GC(..), GCValues, SetWindowAttributes,
        VisualInfo(..),
        Image(..), Point(..), Rectangle(..), Arc(..), Segment(..), Color(..),
        Pixel, Position, Dimension, Angle, ScreenNumber, Buffer
        ) where

import Graphics.X11.Types

-- import Control.Monad( zipWithM_ )
import Data.Int
import Data.Word
import Foreign.C.Types
-- import Foreign.Marshal.Alloc( allocaBytes )
import Foreign.Ptr
import Foreign.Storable( Storable(..) )


{-# LINE 35 "Graphics/X11/Xlib/Types.hsc" #-}
import Data.Data

{-# LINE 37 "Graphics/X11/Xlib/Types.hsc" #-}

import Data.Default.Class



----------------------------------------------------------------
-- Types
----------------------------------------------------------------

-- | pointer to an X11 @Display@ structure
newtype Display    = Display    (Ptr Display)

{-# LINE 49 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 53 "Graphics/X11/Xlib/Types.hsc" #-}

-- | pointer to an X11 @Screen@ structure
newtype Screen     = Screen     (Ptr Screen)

{-# LINE 57 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 61 "Graphics/X11/Xlib/Types.hsc" #-}

-- | pointer to an X11 @Visual@ structure
newtype Visual     = Visual     (Ptr Visual)

{-# LINE 65 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 69 "Graphics/X11/Xlib/Types.hsc" #-}

-- | pointer to an X11 @GC@ structure
newtype GC         = GC         (Ptr GC)

{-# LINE 73 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 77 "Graphics/X11/Xlib/Types.hsc" #-}

-- | pointer to an X11 @XGCValues@ structure
newtype GCValues   = GCValues  (Ptr GCValues)

{-# LINE 81 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 85 "Graphics/X11/Xlib/Types.hsc" #-}

-- | pointer to an X11 @XSetWindowAttributes@ structure
newtype SetWindowAttributes = SetWindowAttributes (Ptr SetWindowAttributes)

{-# LINE 89 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 93 "Graphics/X11/Xlib/Types.hsc" #-}

-- | counterpart of an X11 @XVisualInfo@ structure
data VisualInfo = VisualInfo {
        visualInfo_visual :: Visual,
        visualInfo_visualID :: VisualID,
        visualInfo_screen :: ScreenNumber,
        visualInfo_depth :: CInt,
        visualInfo_class :: CInt,
        visualInfo_redMask :: CULong,
        visualInfo_greenMask :: CULong,
        visualInfo_blueMask :: CULong,
        visualInfo_colormapSize :: CInt,
        visualInfo_bitsPerRGB :: CInt
        }

{-# LINE 108 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Show, Typeable)

{-# LINE 112 "Graphics/X11/Xlib/Types.hsc" #-}

instance Default VisualInfo where
    def = VisualInfo {
        visualInfo_visual = Visual nullPtr,
        visualInfo_visualID = 0,
        visualInfo_screen = 0,
        visualInfo_depth = 0,
        visualInfo_class = 0,
        visualInfo_redMask = 0,
        visualInfo_greenMask = 0,
        visualInfo_blueMask = 0,
        visualInfo_colormapSize = 0,
        visualInfo_bitsPerRGB = 0
        }

instance Storable VisualInfo where
        sizeOf _ = (64)
{-# LINE 129 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                visual <- Visual `fmap` (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 132 "Graphics/X11/Xlib/Types.hsc" #-}
                visualID <- (\hsc_ptr -> peekByteOff hsc_ptr 8) p
{-# LINE 133 "Graphics/X11/Xlib/Types.hsc" #-}
                screen <- (\hsc_ptr -> peekByteOff hsc_ptr 16) p
{-# LINE 134 "Graphics/X11/Xlib/Types.hsc" #-}
                depth <- (\hsc_ptr -> peekByteOff hsc_ptr 20) p
{-# LINE 135 "Graphics/X11/Xlib/Types.hsc" #-}
                class_ <- (\hsc_ptr -> peekByteOff hsc_ptr 24) p
{-# LINE 136 "Graphics/X11/Xlib/Types.hsc" #-}
                redMask <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 137 "Graphics/X11/Xlib/Types.hsc" #-}
                greenMask <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 138 "Graphics/X11/Xlib/Types.hsc" #-}
                blueMask <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 139 "Graphics/X11/Xlib/Types.hsc" #-}
                colormapSize <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 140 "Graphics/X11/Xlib/Types.hsc" #-}
                bitsPerRGB <- (\hsc_ptr -> peekByteOff hsc_ptr 60) p
{-# LINE 141 "Graphics/X11/Xlib/Types.hsc" #-}
                return $ VisualInfo {
                        visualInfo_visual = visual,
                        visualInfo_visualID = visualID,
                        visualInfo_screen = screen,
                        visualInfo_depth = depth,
                        visualInfo_class = class_,
                        visualInfo_redMask = redMask,
                        visualInfo_greenMask = greenMask,
                        visualInfo_blueMask = blueMask,
                        visualInfo_colormapSize = colormapSize,
                        visualInfo_bitsPerRGB = bitsPerRGB
                        }
        poke p info = do
                (\hsc_ptr -> pokeByteOff hsc_ptr 0) p visualPtr
{-# LINE 155 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ visualInfo_visualID info
{-# LINE 156 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ visualInfo_screen info
{-# LINE 157 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 20) p $ visualInfo_depth info
{-# LINE 158 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ visualInfo_class info
{-# LINE 159 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ visualInfo_redMask info
{-# LINE 160 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 40) p $ visualInfo_greenMask info
{-# LINE 161 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 48) p $ visualInfo_blueMask info
{-# LINE 162 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 56) p $
{-# LINE 163 "Graphics/X11/Xlib/Types.hsc" #-}
                        visualInfo_colormapSize info
                (\hsc_ptr -> pokeByteOff hsc_ptr 60) p $
{-# LINE 165 "Graphics/X11/Xlib/Types.hsc" #-}
                        visualInfo_bitsPerRGB info
                where
                        ~(Visual visualPtr) = visualInfo_visual info

-- | pointer to an X11 @XImage@ structure
newtype Image    = Image    (Ptr Image)

{-# LINE 172 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Ord, Show, Typeable, Data)

{-# LINE 176 "Graphics/X11/Xlib/Types.hsc" #-}

type Pixel         = Word64
{-# LINE 178 "Graphics/X11/Xlib/Types.hsc" #-}
type Position      = Int32
{-# LINE 179 "Graphics/X11/Xlib/Types.hsc" #-}
type Dimension     = Word32
{-# LINE 180 "Graphics/X11/Xlib/Types.hsc" #-}
type Angle         = CInt
type ScreenNumber  = Word32
type Buffer        = CInt

----------------------------------------------------------------
-- Short forms used in structs
----------------------------------------------------------------

type ShortPosition = CShort
type ShortDimension = CUShort
type ShortAngle    = CShort

peekPositionField :: Ptr a -> CInt -> IO Position
peekPositionField ptr off = do
        v <- peekByteOff ptr (fromIntegral off)
        return (fromIntegral (v::ShortPosition))

peekDimensionField :: Ptr a -> CInt -> IO Dimension
peekDimensionField ptr off = do
        v <- peekByteOff ptr (fromIntegral off)
        return (fromIntegral (v::ShortDimension))

peekAngleField :: Ptr a -> CInt -> IO Angle
peekAngleField ptr off = do
        v <- peekByteOff ptr (fromIntegral off)
        return (fromIntegral (v::ShortAngle))

pokePositionField :: Ptr a -> CInt -> Position -> IO ()
pokePositionField ptr off v =
        pokeByteOff ptr (fromIntegral off) (fromIntegral v::ShortPosition)

pokeDimensionField :: Ptr a -> CInt -> Dimension -> IO ()
pokeDimensionField ptr off v =
        pokeByteOff ptr (fromIntegral off) (fromIntegral v::ShortDimension)

pokeAngleField :: Ptr a -> CInt -> Angle -> IO ()
pokeAngleField ptr off v =
        pokeByteOff ptr (fromIntegral off) (fromIntegral v::ShortAngle)

----------------------------------------------------------------
-- Point
----------------------------------------------------------------

-- | counterpart of an X11 @XPoint@ structure
data Point = Point { pt_x :: !Position, pt_y :: !Position }

{-# LINE 226 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Show, Typeable, Data)

{-# LINE 230 "Graphics/X11/Xlib/Types.hsc" #-}

instance Storable Point where
        sizeOf _ = (4)
{-# LINE 233 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                x <- peekPositionField p (0)
{-# LINE 236 "Graphics/X11/Xlib/Types.hsc" #-}
                y <- peekPositionField p (2)
{-# LINE 237 "Graphics/X11/Xlib/Types.hsc" #-}
                return (Point x y)
        poke p (Point x y) = do
                pokePositionField p (0) x
{-# LINE 240 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (2) y
{-# LINE 241 "Graphics/X11/Xlib/Types.hsc" #-}

----------------------------------------------------------------
-- Rectangle
----------------------------------------------------------------

-- | counterpart of an X11 @XRectangle@ structure
data Rectangle = Rectangle {
        rect_x      :: !Position,
        rect_y      :: !Position,
        rect_width  :: !Dimension,
        rect_height :: !Dimension
        }

{-# LINE 254 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Read, Show, Typeable, Data)

{-# LINE 258 "Graphics/X11/Xlib/Types.hsc" #-}

instance Storable Rectangle where
        sizeOf _ = (8)
{-# LINE 261 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                x       <- peekPositionField p (0)
{-# LINE 264 "Graphics/X11/Xlib/Types.hsc" #-}
                y       <- peekPositionField p (2)
{-# LINE 265 "Graphics/X11/Xlib/Types.hsc" #-}
                width   <- peekDimensionField p (4)
{-# LINE 266 "Graphics/X11/Xlib/Types.hsc" #-}
                height  <- peekDimensionField p (6)
{-# LINE 267 "Graphics/X11/Xlib/Types.hsc" #-}
                return (Rectangle x y width height)
        poke p (Rectangle x y width height) = do
                pokePositionField p (0) x
{-# LINE 270 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (2) y
{-# LINE 271 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeDimensionField p (4) width
{-# LINE 272 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeDimensionField p (6) height
{-# LINE 273 "Graphics/X11/Xlib/Types.hsc" #-}

----------------------------------------------------------------
-- Arc
----------------------------------------------------------------

-- | counterpart of an X11 @XArc@ structure
data Arc = Arc {
        arc_x :: Position,
        arc_y :: Position,
        arc_width :: Dimension,
        arc_height :: Dimension,
        arc_angle1 :: Angle,
        arc_angle2 :: Angle
        }

{-# LINE 288 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Show, Typeable)

{-# LINE 292 "Graphics/X11/Xlib/Types.hsc" #-}

instance Storable Arc where
        sizeOf _ = (12)
{-# LINE 295 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                x       <- peekPositionField p (0)
{-# LINE 298 "Graphics/X11/Xlib/Types.hsc" #-}
                y       <- peekPositionField p (2)
{-# LINE 299 "Graphics/X11/Xlib/Types.hsc" #-}
                width   <- peekDimensionField p (4)
{-# LINE 300 "Graphics/X11/Xlib/Types.hsc" #-}
                height  <- peekDimensionField p (6)
{-# LINE 301 "Graphics/X11/Xlib/Types.hsc" #-}
                angle1  <- peekAngleField p (8)
{-# LINE 302 "Graphics/X11/Xlib/Types.hsc" #-}
                angle2  <- peekAngleField p (10)
{-# LINE 303 "Graphics/X11/Xlib/Types.hsc" #-}
                return (Arc x y width height angle1 angle2)
        poke p (Arc x y width height angle1 angle2) = do
                pokePositionField p (0) x
{-# LINE 306 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (2) y
{-# LINE 307 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeDimensionField p (4) width
{-# LINE 308 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeDimensionField p (6) height
{-# LINE 309 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeAngleField p (8) angle1
{-# LINE 310 "Graphics/X11/Xlib/Types.hsc" #-}
                pokeAngleField p (10) angle2
{-# LINE 311 "Graphics/X11/Xlib/Types.hsc" #-}

----------------------------------------------------------------
-- Segment
----------------------------------------------------------------

-- | counterpart of an X11 @XSegment@ structure
data Segment = Segment {
        seg_x1 :: Position,
        seg_y1 :: Position,
        seg_x2 :: Position,
        seg_y2 :: Position
        }

{-# LINE 324 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Show, Typeable, Data)

{-# LINE 328 "Graphics/X11/Xlib/Types.hsc" #-}

instance Storable Segment where
        sizeOf _ = (8)
{-# LINE 331 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                x1 <- peekPositionField p (0)
{-# LINE 334 "Graphics/X11/Xlib/Types.hsc" #-}
                y1 <- peekPositionField p (2)
{-# LINE 335 "Graphics/X11/Xlib/Types.hsc" #-}
                x2 <- peekPositionField p (4)
{-# LINE 336 "Graphics/X11/Xlib/Types.hsc" #-}
                y2 <- peekPositionField p (6)
{-# LINE 337 "Graphics/X11/Xlib/Types.hsc" #-}
                return (Segment x1 y1 x2 y2)
        poke p (Segment x1 y1 x2 y2) = do
                pokePositionField p (0) x1
{-# LINE 340 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (2) y1
{-# LINE 341 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (4) x2
{-# LINE 342 "Graphics/X11/Xlib/Types.hsc" #-}
                pokePositionField p (6) y2
{-# LINE 343 "Graphics/X11/Xlib/Types.hsc" #-}

----------------------------------------------------------------
-- Color
----------------------------------------------------------------

-- | counterpart of an X11 @XColor@ structure
data Color = Color {
        color_pixel :: Pixel,
        color_red :: Word16,
        color_green :: Word16,
        color_blue :: Word16,
        color_flags :: Word8
        }

{-# LINE 357 "Graphics/X11/Xlib/Types.hsc" #-}
        deriving (Eq, Show, Typeable, Data)

{-# LINE 361 "Graphics/X11/Xlib/Types.hsc" #-}

instance Storable Color where
        sizeOf _ = (16)
{-# LINE 364 "Graphics/X11/Xlib/Types.hsc" #-}
        alignment _ = alignment (undefined::CInt)
        peek p = do
                pixel   <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 367 "Graphics/X11/Xlib/Types.hsc" #-}
                red     <- (\hsc_ptr -> peekByteOff hsc_ptr 8)   p
{-# LINE 368 "Graphics/X11/Xlib/Types.hsc" #-}
                green   <- (\hsc_ptr -> peekByteOff hsc_ptr 10) p
{-# LINE 369 "Graphics/X11/Xlib/Types.hsc" #-}
                blue    <- (\hsc_ptr -> peekByteOff hsc_ptr 12)  p
{-# LINE 370 "Graphics/X11/Xlib/Types.hsc" #-}
                flags   <- (\hsc_ptr -> peekByteOff hsc_ptr 14) p
{-# LINE 371 "Graphics/X11/Xlib/Types.hsc" #-}
                return (Color pixel red green blue flags)
        poke p (Color pixel red green blue flags) = do
                (\hsc_ptr -> pokeByteOff hsc_ptr 0)    p pixel
{-# LINE 374 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 8)      p red
{-# LINE 375 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 10)    p green
{-# LINE 376 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 12)     p blue
{-# LINE 377 "Graphics/X11/Xlib/Types.hsc" #-}
                (\hsc_ptr -> pokeByteOff hsc_ptr 14)    p flags
{-# LINE 378 "Graphics/X11/Xlib/Types.hsc" #-}

----------------------------------------------------------------
-- End
----------------------------------------------------------------
