{-# LINE 1 "Graphics/X11/Xlib/Extras.hsc" #-}
{-# LANGUAGE DeriveDataTypeable #-}
-----------------------------------------------------------------------------
-- |
-- Module      : Graphics.X11.Xlib.Extras
-- Copyright   : 2007 (c) Spencer Janssen
-- License     : BSD3-style (see LICENSE)
-- Stability   : experimental
--
-----------------------------------------------------------------------------
--
-- missing functionality from the X11 library
--

module Graphics.X11.Xlib.Extras (
  module Graphics.X11.Xlib.Extras,
  module Graphics.X11.Xlib.Internal
  ) where

import Data.Maybe
import Data.Typeable ( Typeable )
import Graphics.X11.Xrandr
import Graphics.X11.XScreenSaver
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Internal
import Graphics.X11.Xlib.Types
import Foreign (Storable, Ptr, peek, poke, pokeArray, peekElemOff, peekByteOff, pokeByteOff, peekArray, throwIfNull, nullPtr, sizeOf, alignment, alloca, with, throwIf, Word8, Word16, Word64, Int32, plusPtr, castPtr, withArrayLen, setBit, testBit, allocaBytes, FunPtr)
{-# LINE 27 "Graphics/X11/Xlib/Extras.hsc" #-}
import Foreign.C.Types
import Foreign.C.String
import Control.Monad

import System.IO.Unsafe



data Event
    = AnyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        }
    | ConfigureRequestEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_parent                :: !Window
        , ev_window                :: !Window
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_width                 :: !CInt
        , ev_height                :: !CInt
        , ev_border_width          :: !CInt
        , ev_above                 :: !Window
        , ev_detail                :: !NotifyDetail
        , ev_value_mask            :: !CULong
        }
    | ConfigureEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_event                 :: !Window
        , ev_window                :: !Window
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_width                 :: !CInt
        , ev_height                :: !CInt
        , ev_border_width          :: !CInt
        , ev_above                 :: !Window
        , ev_override_redirect     :: !Bool
        }
    | MapRequestEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_parent                :: !Window
        , ev_window                :: !Window
        }
    | KeyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_root                  :: !Window
        , ev_subwindow             :: !Window
        , ev_time                  :: !Time
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_x_root                :: !CInt
        , ev_y_root                :: !CInt
        , ev_state                 :: !KeyMask
        , ev_keycode               :: !KeyCode
        , ev_same_screen           :: !Bool
        }
    | ButtonEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_root                  :: !Window
        , ev_subwindow             :: !Window
        , ev_time                  :: !Time
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_x_root                :: !CInt
        , ev_y_root                :: !CInt
        , ev_state                 :: !KeyMask
        , ev_button                :: !Button
        , ev_same_screen           :: !Bool
        }
    | MotionEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_window                :: !Window
        }
    | DestroyWindowEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_event                 :: !Window
        , ev_window                :: !Window
        }
    | UnmapEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_event                 :: !Window
        , ev_window                :: !Window
        , ev_from_configure        :: !Bool
        }
    | MapNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_event                 :: !Window
        , ev_window                :: !Window
        , ev_override_redirect     :: !Bool
        }
    | MappingNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_request               :: !MappingRequest
        , ev_first_keycode         :: !KeyCode
        , ev_count                 :: !CInt
        }
    | CrossingEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_root                  :: !Window
        , ev_subwindow             :: !Window
        , ev_time                  :: !Time
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_x_root                :: !CInt
        , ev_y_root                :: !CInt
        , ev_mode                  :: !NotifyMode
        , ev_detail                :: !NotifyDetail
        , ev_same_screen           :: !Bool
        , ev_focus                 :: !Bool
        , ev_state                 :: !Modifier
        }
    | SelectionRequest
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_owner                 :: !Window
        , ev_requestor             :: !Window
        , ev_selection             :: !Atom
        , ev_target                :: !Atom
        , ev_property              :: !Atom
        , ev_time                  :: !Time
        }
    | SelectionClear
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_selection             :: !Atom
        , ev_time                  :: !Time
        }
    | PropertyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_atom                  :: !Atom
        , ev_time                  :: !Time
        , ev_propstate             :: !CInt
        }
    | ExposeEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_width                 :: !CInt
        , ev_height                :: !CInt
        , ev_count                 :: !CInt
        }
    | ClientMessageEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_message_type          :: !Atom
        , ev_data                  :: ![CInt]
        }
    | RRScreenChangeNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_root                  :: !Window
        , ev_timestamp             :: !Time
        , ev_config_timestamp      :: !Time
        , ev_size_index            :: !SizeID
        , ev_subpixel_order        :: !SubpixelOrder
        , ev_rotation              :: !Rotation
        , ev_width                 :: !CInt
        , ev_height                :: !CInt
        , ev_mwidth                :: !CInt
        , ev_mheight               :: !CInt
        }
    | RRNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_subtype               :: !CInt
        }
    | RRCrtcChangeNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_subtype               :: !CInt
        , ev_crtc                  :: !RRCrtc
        , ev_rr_mode               :: !RRMode
        , ev_rotation              :: !Rotation
        , ev_x                     :: !CInt
        , ev_y                     :: !CInt
        , ev_rr_width              :: !CUInt
        , ev_rr_height             :: !CUInt
        }
    | RROutputChangeNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_subtype               :: !CInt
        , ev_output                :: !RROutput
        , ev_crtc                  :: !RRCrtc
        , ev_rr_mode               :: !RRMode
        , ev_rotation              :: !Rotation
        , ev_connection            :: !Connection
        , ev_subpixel_order        :: !SubpixelOrder
        }
    | RROutputPropertyNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_subtype               :: !CInt
        , ev_output                :: !RROutput
        , ev_property              :: !Atom
        , ev_timestamp             :: !Time
        , ev_rr_state              :: !CInt
        }
    | ScreenSaverNotifyEvent
        { ev_event_type            :: !EventType
        , ev_serial                :: !CULong
        , ev_send_event            :: !Bool
        , ev_event_display         :: Display
        , ev_window                :: !Window
        , ev_root                  :: !Window
        , ev_ss_state              :: !XScreenSaverState
        , ev_ss_kind               :: !XScreenSaverKind
        , ev_forced                :: !Bool
        , ev_time                  :: !Time
        }
    deriving ( Show, Typeable )

eventTable :: [(EventType, String)]
eventTable =
    [ (keyPress             , "KeyPress")
    , (keyRelease           , "KeyRelease")
    , (buttonPress          , "ButtonPress")
    , (buttonRelease        , "ButtonRelease")
    , (motionNotify         , "MotionNotify")
    , (enterNotify          , "EnterNotify")
    , (leaveNotify          , "LeaveNotify")
    , (focusIn              , "FocusIn")
    , (focusOut             , "FocusOut")
    , (keymapNotify         , "KeymapNotify")
    , (expose               , "Expose")
    , (graphicsExpose       , "GraphicsExpose")
    , (noExpose             , "NoExpose")
    , (visibilityNotify     , "VisibilityNotify")
    , (createNotify         , "CreateNotify")
    , (destroyNotify        , "DestroyNotify")
    , (unmapNotify          , "UnmapNotify")
    , (mapNotify            , "MapNotify")
    , (mapRequest           , "MapRequest")
    , (reparentNotify       , "ReparentNotify")
    , (configureNotify      , "ConfigureNotify")
    , (configureRequest     , "ConfigureRequest")
    , (gravityNotify        , "GravityNotify")
    , (resizeRequest        , "ResizeRequest")
    , (circulateNotify      , "CirculateNotify")
    , (circulateRequest     , "CirculateRequest")
    , (propertyNotify       , "PropertyNotify")
    , (selectionClear       , "SelectionClear")
    , (selectionRequest     , "SelectionRequest")
    , (selectionNotify      , "SelectionNotify")
    , (colormapNotify       , "ColormapNotify")
    , (clientMessage        , "ClientMessage")
    , (mappingNotify        , "MappingNotify")
    , (lASTEvent            , "LASTEvent")
    , (screenSaverNotify    , "ScreenSaverNotify")
    ]

eventName :: Event -> String
eventName e = maybe ("unknown " ++ show x) id $ lookup x eventTable
 where x = fromIntegral $ ev_event_type e

