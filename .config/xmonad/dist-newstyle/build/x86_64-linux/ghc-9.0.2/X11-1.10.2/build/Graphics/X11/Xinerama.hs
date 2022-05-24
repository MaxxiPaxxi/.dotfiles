{-# LINE 1 "Graphics/X11/Xinerama.hsc" #-}
--------------------------------------------------------------------
-- |
-- Module    : Graphics.X11.Xinerama
-- Copyright : (c) Haskell.org, 2007
-- License   : BSD3
--
-- Maintainer: Don Stewart <dons@galois.com>
-- Stability : provisional
-- Portability: portable
--
--------------------------------------------------------------------
--
-- Interface to Xinerama API
--

module Graphics.X11.Xinerama (
   XineramaScreenInfo(..),
   xineramaIsActive,
   xineramaQueryExtension,
   xineramaQueryVersion,
   xineramaQueryScreens,
   compiledWithXinerama,
   getScreenInfo
 ) where



import Foreign
import Foreign.C.Types
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras (WindowAttributes(..), getWindowAttributes)
import Graphics.X11.Xlib.Internal
import Control.Monad

-- | Representation of the XineramaScreenInfo struct
data XineramaScreenInfo = XineramaScreenInfo
                          { xsi_screen_number :: !CInt,
                            xsi_x_org         :: !CShort,
                            xsi_y_org         :: !CShort,
                            xsi_width         :: !CShort,
                            xsi_height        :: !CShort }
                            deriving (Show)

-- | Wrapper around xineramaQueryScreens that fakes a single screen when
-- Xinerama is not active. This is the preferred interface to
-- Graphics.X11.Xinerama.
getScreenInfo :: Display -> IO [Rectangle]
getScreenInfo dpy = do
    mxs <- xineramaQueryScreens dpy
    case mxs of
        Just xs -> return . map xsiToRect $ xs
        Nothing -> do
            wa <- getWindowAttributes dpy (defaultRootWindow dpy)
            return $ [Rectangle
                        { rect_x      = fromIntegral $ wa_x wa
                        , rect_y      = fromIntegral $ wa_y wa
                        , rect_width  = fromIntegral $ wa_width wa
                        , rect_height = fromIntegral $ wa_height wa }]
 where
    xsiToRect xsi = Rectangle
                    { rect_x        = fromIntegral $ xsi_x_org xsi
                    , rect_y        = fromIntegral $ xsi_y_org xsi
                    , rect_width    = fromIntegral $ xsi_width xsi
                    , rect_height   = fromIntegral $ xsi_height xsi
                    }


{-# LINE 68 "Graphics/X11/Xinerama.hsc" #-}
-- We have Xinerama, so the library will actually work
compiledWithXinerama :: Bool
compiledWithXinerama = True



instance Storable XineramaScreenInfo where
  sizeOf _ = (12)
{-# LINE 76 "Graphics/X11/Xinerama.hsc" #-}
  -- FIXME: Is this right?
  alignment _ = alignment (undefined :: CInt)

  poke p xsi = do
    (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ xsi_screen_number xsi
{-# LINE 81 "Graphics/X11/Xinerama.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 4) p $ xsi_x_org xsi
{-# LINE 82 "Graphics/X11/Xinerama.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 6) p $ xsi_y_org xsi
{-# LINE 83 "Graphics/X11/Xinerama.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ xsi_width xsi
{-# LINE 84 "Graphics/X11/Xinerama.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 10) p $ xsi_height xsi
{-# LINE 85 "Graphics/X11/Xinerama.hsc" #-}

  peek p = return XineramaScreenInfo
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 0) p)
{-# LINE 88 "Graphics/X11/Xinerama.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 4) p)
{-# LINE 89 "Graphics/X11/Xinerama.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 6) p)
{-# LINE 90 "Graphics/X11/Xinerama.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 8) p)
{-# LINE 91 "Graphics/X11/Xinerama.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 10) p)
{-# LINE 92 "Graphics/X11/Xinerama.hsc" #-}

foreign import ccall "XineramaIsActive"
  xineramaIsActive :: Display -> IO Bool

xineramaQueryExtension :: Display -> IO (Maybe (CInt, CInt))
xineramaQueryExtension dpy = wrapPtr2 (cXineramaQueryExtension dpy) go
  where go False _ _                = Nothing
        go True eventbase errorbase = Just (fromIntegral eventbase, fromIntegral errorbase)

xineramaQueryVersion :: Display -> IO (Maybe (CInt, CInt))
xineramaQueryVersion dpy = wrapPtr2 (cXineramaQueryVersion dpy) go
  where go False _ _        = Nothing
        go True major minor = Just (fromIntegral major, fromIntegral minor)

xineramaQueryScreens :: Display -> IO (Maybe [XineramaScreenInfo])
xineramaQueryScreens dpy =
  withPool $ \pool -> do intp <- pooledMalloc pool
                         p <- cXineramaQueryScreens dpy intp
                         if p == nullPtr
                            then return Nothing
                            else do nscreens <- peek intp
                                    screens <- peekArray (fromIntegral nscreens) p
                                    _ <- xFree p
                                    return (Just screens)

foreign import ccall "XineramaQueryExtension"
  cXineramaQueryExtension :: Display -> Ptr CInt -> Ptr CInt -> IO Bool

foreign import ccall "XineramaQueryVersion"
  cXineramaQueryVersion :: Display -> Ptr CInt -> Ptr CInt -> IO Bool

foreign import ccall "XineramaQueryScreens"
  cXineramaQueryScreens :: Display -> Ptr CInt -> IO (Ptr XineramaScreenInfo)

wrapPtr2 :: (Storable a, Storable b) => (Ptr a -> Ptr b -> IO c) -> (c -> a -> b -> d) -> IO d
wrapPtr2 cfun f =
  withPool $ \pool -> do aptr <- pooledMalloc pool
                         bptr <- pooledMalloc pool
                         ret <- cfun aptr bptr
                         a <- peek aptr
                         b <- peek bptr
                         return (f ret a b)


{-# LINE 155 "Graphics/X11/Xinerama.hsc" #-}