getEvent :: XEventPtr -> IO Event
getEvent p = do
    -- All events share this layout and naming convention, there is also a
    -- common Window field, but the names for this field vary.
    type_      <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 360 "Graphics/X11/Xlib/Extras.hsc" #-}
    serial     <- (\hsc_ptr -> peekByteOff hsc_ptr 8) p
{-# LINE 361 "Graphics/X11/Xlib/Extras.hsc" #-}
    send_event <- (\hsc_ptr -> peekByteOff hsc_ptr 16) p
{-# LINE 362 "Graphics/X11/Xlib/Extras.hsc" #-}
    display    <- fmap Display ((\hsc_ptr -> peekByteOff hsc_ptr 24) p)
{-# LINE 363 "Graphics/X11/Xlib/Extras.hsc" #-}
    rrData     <- xrrQueryExtension display
    let rrHasExtension = isJust rrData
    let rrEventBase    = fromIntegral $ fst $ fromMaybe (0, 0) rrData
    case () of

        -------------------------
        -- ConfigureRequestEvent:
        -------------------------
        _ | type_ == configureRequest -> do
            parent       <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 373 "Graphics/X11/Xlib/Extras.hsc" #-}
            window       <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 374 "Graphics/X11/Xlib/Extras.hsc" #-}
            x            <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 375 "Graphics/X11/Xlib/Extras.hsc" #-}
            y            <- (\hsc_ptr -> peekByteOff hsc_ptr 52) p
{-# LINE 376 "Graphics/X11/Xlib/Extras.hsc" #-}
            width        <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 377 "Graphics/X11/Xlib/Extras.hsc" #-}
            height       <- (\hsc_ptr -> peekByteOff hsc_ptr 60) p
{-# LINE 378 "Graphics/X11/Xlib/Extras.hsc" #-}
            border_width <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 379 "Graphics/X11/Xlib/Extras.hsc" #-}
            above        <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 380 "Graphics/X11/Xlib/Extras.hsc" #-}
            detail       <- (\hsc_ptr -> peekByteOff hsc_ptr 80) p
{-# LINE 381 "Graphics/X11/Xlib/Extras.hsc" #-}
            value_mask   <- (\hsc_ptr -> peekByteOff hsc_ptr 88) p
{-# LINE 382 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ ConfigureRequestEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_parent        = parent
                        , ev_window        = window
                        , ev_x             = x
                        , ev_y             = y
                        , ev_width         = width
                        , ev_height        = height
                        , ev_border_width  = border_width
                        , ev_above         = above
                        , ev_detail        = detail
                        , ev_value_mask    = value_mask
                        }

          ------------------
          -- ConfigureEvent:
          ------------------
          | type_ == configureNotify -> do
            return (ConfigureEvent type_ serial send_event display)
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 405 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 406 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 407 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 52) p
{-# LINE 408 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 409 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 60) p
{-# LINE 410 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 411 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 412 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 80) p
{-# LINE 413 "Graphics/X11/Xlib/Extras.hsc" #-}

          -------------------
          -- MapRequestEvent:
          -------------------
          | type_ == mapRequest -> do
            parent <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 419 "Graphics/X11/Xlib/Extras.hsc" #-}
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 420 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ MapRequestEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_parent        = parent
                        , ev_window        = window
                        }

          -------------------
          -- MapNotifyEvent
          -------------------
          | type_ == mapNotify -> do
            event             <- (\hsc_ptr -> peekByteOff hsc_ptr 32)  p
{-# LINE 434 "Graphics/X11/Xlib/Extras.hsc" #-}
            window            <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 435 "Graphics/X11/Xlib/Extras.hsc" #-}
            override_redirect <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 436 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ MapNotifyEvent
                        { ev_event_type        = type_
                        , ev_serial            = serial
                        , ev_send_event        = send_event
                        , ev_event_display     = display
                        , ev_event             = event
                        , ev_window            = window
                        , ev_override_redirect = override_redirect
                        }

          -------------------
          -- MappingNotifyEvent
          -------------------
          | type_ == mappingNotify -> do
            window        <- (\hsc_ptr -> peekByteOff hsc_ptr 32)          p
{-# LINE 451 "Graphics/X11/Xlib/Extras.hsc" #-}
            request       <- (\hsc_ptr -> peekByteOff hsc_ptr 40)         p
{-# LINE 452 "Graphics/X11/Xlib/Extras.hsc" #-}
            first_keycode <- (\hsc_ptr -> peekByteOff hsc_ptr 44)   p
{-# LINE 453 "Graphics/X11/Xlib/Extras.hsc" #-}
            count         <- (\hsc_ptr -> peekByteOff hsc_ptr 48)           p
{-# LINE 454 "Graphics/X11/Xlib/Extras.hsc" #-}

            return $ MappingNotifyEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_request       = request
                        , ev_first_keycode = first_keycode
                        , ev_count         = count
                        }

          ------------
          -- KeyEvent:
          ------------
          | type_ == keyPress || type_ == keyRelease -> do
            window      <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 471 "Graphics/X11/Xlib/Extras.hsc" #-}
            root        <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 472 "Graphics/X11/Xlib/Extras.hsc" #-}
            subwindow   <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 473 "Graphics/X11/Xlib/Extras.hsc" #-}
            time        <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 474 "Graphics/X11/Xlib/Extras.hsc" #-}
            x           <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 475 "Graphics/X11/Xlib/Extras.hsc" #-}
            y           <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 476 "Graphics/X11/Xlib/Extras.hsc" #-}
            x_root      <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 477 "Graphics/X11/Xlib/Extras.hsc" #-}
            y_root      <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 478 "Graphics/X11/Xlib/Extras.hsc" #-}
            state       <- ((\hsc_ptr -> peekByteOff hsc_ptr 80) p) :: IO CUInt
{-# LINE 479 "Graphics/X11/Xlib/Extras.hsc" #-}
            keycode     <- ((\hsc_ptr -> peekByteOff hsc_ptr 84) p) :: IO CUInt
{-# LINE 480 "Graphics/X11/Xlib/Extras.hsc" #-}
            same_screen <- (\hsc_ptr -> peekByteOff hsc_ptr 88) p
{-# LINE 481 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ KeyEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_root          = root
                        , ev_subwindow     = subwindow
                        , ev_time          = time
                        , ev_x             = x
                        , ev_y             = y
                        , ev_x_root        = x_root
                        , ev_y_root        = y_root
                        , ev_state         = fromIntegral state
                        , ev_keycode       = fromIntegral keycode
                        , ev_same_screen   = same_screen
                        }

          ---------------
          -- ButtonEvent:
          ---------------
          | type_ == buttonPress || type_ == buttonRelease -> do

            window      <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 505 "Graphics/X11/Xlib/Extras.hsc" #-}
            root        <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 506 "Graphics/X11/Xlib/Extras.hsc" #-}
            subwindow   <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 507 "Graphics/X11/Xlib/Extras.hsc" #-}
            time        <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 508 "Graphics/X11/Xlib/Extras.hsc" #-}
            x           <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 509 "Graphics/X11/Xlib/Extras.hsc" #-}
            y           <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 510 "Graphics/X11/Xlib/Extras.hsc" #-}
            x_root      <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 511 "Graphics/X11/Xlib/Extras.hsc" #-}
            y_root      <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 512 "Graphics/X11/Xlib/Extras.hsc" #-}
            state       <- ((\hsc_ptr -> peekByteOff hsc_ptr 80) p) :: IO CUInt
{-# LINE 513 "Graphics/X11/Xlib/Extras.hsc" #-}
            button      <- (\hsc_ptr -> peekByteOff hsc_ptr 84) p
{-# LINE 514 "Graphics/X11/Xlib/Extras.hsc" #-}
            same_screen <- (\hsc_ptr -> peekByteOff hsc_ptr 88) p
{-# LINE 515 "Graphics/X11/Xlib/Extras.hsc" #-}

            return $ ButtonEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_root          = root
                        , ev_subwindow     = subwindow
                        , ev_time          = time
                        , ev_x             = x
                        , ev_y             = y
                        , ev_x_root        = x_root
                        , ev_y_root        = y_root
                        , ev_state         = fromIntegral state
                        , ev_button        = button
                        , ev_same_screen   = same_screen
                        }

          ---------------
          -- MotionEvent:
          ---------------
          | type_ == motionNotify -> do
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 539 "Graphics/X11/Xlib/Extras.hsc" #-}
            x      <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 540 "Graphics/X11/Xlib/Extras.hsc" #-}
            y      <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 541 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ MotionEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_x             = x
                        , ev_y             = y
                        , ev_window        = window
                        }


          ----------------------
          -- DestroyWindowEvent:
          ----------------------
          | type_ == destroyNotify -> do
            event  <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 557 "Graphics/X11/Xlib/Extras.hsc" #-}
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 558 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ DestroyWindowEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_event         = event
                        , ev_window        = window
                        }


          --------------------
          -- UnmapNotifyEvent:
          --------------------
          | type_ == unmapNotify -> do
            event          <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 573 "Graphics/X11/Xlib/Extras.hsc" #-}
            window         <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 574 "Graphics/X11/Xlib/Extras.hsc" #-}
            from_configure <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 575 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ UnmapEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_event         = event
                        , ev_window        = window
                        , ev_from_configure = from_configure
                        }

          --------------------
          -- CrossingEvent
          --------------------
          | type_ == enterNotify || type_ == leaveNotify -> do
            window        <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 590 "Graphics/X11/Xlib/Extras.hsc" #-}
            root          <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 591 "Graphics/X11/Xlib/Extras.hsc" #-}
            subwindow     <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 592 "Graphics/X11/Xlib/Extras.hsc" #-}
            time          <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 593 "Graphics/X11/Xlib/Extras.hsc" #-}
            x             <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 594 "Graphics/X11/Xlib/Extras.hsc" #-}
            y             <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 595 "Graphics/X11/Xlib/Extras.hsc" #-}
            x_root        <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 596 "Graphics/X11/Xlib/Extras.hsc" #-}
            y_root        <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 597 "Graphics/X11/Xlib/Extras.hsc" #-}
            mode          <- (\hsc_ptr -> peekByteOff hsc_ptr 80) p
{-# LINE 598 "Graphics/X11/Xlib/Extras.hsc" #-}
            detail        <- (\hsc_ptr -> peekByteOff hsc_ptr 84) p
{-# LINE 599 "Graphics/X11/Xlib/Extras.hsc" #-}
            same_screen   <- (\hsc_ptr -> peekByteOff hsc_ptr 88) p
{-# LINE 600 "Graphics/X11/Xlib/Extras.hsc" #-}
            focus         <- (\hsc_ptr -> peekByteOff hsc_ptr 92) p
{-# LINE 601 "Graphics/X11/Xlib/Extras.hsc" #-}
            state         <- ((\hsc_ptr -> peekByteOff hsc_ptr 96) p) :: IO CUInt
{-# LINE 602 "Graphics/X11/Xlib/Extras.hsc" #-}

            return $ CrossingEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_root          = root
                        , ev_subwindow     = subwindow
                        , ev_time          = time
                        , ev_x             = x
                        , ev_y             = y
                        , ev_x_root        = x_root
                        , ev_y_root        = y_root
                        , ev_mode          = mode
                        , ev_detail        = detail
                        , ev_same_screen   = same_screen
                        , ev_focus         = focus
                        , ev_state         = fromIntegral state
                        }

          -------------------------
          -- SelectionRequestEvent:
          -------------------------
          | type_ == selectionRequest -> do
            owner          <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 628 "Graphics/X11/Xlib/Extras.hsc" #-}
            requestor      <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 629 "Graphics/X11/Xlib/Extras.hsc" #-}
            selection      <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 630 "Graphics/X11/Xlib/Extras.hsc" #-}
            target         <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 631 "Graphics/X11/Xlib/Extras.hsc" #-}
            property       <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 632 "Graphics/X11/Xlib/Extras.hsc" #-}
            time           <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 633 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ SelectionRequest
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_owner         = owner
                        , ev_requestor     = requestor
                        , ev_selection     = selection
                        , ev_target        = target
                        , ev_property      = property
                        , ev_time          = time
                        }

          -------------------------
          -- SelectionClearEvent:
          -------------------------
          | type_ == selectionClear -> do
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 651 "Graphics/X11/Xlib/Extras.hsc" #-}
            atom   <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 652 "Graphics/X11/Xlib/Extras.hsc" #-}
            time   <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 653 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ SelectionClear
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_selection     = atom
                        , ev_time          = time
                        }
          -------------------------
          -- PropertyEvent
          -------------------------
          | type_ == propertyNotify -> do
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 667 "Graphics/X11/Xlib/Extras.hsc" #-}
            atom   <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 668 "Graphics/X11/Xlib/Extras.hsc" #-}
            time   <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 669 "Graphics/X11/Xlib/Extras.hsc" #-}
            state  <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 670 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ PropertyEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_atom          = atom
                        , ev_time          = time
                        , ev_propstate     = state
                        }

          -------------------------
          -- ExposeEvent
          -------------------------
          | type_ == expose -> do
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 686 "Graphics/X11/Xlib/Extras.hsc" #-}
            x      <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 687 "Graphics/X11/Xlib/Extras.hsc" #-}
            y      <- (\hsc_ptr -> peekByteOff hsc_ptr 44) p
{-# LINE 688 "Graphics/X11/Xlib/Extras.hsc" #-}
            width  <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 689 "Graphics/X11/Xlib/Extras.hsc" #-}
            height <- (\hsc_ptr -> peekByteOff hsc_ptr 52) p
{-# LINE 690 "Graphics/X11/Xlib/Extras.hsc" #-}
            count  <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 691 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ ExposeEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_x             = x
                        , ev_y             = y
                        , ev_width         = width
                        , ev_height        = height
                        , ev_count         = count
                        }

          -------------------------
          -- ClientMessageEvent
          -------------------------
          | type_ == clientMessage -> do
            window       <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 709 "Graphics/X11/Xlib/Extras.hsc" #-}
            message_type <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 710 "Graphics/X11/Xlib/Extras.hsc" #-}
            format       <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 711 "Graphics/X11/Xlib/Extras.hsc" #-}
            let datPtr =    (\hsc_ptr -> hsc_ptr `plusPtr` 56) p
{-# LINE 712 "Graphics/X11/Xlib/Extras.hsc" #-}
            dat          <- case (format::CInt) of
                        8  -> do a <- peekArray 20 datPtr
                                 return $ map fromIntegral (a::[Word8])
                        16 -> do a <- peekArray 10 datPtr
                                 return $ map fromIntegral (a::[Word16])
                        32 -> do a <- peekArray 5 datPtr
                                 return $ map fromIntegral (a::[CLong])
                        _  -> error "X11.Extras.clientMessage: illegal value"
            return $ ClientMessageEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        , ev_message_type  = message_type
                        , ev_data          = dat
                        }

          -------------------------
          -- RRScreenChangeNotify
          -------------------------
          | rrHasExtension &&
            type_ == rrEventBase + rrScreenChangeNotify -> do
            window           <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 736 "Graphics/X11/Xlib/Extras.hsc" #-}
            root             <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 737 "Graphics/X11/Xlib/Extras.hsc" #-}
            timestamp        <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 738 "Graphics/X11/Xlib/Extras.hsc" #-}
            config_timestamp <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 739 "Graphics/X11/Xlib/Extras.hsc" #-}
            size_index       <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 740 "Graphics/X11/Xlib/Extras.hsc" #-}
            subpixel_order   <- (\hsc_ptr -> peekByteOff hsc_ptr 66) p
{-# LINE 741 "Graphics/X11/Xlib/Extras.hsc" #-}
            rotation         <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 742 "Graphics/X11/Xlib/Extras.hsc" #-}
            width            <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 743 "Graphics/X11/Xlib/Extras.hsc" #-}
            height           <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 744 "Graphics/X11/Xlib/Extras.hsc" #-}
            mwidth           <- (\hsc_ptr -> peekByteOff hsc_ptr 80) p
{-# LINE 745 "Graphics/X11/Xlib/Extras.hsc" #-}
            mheight          <- (\hsc_ptr -> peekByteOff hsc_ptr 84) p
{-# LINE 746 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ RRScreenChangeNotifyEvent
                        { ev_event_type       = type_
                        , ev_serial           = serial
                        , ev_send_event       = send_event
                        , ev_event_display    = display
                        , ev_window           = window
                        , ev_root             = root
                        , ev_timestamp        = timestamp
                        , ev_config_timestamp = config_timestamp
                        , ev_size_index       = size_index
                        , ev_subpixel_order   = subpixel_order
                        , ev_rotation         = rotation
                        , ev_width            = width
                        , ev_height           = height
                        , ev_mwidth           = mwidth
                        , ev_mheight          = mheight
                        }

          -------------------------
          -- RRNotify
          -------------------------
          | rrHasExtension &&
            type_ == rrEventBase + rrNotify -> do
            window   <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 770 "Graphics/X11/Xlib/Extras.hsc" #-}
            subtype  <- (\hsc_ptr -> peekByteOff hsc_ptr 40) p
{-# LINE 771 "Graphics/X11/Xlib/Extras.hsc" #-}
            let subtype_ = fromIntegral subtype
            case () of
                _ | subtype_ == rrNotifyCrtcChange -> do
                    crtc           <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 775 "Graphics/X11/Xlib/Extras.hsc" #-}
                    mode           <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 776 "Graphics/X11/Xlib/Extras.hsc" #-}
                    rotation       <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 777 "Graphics/X11/Xlib/Extras.hsc" #-}
                    x              <- (\hsc_ptr -> peekByteOff hsc_ptr 68) p
{-# LINE 778 "Graphics/X11/Xlib/Extras.hsc" #-}
                    y              <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 779 "Graphics/X11/Xlib/Extras.hsc" #-}
                    width          <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 780 "Graphics/X11/Xlib/Extras.hsc" #-}
                    height         <- (\hsc_ptr -> peekByteOff hsc_ptr 80) p
{-# LINE 781 "Graphics/X11/Xlib/Extras.hsc" #-}
                    return $ RRCrtcChangeNotifyEvent
                             { ev_event_type    = type_
                             , ev_serial        = serial
                             , ev_send_event    = send_event
                             , ev_event_display = display
                             , ev_window        = window
                             , ev_subtype       = subtype
                             , ev_crtc          = crtc
                             , ev_rr_mode       = mode
                             , ev_rotation      = rotation
                             , ev_x             = x
                             , ev_y             = y
                             , ev_rr_width      = width
                             , ev_rr_height     = height
                             }

                  | subtype_ == rrNotifyOutputChange -> do
                    output         <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 799 "Graphics/X11/Xlib/Extras.hsc" #-}
                    crtc           <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 800 "Graphics/X11/Xlib/Extras.hsc" #-}
                    mode           <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 801 "Graphics/X11/Xlib/Extras.hsc" #-}
                    rotation       <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 802 "Graphics/X11/Xlib/Extras.hsc" #-}
                    connection     <- (\hsc_ptr -> peekByteOff hsc_ptr 74) p
{-# LINE 803 "Graphics/X11/Xlib/Extras.hsc" #-}
                    subpixel_order <- (\hsc_ptr -> peekByteOff hsc_ptr 76) p
{-# LINE 804 "Graphics/X11/Xlib/Extras.hsc" #-}
                    return $ RROutputChangeNotifyEvent
                             { ev_event_type     = type_
                             , ev_serial         = serial
                             , ev_send_event     = send_event
                             , ev_event_display  = display
                             , ev_window         = window
                             , ev_subtype        = subtype
                             , ev_output         = output
                             , ev_crtc           = crtc
                             , ev_rr_mode        = mode
                             , ev_rotation       = rotation
                             , ev_connection     = connection
                             , ev_subpixel_order = subpixel_order
                             }

                  | subtype_ == rrNotifyOutputProperty -> do
                    output         <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 821 "Graphics/X11/Xlib/Extras.hsc" #-}
                    property       <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 822 "Graphics/X11/Xlib/Extras.hsc" #-}
                    timestamp      <- (\hsc_ptr -> peekByteOff hsc_ptr 64) p
{-# LINE 823 "Graphics/X11/Xlib/Extras.hsc" #-}
                    state          <- (\hsc_ptr -> peekByteOff hsc_ptr 72) p
{-# LINE 824 "Graphics/X11/Xlib/Extras.hsc" #-}
                    return $ RROutputPropertyNotifyEvent
                             { ev_event_type    = type_
                             , ev_serial        = serial
                             , ev_send_event    = send_event
                             , ev_event_display = display
                             , ev_window        = window
                             , ev_subtype       = subtype
                             , ev_output        = output
                             , ev_property      = property
                             , ev_timestamp     = timestamp
                             , ev_rr_state      = state
                             }

                  -- We don't handle this event specifically, so return the generic
                  -- RRNotifyEvent.
                  | otherwise -> do
                    return $ RRNotifyEvent
                                { ev_event_type    = type_
                                , ev_serial        = serial
                                , ev_send_event    = send_event
                                , ev_event_display = display
                                , ev_window        = window
                                , ev_subtype       = subtype
                                }

          -----------------
          -- ScreenSaverNotifyEvent:
          -----------------
          | type_ == screenSaverNotify -> do
            return (ScreenSaverNotifyEvent type_ serial send_event display)
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 32) p )
{-# LINE 855 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 40) p )
{-# LINE 856 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 48) p )
{-# LINE 857 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 52) p )
{-# LINE 858 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 56) p )
{-# LINE 859 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 64) p )
{-# LINE 860 "Graphics/X11/Xlib/Extras.hsc" #-}

          -- We don't handle this event specifically, so return the generic
          -- AnyEvent.
          | otherwise -> do
            window <- (\hsc_ptr -> peekByteOff hsc_ptr 32) p
{-# LINE 865 "Graphics/X11/Xlib/Extras.hsc" #-}
            return $ AnyEvent
                        { ev_event_type    = type_
                        , ev_serial        = serial
                        , ev_send_event    = send_event
                        , ev_event_display = display
                        , ev_window        = window
                        }

data WindowChanges = WindowChanges
                        { wc_x :: CInt
                        , wc_y :: CInt
                        , wc_width :: CInt
                        , wc_height:: CInt
                        , wc_border_width :: CInt
                        , wc_sibling :: Window
                        , wc_stack_mode :: CInt
                        }

instance Storable WindowChanges where
    sizeOf _ = (40)
{-# LINE 885 "Graphics/X11/Xlib/Extras.hsc" #-}

    -- I really hope this is right:
    alignment _ = alignment (undefined :: CInt)

    poke p wc = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ wc_x wc
{-# LINE 891 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 4) p $ wc_y wc
{-# LINE 892 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ wc_width wc
{-# LINE 893 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ wc_height wc
{-# LINE 894 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ wc_border_width wc
{-# LINE 895 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ wc_sibling wc
{-# LINE 896 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ wc_stack_mode wc
{-# LINE 897 "Graphics/X11/Xlib/Extras.hsc" #-}

    peek p = return WindowChanges
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 0) p)
{-# LINE 900 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 4) p)
{-# LINE 901 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 8) p)
{-# LINE 902 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 12) p)
{-# LINE 903 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 904 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 24) p)
{-# LINE 905 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 32) p)
{-# LINE 906 "Graphics/X11/Xlib/Extras.hsc" #-}

--
-- Some extra constants
--

none :: XID
none = 0
{-# LINE 913 "Graphics/X11/Xlib/Extras.hsc" #-}

anyButton :: Button
anyButton = 0
{-# LINE 916 "Graphics/X11/Xlib/Extras.hsc" #-}

anyKey :: KeyCode
anyKey = toEnum 0
{-# LINE 919 "Graphics/X11/Xlib/Extras.hsc" #-}

currentTime :: Time
currentTime = 0
{-# LINE 922 "Graphics/X11/Xlib/Extras.hsc" #-}

--
-- The use of Int rather than CInt isn't 64 bit clean.
--

foreign import ccall unsafe "XlibExtras.h XConfigureWindow"
    xConfigureWindow :: Display -> Window -> CULong -> Ptr WindowChanges -> IO CInt

foreign import ccall unsafe "XlibExtras.h XKillClient"
    killClient :: Display -> Window -> IO CInt

configureWindow :: Display -> Window -> CULong -> WindowChanges -> IO ()
configureWindow d w m c = do
    _ <- with c (xConfigureWindow d w m)
    return ()

foreign import ccall unsafe "XlibExtras.h XQueryTree"
    xQueryTree :: Display -> Window -> Ptr Window -> Ptr Window -> Ptr (Ptr Window) -> Ptr CInt -> IO Status

queryTree :: Display -> Window -> IO (Window, Window, [Window])
queryTree d w =
    alloca $ \root_return ->
    alloca $ \parent_return ->
    alloca $ \children_return ->
    alloca $ \nchildren_return -> do
        _ <- throwIfZero "queryTree" $ xQueryTree d w root_return parent_return children_return nchildren_return
        p <- peek children_return
        n <- fmap fromIntegral $ peek nchildren_return
        ws <- peekArray n p
        _ <- xFree p
        liftM3 (,,) (peek root_return) (peek parent_return) (return ws)

-- TODO: this data type is incomplete wrt. the C struct
data WindowAttributes = WindowAttributes
            { wa_x, wa_y, wa_width, wa_height, wa_border_width :: CInt
            , wa_colormap :: Colormap
            , wa_map_installed :: Bool
            , wa_map_state :: CInt
            , wa_all_event_masks :: EventMask
            , wa_your_event_mask :: EventMask
            , wa_do_not_propagate_mask :: EventMask
            , wa_override_redirect :: Bool
            }

--
-- possible map_states'
--
waIsUnmapped, waIsUnviewable, waIsViewable :: CInt
waIsUnmapped   = fromIntegral ( 0   :: CInt )  -- 0
{-# LINE 971 "Graphics/X11/Xlib/Extras.hsc" #-}
waIsUnviewable = fromIntegral ( 1 :: CInt )  -- 1
{-# LINE 972 "Graphics/X11/Xlib/Extras.hsc" #-}
waIsViewable   = fromIntegral ( 2   :: CInt )  -- 2
{-# LINE 973 "Graphics/X11/Xlib/Extras.hsc" #-}

instance Storable WindowAttributes where
    -- this might be incorrect
    alignment _ = alignment (undefined :: CInt)
    sizeOf _ = (136)
{-# LINE 978 "Graphics/X11/Xlib/Extras.hsc" #-}
    peek p = return WindowAttributes
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 0) p)
{-# LINE 980 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 4) p)
{-# LINE 981 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 8) p)
{-# LINE 982 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 12) p)
{-# LINE 983 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 984 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 80) p)
{-# LINE 985 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 88) p)
{-# LINE 986 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 92) p)
{-# LINE 987 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 96) p)
{-# LINE 988 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 104) p)
{-# LINE 989 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 112) p)
{-# LINE 990 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 120) p)
{-# LINE 991 "Graphics/X11/Xlib/Extras.hsc" #-}
    poke p wa = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ wa_x wa
{-# LINE 993 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 4) p $ wa_y wa
{-# LINE 994 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ wa_width wa
{-# LINE 995 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ wa_height wa
{-# LINE 996 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ wa_border_width wa
{-# LINE 997 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 80) p $ wa_colormap wa
{-# LINE 998 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 88) p $ wa_map_installed wa
{-# LINE 999 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 92) p $ wa_map_state wa
{-# LINE 1000 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 96) p $ wa_all_event_masks wa
{-# LINE 1001 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 104) p $ wa_your_event_mask wa
{-# LINE 1002 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 112) p $ wa_do_not_propagate_mask wa
{-# LINE 1003 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 120) p $ wa_override_redirect wa
{-# LINE 1004 "Graphics/X11/Xlib/Extras.hsc" #-}

foreign import ccall unsafe "XlibExtras.h XGetWindowAttributes"
    xGetWindowAttributes :: Display -> Window -> Ptr (WindowAttributes) -> IO Status

getWindowAttributes :: Display -> Window -> IO WindowAttributes
getWindowAttributes d w = alloca $ \p -> do
    _ <- throwIfZero "getWindowAttributes" $ xGetWindowAttributes d w p
    peek p

-- | interface to the X11 library function @XChangeWindowAttributes()@.
foreign import ccall unsafe "XlibExtras.h XChangeWindowAttributes"
        changeWindowAttributes :: Display -> Window -> AttributeMask -> Ptr SetWindowAttributes -> IO ()

-- | Run an action with the server
withServer :: Display -> IO () -> IO ()
withServer dpy f = do
    grabServer dpy
    f
    ungrabServer dpy

data TextProperty = TextProperty {
        tp_value    :: CString,
        tp_encoding :: Atom,
        tp_format   :: CInt,
        tp_nitems   :: Word64
{-# LINE 1029 "Graphics/X11/Xlib/Extras.hsc" #-}
    }

instance Storable TextProperty where
    sizeOf    _ = (32)
{-# LINE 1033 "Graphics/X11/Xlib/Extras.hsc" #-}
    alignment _ = alignment (undefined :: Word64)
{-# LINE 1034 "Graphics/X11/Xlib/Extras.hsc" #-}
    peek p = TextProperty `fmap` (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 1035 "Graphics/X11/Xlib/Extras.hsc" #-}
                          `ap`   (\hsc_ptr -> peekByteOff hsc_ptr 8) p
{-# LINE 1036 "Graphics/X11/Xlib/Extras.hsc" #-}
                          `ap`   (\hsc_ptr -> peekByteOff hsc_ptr 16) p
{-# LINE 1037 "Graphics/X11/Xlib/Extras.hsc" #-}
                          `ap`   (\hsc_ptr -> peekByteOff hsc_ptr 24) p
{-# LINE 1038 "Graphics/X11/Xlib/Extras.hsc" #-}
    poke p (TextProperty val enc fmt nitems) = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p val
{-# LINE 1040 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p enc
{-# LINE 1041 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p fmt
{-# LINE 1042 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p nitems
{-# LINE 1043 "Graphics/X11/Xlib/Extras.hsc" #-}

foreign import ccall unsafe "XlibExtras.h XGetTextProperty"
    xGetTextProperty :: Display -> Window -> Ptr TextProperty -> Atom -> IO Status

getTextProperty :: Display -> Window -> Atom -> IO TextProperty
getTextProperty d w a =
    alloca $ \textp -> do
        _ <- throwIf (0==) (const "getTextProperty") $ xGetTextProperty d w textp a
        peek textp

foreign import ccall unsafe "XlibExtras.h XwcTextPropertyToTextList"
    xwcTextPropertyToTextList :: Display -> Ptr TextProperty -> Ptr (Ptr CWString) -> Ptr CInt -> IO CInt

wcTextPropertyToTextList :: Display -> TextProperty -> IO [String]
wcTextPropertyToTextList d prop =
    alloca    $ \listp  ->
    alloca    $ \countp ->
    with prop $ \propp  -> do
        _ <- throwIf (success>) (const "wcTextPropertyToTextList") $
            xwcTextPropertyToTextList d propp listp countp
        count <- peek countp
        list  <- peek listp
        texts <- flip mapM [0..fromIntegral count - 1] $ \i ->
                     peekElemOff list i >>= peekCWString
        wcFreeStringList list
        return texts

foreign import ccall unsafe "XlibExtras.h XwcFreeStringList"
    wcFreeStringList :: Ptr CWString -> IO ()

newtype FontSet = FontSet (Ptr FontSet)
    deriving (Eq, Ord, Show)

foreign import ccall unsafe "XlibExtras.h XCreateFontSet"
    xCreateFontSet :: Display -> CString -> Ptr (Ptr CString) -> Ptr CInt -> Ptr CString -> IO (Ptr FontSet)

createFontSet :: Display -> String -> IO ([String], String, FontSet)
createFontSet d fn =
    withCString fn $ \fontp  ->
    alloca         $ \listp  ->
    alloca         $ \countp ->
    alloca         $ \defp   -> do
        fs      <- throwIfNull "createFontSet" $
                       xCreateFontSet d fontp listp countp defp
        count   <- peek countp
        list    <- peek listp
        missing <- flip mapM [0..fromIntegral count - 1] $ \i ->
                       peekElemOff list i >>= peekCString
        def     <- peek defp >>= peekCString
        freeStringList list
        return (missing, def, FontSet fs)

foreign import ccall unsafe "XlibExtras.h XFreeStringList"
    freeStringList :: Ptr CString -> IO ()

foreign import ccall unsafe "XlibExtras.h XFreeFontSet"
    freeFontSet :: Display -> FontSet -> IO ()

foreign import ccall unsafe "XlibExtras.h XwcTextExtents"
    xwcTextExtents :: FontSet -> CWString -> CInt -> Ptr Rectangle -> Ptr Rectangle -> IO CInt

wcTextExtents :: FontSet -> String -> (Rectangle, Rectangle)
wcTextExtents fs text = unsafePerformIO $
    withCWStringLen text $ \(textp, len) ->
    alloca               $ \inkp          ->
    alloca               $ \logicalp      -> do
        _ <- xwcTextExtents fs textp (fromIntegral len) inkp logicalp
        (,) `fmap` peek inkp `ap` peek logicalp

foreign import ccall unsafe "XlibExtras.h XwcDrawString"
    xwcDrawString :: Display -> Drawable -> FontSet -> GC -> Position -> Position -> CWString -> CInt -> IO ()

wcDrawString :: Display -> Drawable -> FontSet -> GC -> Position -> Position -> String -> IO ()
wcDrawString d w fs gc x y =
    flip withCWStringLen $ \(s, len) ->
        xwcDrawString d w fs gc x y s (fromIntegral len)

foreign import ccall unsafe "XlibExtras.h XwcDrawImageString"
    xwcDrawImageString :: Display -> Drawable -> FontSet -> GC -> Position -> Position -> CWString -> CInt -> IO ()

wcDrawImageString :: Display -> Drawable -> FontSet -> GC -> Position -> Position -> String -> IO ()
wcDrawImageString d w fs gc x y =
    flip withCWStringLen $ \(s, len) ->
        xwcDrawImageString d w fs gc x y s (fromIntegral len)

foreign import ccall unsafe "XlibExtras.h XwcTextEscapement"
    xwcTextEscapement :: FontSet -> CWString -> CInt -> IO Int32

wcTextEscapement :: FontSet -> String -> Int32
wcTextEscapement font_set string = unsafePerformIO $
    withCWStringLen string $ \ (c_string, len) ->
    xwcTextEscapement font_set c_string (fromIntegral len)

foreign import ccall unsafe "XlibExtras.h XFetchName"
    xFetchName :: Display -> Window -> Ptr CString -> IO Status

fetchName :: Display -> Window -> IO (Maybe String)
fetchName d w = alloca $ \p -> do
    _ <- xFetchName d w p
    cstr <- peek p
    if cstr == nullPtr
        then return Nothing
        else do
            str <- peekCString cstr
            _ <- xFree cstr
            return $ Just str

foreign import ccall unsafe "XlibExtras.h XGetTransientForHint"
    xGetTransientForHint :: Display -> Window -> Ptr Window -> IO Status

getTransientForHint :: Display -> Window -> IO (Maybe Window)
getTransientForHint d w = alloca $ \wp -> do
    status <- xGetTransientForHint d w wp
    if status == 0
        then return Nothing
        else Just `liftM` peek wp

------------------------------------------------------------------------
-- setWMProtocols :: Display -> Window -> [Atom] -> IO ()

{-
setWMProtocols :: Display -> Window -> [Atom] -> IO ()
setWMProtocols display w protocols =
    withArray protocols $ \ protocol_array ->
    xSetWMProtocols display w protocol_array (length protocols)
foreign import ccall unsafe "HsXlib.h XSetWMProtocols"
    xSetWMProtocols :: Display -> Window -> Ptr Atom -> CInt -> IO ()
-}

-- | The XGetWMProtocols function returns the list of atoms
-- stored in the WM_PROTOCOLS property on the specified window.
-- These atoms describe window manager protocols in
-- which the owner of this window is willing to participate.
-- If the property exists, is of type ATOM, is of format 32,
-- and the atom WM_PROTOCOLS can be interned, XGetWMProtocols
-- sets the protocols_return argument to a list of atoms,
-- sets the count_return argument to the number of elements
-- in the list, and returns a nonzero status.  Otherwise, it
-- sets neither of the return arguments and returns a zero
-- status.  To release the list of atoms, use XFree.
--
getWMProtocols :: Display -> Window -> IO [Atom]
getWMProtocols display w = do
    alloca $ \atom_ptr_ptr ->
      alloca $ \count_ptr -> do

       st <- xGetWMProtocols display w atom_ptr_ptr count_ptr
       if st == 0
            then return []
            else do sz       <- peek count_ptr
                    atom_ptr <- peek atom_ptr_ptr
                    atoms    <- peekArray (fromIntegral sz) atom_ptr
                    _ <- xFree atom_ptr
                    return atoms

foreign import ccall unsafe "HsXlib.h XGetWMProtocols"
    xGetWMProtocols :: Display -> Window -> Ptr (Ptr Atom) -> Ptr CInt -> IO Status


------------------------------------------------------------------------
-- Creating events

setEventType :: XEventPtr -> EventType -> IO ()
setEventType = (\hsc_ptr -> pokeByteOff hsc_ptr 0)
{-# LINE 1207 "Graphics/X11/Xlib/Extras.hsc" #-}

{-
typedef struct {
        int type;               /* SelectionNotify */
        unsigned long serial;   /* # of last request processed by server */
        Bool send_event;        /* true if this came from a SendEvent request */
        Display *display;       /* Display the event was read from */
        Window requestor;
        Atom selection;
        Atom target;
        Atom property;          /* atom or None */
        Time time;
} XSelectionEvent;
-}

setSelectionNotify :: XEventPtr -> Window -> Atom -> Atom -> Atom -> Time -> IO ()
setSelectionNotify p requestor selection target property time = do
    setEventType p selectionNotify
    (\hsc_ptr -> pokeByteOff hsc_ptr 32)    p requestor
{-# LINE 1226 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 40)    p selection
{-# LINE 1227 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 48)       p target
{-# LINE 1228 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 56)     p property
{-# LINE 1229 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 64)         p time
{-# LINE 1230 "Graphics/X11/Xlib/Extras.hsc" #-}

-- hacky way to set up an XClientMessageEvent
-- Should have a Storable instance for XEvent/Event?
setClientMessageEvent :: XEventPtr -> Window -> Atom -> CInt -> Atom -> Time -> IO ()
setClientMessageEvent p window message_type format l_0_ l_1_ = do
    setClientMessageEvent' p window message_type format [fromIntegral l_0_, fromIntegral l_1_]

-- slightly less hacky way to set up an XClientMessageEvent
setClientMessageEvent' :: XEventPtr -> Window -> Atom -> CInt -> [CInt] -> IO ()
setClientMessageEvent' p window message_type format dat = do
    (\hsc_ptr -> pokeByteOff hsc_ptr 32)         p window
{-# LINE 1241 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 40)   p message_type
{-# LINE 1242 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 48)         p format
{-# LINE 1243 "Graphics/X11/Xlib/Extras.hsc" #-}
    case format of
        8  -> do let datap = (\hsc_ptr -> hsc_ptr `plusPtr` 56) p :: Ptr Word8
{-# LINE 1245 "Graphics/X11/Xlib/Extras.hsc" #-}
                 pokeArray datap $ take 20 $ map fromIntegral dat ++ repeat 0
        16 -> do let datap = (\hsc_ptr -> hsc_ptr `plusPtr` 56) p :: Ptr Word16
{-# LINE 1247 "Graphics/X11/Xlib/Extras.hsc" #-}
                 pokeArray datap $ take 10 $ map fromIntegral dat ++ repeat 0
        32 -> do let datap = (\hsc_ptr -> hsc_ptr `plusPtr` 56) p :: Ptr CLong
{-# LINE 1249 "Graphics/X11/Xlib/Extras.hsc" #-}
                 pokeArray datap $ take 5  $ map fromIntegral dat ++ repeat 0
        _  -> error "X11.Extras.setClientMessageEvent': illegal format"

setConfigureEvent :: XEventPtr -> Window -> Window -> CInt -> CInt -> CInt -> CInt -> CInt -> Window -> Bool -> IO ()
setConfigureEvent p ev win x y w h bw abv org = do
    (\hsc_ptr -> pokeByteOff hsc_ptr 32) p ev
{-# LINE 1255 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 40) p win
{-# LINE 1256 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 48) p x
{-# LINE 1257 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 52) p y
{-# LINE 1258 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 56) p w
{-# LINE 1259 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 60) p h
{-# LINE 1260 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 64) p bw
{-# LINE 1261 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 72) p abv
{-# LINE 1262 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 80) p (if org then 1 else 0 :: CInt)
{-# LINE 1263 "Graphics/X11/Xlib/Extras.hsc" #-}

setKeyEvent :: XEventPtr -> Window -> Window -> Window -> KeyMask -> KeyCode -> Bool -> IO ()
setKeyEvent p win root subwin state keycode sameScreen = do
    (\hsc_ptr -> pokeByteOff hsc_ptr 32) p win
{-# LINE 1267 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 40) p root
{-# LINE 1268 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 48) p subwin
{-# LINE 1269 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 56) p currentTime
{-# LINE 1270 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 64) p (1 :: CInt)
{-# LINE 1271 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 68) p (1 :: CInt)
{-# LINE 1272 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 72) p (1 :: CInt)
{-# LINE 1273 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 76) p (1 :: CInt)
{-# LINE 1274 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 80) p state
{-# LINE 1275 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 84) p keycode
{-# LINE 1276 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 88) p sameScreen
{-# LINE 1277 "Graphics/X11/Xlib/Extras.hsc" #-}
    return ()

{-
       typedef struct {
            int type;                /* ClientMessage */
            unsigned long serial;    /* # of last request processed by server */
            Bool send_event;         /* true if this came from a SendEvent request */
            Display *display;        /* Display the event was read from */
            Window window;
            Atom message_type;
            int format;
            union {
                 char b[20];
                 short s[10];
                 long l[5];
                    } data;
       } XClientMessageEvent;

-}

------------------------------------------------------------------------
-- XErrorEvents
--
-- I'm too lazy to write the binding
--

foreign import ccall unsafe "XlibExtras.h x11_extras_set_error_handler"
    xSetErrorHandler   :: IO ()

-- | refreshKeyboardMapping.  TODO Remove this binding when the fix has been commited to
-- X11
refreshKeyboardMapping :: Event -> IO ()
refreshKeyboardMapping ev@(MappingNotifyEvent {ev_event_display = (Display d)})
 = allocaBytes (56) $ \p -> do
{-# LINE 1311 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ ev_event_type    ev
{-# LINE 1312 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ ev_serial        ev
{-# LINE 1313 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ ev_send_event    ev
{-# LINE 1314 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 24) p $ d
{-# LINE 1315 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 32) p $ ev_window        ev
{-# LINE 1316 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 40) p $ ev_request       ev
{-# LINE 1317 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 44) p $ ev_first_keycode ev
{-# LINE 1318 "Graphics/X11/Xlib/Extras.hsc" #-}
    (\hsc_ptr -> pokeByteOff hsc_ptr 48) p $ ev_count         ev
{-# LINE 1319 "Graphics/X11/Xlib/Extras.hsc" #-}
    _ <- xRefreshKeyboardMapping p
    return ()
refreshKeyboardMapping _ = return ()

foreign import ccall unsafe "XlibExtras.h XRefreshKeyboardMapping"
    xRefreshKeyboardMapping :: Ptr () -> IO CInt

-- Properties

anyPropertyType :: Atom
anyPropertyType = 0
{-# LINE 1330 "Graphics/X11/Xlib/Extras.hsc" #-}

foreign import ccall unsafe "XlibExtras.h XChangeProperty"
    xChangeProperty :: Display -> Window -> Atom -> Atom -> CInt -> CInt -> Ptr CUChar -> CInt -> IO Status

foreign import ccall unsafe "XlibExtras.h XDeleteProperty"
    xDeleteProperty :: Display -> Window -> Atom -> IO Status

foreign import ccall unsafe "XlibExtras.h XGetWindowProperty"
    xGetWindowProperty :: Display -> Window -> Atom -> CLong -> CLong -> Bool -> Atom -> Ptr Atom -> Ptr CInt -> Ptr CULong -> Ptr CULong -> Ptr (Ptr CUChar) -> IO Status

rawGetWindowProperty :: Storable a => Int -> Display -> Atom -> Window -> IO (Maybe [a])
rawGetWindowProperty bits d atom w =
    alloca $ \actual_type_return ->
    alloca $ \actual_format_return ->
    alloca $ \nitems_return ->
    alloca $ \bytes_after_return ->
    alloca $ \prop_return -> do
        ret <- xGetWindowProperty d w atom 0 0xFFFFFFFF False anyPropertyType
                           actual_type_return
                           actual_format_return
                           nitems_return
                           bytes_after_return
                           prop_return

        if ret /= 0
            then return Nothing
            else do
                prop_ptr      <- peek prop_return
                actual_format <- fromIntegral `fmap` peek actual_format_return
                nitems        <- fromIntegral `fmap` peek nitems_return
                getprop prop_ptr nitems actual_format
  where
    getprop prop_ptr nitems actual_format
        | actual_format == 0    = return Nothing -- Property not found
        | actual_format /= bits = xFree prop_ptr >> return Nothing
        | otherwise = do
            retval <- peekArray nitems (castPtr prop_ptr)
            _ <- xFree prop_ptr
            return $ Just retval

getWindowProperty8 :: Display -> Atom -> Window -> IO (Maybe [CChar])
getWindowProperty8 = rawGetWindowProperty 8

getWindowProperty16 :: Display -> Atom -> Window -> IO (Maybe [CShort])
getWindowProperty16 = rawGetWindowProperty 16

getWindowProperty32 :: Display -> Atom -> Window -> IO (Maybe [CLong])
getWindowProperty32 = rawGetWindowProperty 32

-- this assumes bytes are 8 bits.  I hope X isn't more portable than that :(

changeProperty8 :: Display -> Window -> Atom -> Atom -> CInt -> [CChar] -> IO ()
changeProperty8 dpy w prop typ mode dat =
    withArrayLen dat $ \ len ptr -> do
        _ <- xChangeProperty dpy w prop typ 8 mode (castPtr ptr) (fromIntegral len)
        return ()

changeProperty16 :: Display -> Window -> Atom -> Atom -> CInt -> [CShort] -> IO ()
changeProperty16 dpy w prop typ mode dat =
    withArrayLen dat $ \ len ptr -> do
        _ <- xChangeProperty dpy w prop typ 16 mode (castPtr ptr) (fromIntegral len)
        return ()

changeProperty32 :: Display -> Window -> Atom -> Atom -> CInt -> [CLong] -> IO ()
changeProperty32 dpy w prop typ mode dat =
    withArrayLen dat $ \ len ptr -> do
        _ <- xChangeProperty dpy w prop typ 32 mode (castPtr ptr) (fromIntegral len)
        return ()

propModeReplace, propModePrepend, propModeAppend :: CInt
propModeReplace = 0
{-# LINE 1401 "Graphics/X11/Xlib/Extras.hsc" #-}
propModePrepend = 1
{-# LINE 1402 "Graphics/X11/Xlib/Extras.hsc" #-}
propModeAppend = 2
{-# LINE 1403 "Graphics/X11/Xlib/Extras.hsc" #-}

deleteProperty :: Display -> Window -> Atom -> IO ()
deleteProperty dpy w prop = do
    _ <- xDeleteProperty dpy w prop
    return ()

-- Windows

foreign import ccall unsafe "XlibExtras.h XUnmapWindow"
    xUnmapWindow :: Display -> Window -> IO CInt

unmapWindow :: Display -> Window -> IO ()
unmapWindow d w = xUnmapWindow d w >> return ()

------------------------------------------------------------------------
-- Size hints

data SizeHints = SizeHints
                   { sh_min_size     :: Maybe (Dimension, Dimension)
                   , sh_max_size     :: Maybe (Dimension, Dimension)
                   , sh_resize_inc   :: Maybe (Dimension, Dimension)
                   , sh_aspect       :: Maybe ((Dimension, Dimension), (Dimension, Dimension))
                   , sh_base_size    :: Maybe (Dimension, Dimension)
                   , sh_win_gravity  :: Maybe (BitGravity)
                   }

pMinSizeBit, pMaxSizeBit, pResizeIncBit, pAspectBit, pBaseSizeBit, pWinGravityBit :: Int
pMinSizeBit    = 4
pMaxSizeBit    = 5
pResizeIncBit  = 6
pAspectBit     = 7
pBaseSizeBit   = 8
pWinGravityBit = 9

instance Storable SizeHints where
    alignment _ = alignment (undefined :: CInt)
    sizeOf _ = (80)
{-# LINE 1440 "Graphics/X11/Xlib/Extras.hsc" #-}

    poke p sh = do
      let whenSet f x = maybe (return ()) x (f sh)
      let pokeFlag b = do flag <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p :: IO CLong
{-# LINE 1444 "Graphics/X11/Xlib/Extras.hsc" #-}
                          (\hsc_ptr -> pokeByteOff hsc_ptr 0) p (setBit flag b)
{-# LINE 1445 "Graphics/X11/Xlib/Extras.hsc" #-}
      (\hsc_ptr -> pokeByteOff hsc_ptr 0) p (0 :: CLong)
{-# LINE 1446 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_min_size $ \(w, h) -> do
        pokeFlag pMinSizeBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 24) p w
{-# LINE 1449 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 28) p h
{-# LINE 1450 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_max_size $ \(w, h) -> do
        pokeFlag pMaxSizeBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 32) p w
{-# LINE 1453 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 36) p h
{-# LINE 1454 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_resize_inc $ \(w, h) -> do
        pokeFlag pResizeIncBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 40) p w
{-# LINE 1457 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 44) p h
{-# LINE 1458 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_aspect $ \((minx, miny), (maxx, maxy)) -> do
        pokeFlag pAspectBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 48) p minx
{-# LINE 1461 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 52) p miny
{-# LINE 1462 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 56) p maxx
{-# LINE 1463 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 60) p maxy
{-# LINE 1464 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_base_size $ \(w, h) -> do
        pokeFlag pBaseSizeBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 64) p w
{-# LINE 1467 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 68) p h
{-# LINE 1468 "Graphics/X11/Xlib/Extras.hsc" #-}
      whenSet sh_win_gravity $ \g -> do
        pokeFlag pWinGravityBit
        (\hsc_ptr -> pokeByteOff hsc_ptr 72) p g
{-# LINE 1471 "Graphics/X11/Xlib/Extras.hsc" #-}

    peek p = do
      flags <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p :: IO CLong
{-# LINE 1474 "Graphics/X11/Xlib/Extras.hsc" #-}
      let whenBit n x = if testBit flags n then liftM Just x else return Nothing
      return SizeHints
         `ap` whenBit pMinSizeBit    (do liftM2 (,) ((\hsc_ptr -> peekByteOff hsc_ptr 24) p)
{-# LINE 1477 "Graphics/X11/Xlib/Extras.hsc" #-}
                                                    ((\hsc_ptr -> peekByteOff hsc_ptr 28) p))
{-# LINE 1478 "Graphics/X11/Xlib/Extras.hsc" #-}
         `ap` whenBit pMaxSizeBit    (do liftM2 (,) ((\hsc_ptr -> peekByteOff hsc_ptr 32) p)
{-# LINE 1479 "Graphics/X11/Xlib/Extras.hsc" #-}
                                                    ((\hsc_ptr -> peekByteOff hsc_ptr 36) p))
{-# LINE 1480 "Graphics/X11/Xlib/Extras.hsc" #-}
         `ap` whenBit pResizeIncBit  (do liftM2 (,) ((\hsc_ptr -> peekByteOff hsc_ptr 40) p)
{-# LINE 1481 "Graphics/X11/Xlib/Extras.hsc" #-}
                                                    ((\hsc_ptr -> peekByteOff hsc_ptr 44) p))
{-# LINE 1482 "Graphics/X11/Xlib/Extras.hsc" #-}
         `ap` whenBit pAspectBit     (do minx <- (\hsc_ptr -> peekByteOff hsc_ptr 48) p
{-# LINE 1483 "Graphics/X11/Xlib/Extras.hsc" #-}
                                         miny <- (\hsc_ptr -> peekByteOff hsc_ptr 52) p
{-# LINE 1484 "Graphics/X11/Xlib/Extras.hsc" #-}
                                         maxx <- (\hsc_ptr -> peekByteOff hsc_ptr 56) p
{-# LINE 1485 "Graphics/X11/Xlib/Extras.hsc" #-}
                                         maxy <- (\hsc_ptr -> peekByteOff hsc_ptr 60) p
{-# LINE 1486 "Graphics/X11/Xlib/Extras.hsc" #-}
                                         return ((minx, miny), (maxx, maxy)))
         `ap` whenBit pBaseSizeBit   (do liftM2 (,) ((\hsc_ptr -> peekByteOff hsc_ptr 64) p)
{-# LINE 1488 "Graphics/X11/Xlib/Extras.hsc" #-}
                                                    ((\hsc_ptr -> peekByteOff hsc_ptr 68) p))
{-# LINE 1489 "Graphics/X11/Xlib/Extras.hsc" #-}
         `ap` whenBit pWinGravityBit ((\hsc_ptr -> peekByteOff hsc_ptr 72) p)
{-# LINE 1490 "Graphics/X11/Xlib/Extras.hsc" #-}


foreign import ccall unsafe "XlibExtras.h XGetWMNormalHints"
    xGetWMNormalHints :: Display -> Window -> Ptr SizeHints -> Ptr CLong -> IO Status

getWMNormalHints :: Display -> Window -> IO SizeHints
getWMNormalHints d w
    = alloca $ \sh -> do
        alloca $ \supplied_return -> do
          -- what's the purpose of supplied_return?
          status <- xGetWMNormalHints d w sh supplied_return
          case status of
            0 -> return (SizeHints Nothing Nothing Nothing Nothing Nothing Nothing)
            _ -> peek sh


data ClassHint = ClassHint
                        { resName  :: String
                        , resClass :: String
                        }

getClassHint :: Display -> Window -> IO ClassHint
getClassHint d w =  allocaBytes ((16)) $ \ p -> do
{-# LINE 1513 "Graphics/X11/Xlib/Extras.hsc" #-}
    s <- xGetClassHint d w p
    if s /= 0 -- returns a nonzero status on success
        then do
            res_name_p <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p
{-# LINE 1517 "Graphics/X11/Xlib/Extras.hsc" #-}
            res_class_p <- (\hsc_ptr -> peekByteOff hsc_ptr 8) p
{-# LINE 1518 "Graphics/X11/Xlib/Extras.hsc" #-}
            res <- liftM2 ClassHint (peekCString res_name_p) (peekCString res_class_p)
            _ <- xFree res_name_p
            _ <- xFree res_class_p
            return res
        else return $ ClassHint "" ""

foreign import ccall unsafe "XlibExtras.h XGetClassHint"
    xGetClassHint :: Display -> Window -> Ptr ClassHint -> IO Status

-- | Set the @WM_CLASS@ property for the given window.
setClassHint :: Display -> Window -> ClassHint -> IO ()
setClassHint dpy win (ClassHint name cl) =
    allocaBytes ((16)) $ \ptr -> do
{-# LINE 1531 "Graphics/X11/Xlib/Extras.hsc" #-}
        withCString name $ \c_name -> withCString cl $ \c_cl -> do
            (\hsc_ptr -> pokeByteOff hsc_ptr 0) ptr c_name
{-# LINE 1533 "Graphics/X11/Xlib/Extras.hsc" #-}
            (\hsc_ptr -> pokeByteOff hsc_ptr 8) ptr c_cl
{-# LINE 1534 "Graphics/X11/Xlib/Extras.hsc" #-}
            xSetClassHint dpy win ptr

foreign import ccall unsafe "XlibExtras.h XSetClassHint"
    xSetClassHint :: Display -> Window -> Ptr ClassHint -> IO ()

------------------------------------------------------------------------
-- WM Hints

-- These are the documented values for a window's "WM State", set, for example,
-- in wmh_initial_state, below. Note, you may need to play games with
-- fromIntegral and/or fromEnum.
withdrawnState,normalState, iconicState :: Int
withdrawnState = 0
{-# LINE 1547 "Graphics/X11/Xlib/Extras.hsc" #-}
normalState    = 1
{-# LINE 1548 "Graphics/X11/Xlib/Extras.hsc" #-}
iconicState    = 3
{-# LINE 1549 "Graphics/X11/Xlib/Extras.hsc" #-}

-- The following values are the documented bit positions on XWMHints's flags field.
-- Use testBit, setBit, and clearBit to manipulate the field.
inputHintBit,stateHintBit,iconPixmapHintBit,iconWindowHintBit,iconPositionHintBit,iconMaskHintBit,windowGroupHintBit,urgencyHintBit :: Int
inputHintBit        = 0
stateHintBit        = 1
iconPixmapHintBit   = 2
iconWindowHintBit   = 3
iconPositionHintBit = 4
iconMaskHintBit     = 5
windowGroupHintBit  = 6
urgencyHintBit      = 8

-- The following bitmask tests for the presence of all bits except for the
-- urgencyHintBit.
allHintsBitmask :: CLong
allHintsBitmask    = 127
{-# LINE 1566 "Graphics/X11/Xlib/Extras.hsc" #-}

data WMHints = WMHints
                 { wmh_flags         :: CLong
                 , wmh_input         :: Bool
                 , wmh_initial_state :: CInt
                 , wmh_icon_pixmap   :: Pixmap
                 , wmh_icon_window   :: Window
                 , wmh_icon_x        :: CInt
                 , wmh_icon_y        :: CInt
                 , wmh_icon_mask     :: Pixmap
                 , wmh_window_group  :: XID
                 }

instance Storable WMHints where
    -- should align to the alignment of the largest type
    alignment _ = alignment (undefined :: CLong)
    sizeOf _ = (56)
{-# LINE 1583 "Graphics/X11/Xlib/Extras.hsc" #-}

    peek p = return WMHints
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 0)         p
{-# LINE 1586 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 8)         p
{-# LINE 1587 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 12) p
{-# LINE 1588 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 16)   p
{-# LINE 1589 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 24)   p
{-# LINE 1590 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 32)        p
{-# LINE 1591 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 32)        p
{-# LINE 1592 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 40)     p
{-# LINE 1593 "Graphics/X11/Xlib/Extras.hsc" #-}
                `ap` (\hsc_ptr -> peekByteOff hsc_ptr 48)  p
{-# LINE 1594 "Graphics/X11/Xlib/Extras.hsc" #-}

    poke p wmh = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0)         p $ wmh_flags         wmh
{-# LINE 1597 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8)         p $ wmh_input         wmh
{-# LINE 1598 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 12) p $ wmh_initial_state wmh
{-# LINE 1599 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16)   p $ wmh_icon_pixmap   wmh
{-# LINE 1600 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 24)   p $ wmh_icon_window   wmh
{-# LINE 1601 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 32)        p $ wmh_icon_x        wmh
{-# LINE 1602 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 36)        p $ wmh_icon_y        wmh
{-# LINE 1603 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 40)     p $ wmh_icon_mask     wmh
{-# LINE 1604 "Graphics/X11/Xlib/Extras.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 48)  p $ wmh_window_group  wmh
{-# LINE 1605 "Graphics/X11/Xlib/Extras.hsc" #-}

foreign import ccall unsafe "XlibExtras.h XGetWMHints"
    xGetWMHints :: Display -> Window -> IO (Ptr WMHints)

getWMHints :: Display -> Window -> IO WMHints
getWMHints dpy w = do
    p <- xGetWMHints dpy w
    if p == nullPtr
        then return $ WMHints 0 False 0 0 0 0 0 0 0
        else do x <- peek p; _ <- xFree p; return x

foreign import ccall unsafe "XlibExtras.h XAllocWMHints"
    xAllocWMHints :: IO (Ptr WMHints)

foreign import ccall unsafe "XlibExtras.h XSetWMHints"
    xSetWMHints :: Display -> Window -> Ptr WMHints -> IO Status

setWMHints :: Display -> Window -> WMHints -> IO Status
setWMHints dpy w wmh = do
    p_wmh <- xAllocWMHints
    poke p_wmh wmh
    res <- xSetWMHints dpy w p_wmh
    _ <- xFree p_wmh
    return res

------------------------------------------------------------------------
-- Keysym Macros
--
-- Which we have to wrap in functions, then bind here.

foreign import ccall unsafe "XlibExtras.h x11_extras_IsCursorKey"
    isCursorKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsFunctionKey"
    isFunctionKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsKeypadKey"
    isKeypadKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsMiscFunctionKey"
    isMiscFunctionKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsModifierKey"
    isModifierKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsPFKey"
    isPFKey :: KeySym -> Bool
foreign import ccall unsafe "XlibExtras.h x11_extras_IsPrivateKeypadKey"
    isPrivateKeypadKey :: KeySym -> Bool

-------------------------------------------------------------------------------
-- Selections
--
foreign import ccall unsafe "HsXlib.h XSetSelectionOwner"
    xSetSelectionOwner :: Display -> Atom -> Window -> Time -> IO ()

foreign import ccall unsafe "HsXlib.h XGetSelectionOwner"
    xGetSelectionOwner :: Display -> Atom -> IO Window

foreign import ccall unsafe "HsXlib.h XConvertSelection"
    xConvertSelection :: Display -> Atom -> Atom -> Atom -> Window -> Time -> IO ()

-------------------------------------------------------------------------------
-- Error handling
--
type XErrorEventPtr = Ptr ()
type CXErrorHandler = Display -> XErrorEventPtr -> IO CInt
type XErrorHandler = Display -> XErrorEventPtr -> IO ()

data ErrorEvent = ErrorEvent {
    ev_type :: !CInt,
    ev_display :: Display,
    ev_serialnum :: !CULong,
    ev_error_code :: !CUChar,
    ev_request_code :: !CUChar,
    ev_minor_code :: !CUChar,
    ev_resourceid :: !XID
}

foreign import ccall safe "wrapper"
    mkXErrorHandler :: CXErrorHandler -> IO (FunPtr CXErrorHandler)
foreign import ccall safe "dynamic"
    getXErrorHandler :: FunPtr CXErrorHandler -> CXErrorHandler
foreign import ccall safe "HsXlib.h XSetErrorHandler"
    _xSetErrorHandler :: FunPtr CXErrorHandler -> IO (FunPtr CXErrorHandler)

-- |A binding to XSetErrorHandler.
--  NOTE:  This is pretty experimental because of safe vs. unsafe calls.  I
--  changed sync to a safe call, but there *might* be other calls that cause a
--  problem
setErrorHandler :: XErrorHandler -> IO ()
setErrorHandler new_handler = do
    _handler <- mkXErrorHandler (\d -> \e -> new_handler d e >> return 0)
    _ <- _xSetErrorHandler _handler
    return ()

-- |Retrieves error event data from a pointer to an XErrorEvent and
--  puts it into an ErrorEvent.
getErrorEvent :: XErrorEventPtr -> IO ErrorEvent
getErrorEvent ev_ptr = do
    _type <- (\hsc_ptr -> peekByteOff hsc_ptr 0) ev_ptr
{-# LINE 1701 "Graphics/X11/Xlib/Extras.hsc" #-}
    serial <- (\hsc_ptr -> peekByteOff hsc_ptr 24) ev_ptr
{-# LINE 1702 "Graphics/X11/Xlib/Extras.hsc" #-}
    dsp <- fmap Display ((\hsc_ptr -> peekByteOff hsc_ptr 8) ev_ptr)
{-# LINE 1703 "Graphics/X11/Xlib/Extras.hsc" #-}
    error_code <- (\hsc_ptr -> peekByteOff hsc_ptr 32) ev_ptr
{-# LINE 1704 "Graphics/X11/Xlib/Extras.hsc" #-}
    request_code <- (\hsc_ptr -> peekByteOff hsc_ptr 33) ev_ptr
{-# LINE 1705 "Graphics/X11/Xlib/Extras.hsc" #-}
    minor_code <- (\hsc_ptr -> peekByteOff hsc_ptr 34) ev_ptr
{-# LINE 1706 "Graphics/X11/Xlib/Extras.hsc" #-}
    resourceid <- (\hsc_ptr -> peekByteOff hsc_ptr 16) ev_ptr
{-# LINE 1707 "Graphics/X11/Xlib/Extras.hsc" #-}
    return $ ErrorEvent {
        ev_type = _type,
        ev_display = dsp,
        ev_serialnum = serial,
        ev_error_code = error_code,
        ev_request_code = request_code,
        ev_minor_code = minor_code,
        ev_resourceid = resourceid
    }

-- |A binding to XMapRaised.
foreign import ccall unsafe "HsXlib.h XMapRaised"
    mapRaised :: Display -> Window -> IO CInt

foreign import ccall unsafe "HsXlib.h XGetCommand"
    xGetCommand :: Display -> Window -> Ptr (Ptr CWString) -> Ptr CInt -> IO Status

getCommand :: Display -> Window -> IO [String]
getCommand d w =
  alloca $
  \argvp ->
  alloca $
  \argcp ->
  do
    _ <- throwIf (success >) (\status -> "xGetCommand returned status: " ++ show status) $ xGetCommand d w argvp argcp
    argc <- peek argcp
    argv <- peek argvp
    texts <- flip mapM [0 .. fromIntegral $ pred argc] $ \i -> peekElemOff argv i >>= peekCWString
    wcFreeStringList argv
    return texts

foreign import ccall unsafe "HsXlib.h XGetModifierMapping"
    xGetModifierMapping :: Display -> IO (Ptr ())

foreign import ccall unsafe "HsXlib.h XFreeModifiermap"
    xFreeModifiermap :: Ptr () -> IO (Ptr CInt)

getModifierMapping :: Display -> IO [(Modifier, [KeyCode])]
getModifierMapping d = do
    p <- xGetModifierMapping d
    m' <- (\hsc_ptr -> peekByteOff hsc_ptr 0) p :: IO CInt
{-# LINE 1748 "Graphics/X11/Xlib/Extras.hsc" #-}
    let m = fromIntegral m'
    pks <- (\hsc_ptr -> peekByteOff hsc_ptr 8) p :: IO (Ptr KeyCode)
{-# LINE 1750 "Graphics/X11/Xlib/Extras.hsc" #-}
    ks <- peekArray (m * 8) pks
    _ <- xFreeModifiermap p
    return . zip masks . map fst . tail . iterate (splitAt m . snd) $ ([], ks)
 where
    masks = [shiftMapIndex .. mod5MapIndex]
