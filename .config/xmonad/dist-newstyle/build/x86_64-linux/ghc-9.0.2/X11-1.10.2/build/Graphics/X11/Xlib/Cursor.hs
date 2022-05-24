{-# LINE 1 "Graphics/X11/Xlib/Cursor.hsc" #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.X11.Xlib.Cursor
-- Copyright   :  (C) Collabora Ltd  2009
-- License     :  BSD-style (see the file libraries/base/LICENSE)
--
-- Maintainer  :  libraries@haskell.org
-- Stability   :  provisional
-- Portability :  portable
--
-- A collection of cursor types defined by \/usr/include/X11/cursorfont.h.
--
-----------------------------------------------------------------------------

module Graphics.X11.Xlib.Cursor(

        xC_X_cursor,
        xC_arrow,
        xC_based_arrow_down,
        xC_based_arrow_up,
        xC_boat,
        xC_bogosity,
        xC_bottom_left_corner,
        xC_bottom_right_corner,
        xC_bottom_side,
        xC_bottom_tee,
        xC_box_spiral,
        xC_center_ptr,
        xC_circle,
        xC_clock,
        xC_coffee_mug,
        xC_cross,
        xC_cross_reverse,
        xC_crosshair,
        xC_diamond_cross,
        xC_dot,
        xC_dotbox,
        xC_double_arrow,
        xC_draft_large,
        xC_draft_small,
        xC_draped_box,
        xC_exchange,
        xC_fleur,
        xC_gobbler,
        xC_gumby,
        xC_hand1,
        xC_hand2,
        xC_heart,
        xC_icon,
        xC_iron_cross,
        xC_left_ptr,
        xC_left_side,
        xC_left_tee,
        xC_leftbutton,
        xC_ll_angle,
        xC_lr_angle,
        xC_man,
        xC_mouse,
        xC_pencil,
        xC_pirate,
        xC_plus,
        xC_question_arrow,
        xC_right_ptr,
        xC_right_side,
        xC_right_tee,
        xC_rightbutton,
        xC_rtl_logo,
        xC_sailboat,
        xC_sb_down_arrow,
        xC_sb_h_double_arrow,
        xC_sb_left_arrow,
        xC_sb_right_arrow,
        xC_sb_up_arrow,
        xC_sb_v_double_arrow,
        xC_shuttle,
        xC_sizing,
        xC_spider,
        xC_spraycan,
        xC_star,
        xC_target,
        xC_tcross,
        xC_top_left_arrow,
        xC_top_left_corner,
        xC_top_right_corner,
        xC_top_side,
        xC_top_tee,
        xC_trek,
        xC_ul_angle,
        xC_umbrella,
        xC_ur_angle,
        xC_watch,
        xC_xterm,

        ) where

import Graphics.X11.Xlib.Font

----------------------------------------------------------------
-- Cursors
----------------------------------------------------------------



xC_X_cursor             :: Glyph
xC_X_cursor             = 0
{-# LINE 106 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_arrow                :: Glyph
xC_arrow                = 2
{-# LINE 109 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_based_arrow_down     :: Glyph
xC_based_arrow_down     = 4
{-# LINE 112 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_based_arrow_up       :: Glyph
xC_based_arrow_up       = 6
{-# LINE 115 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_boat                 :: Glyph
xC_boat                 = 8
{-# LINE 118 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_bogosity             :: Glyph
xC_bogosity             = 10
{-# LINE 121 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_bottom_left_corner   :: Glyph
xC_bottom_left_corner   = 12
{-# LINE 124 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_bottom_right_corner  :: Glyph
xC_bottom_right_corner  = 14
{-# LINE 127 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_bottom_side          :: Glyph
xC_bottom_side          = 16
{-# LINE 130 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_bottom_tee           :: Glyph
xC_bottom_tee           = 18
{-# LINE 133 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_box_spiral           :: Glyph
xC_box_spiral           = 20
{-# LINE 136 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_center_ptr           :: Glyph
xC_center_ptr           = 22
{-# LINE 139 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_circle               :: Glyph
xC_circle               = 24
{-# LINE 142 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_clock                :: Glyph
xC_clock                = 26
{-# LINE 145 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_coffee_mug           :: Glyph
xC_coffee_mug           = 28
{-# LINE 148 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_cross                :: Glyph
xC_cross                = 30
{-# LINE 151 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_cross_reverse        :: Glyph
xC_cross_reverse        = 32
{-# LINE 154 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_crosshair            :: Glyph
xC_crosshair            = 34
{-# LINE 157 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_diamond_cross        :: Glyph
xC_diamond_cross        = 36
{-# LINE 160 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_dot                  :: Glyph
xC_dot                  = 38
{-# LINE 163 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_dotbox               :: Glyph
xC_dotbox               = 40
{-# LINE 166 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_double_arrow         :: Glyph
xC_double_arrow         = 42
{-# LINE 169 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_draft_large          :: Glyph
xC_draft_large          = 44
{-# LINE 172 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_draft_small          :: Glyph
xC_draft_small          = 46
{-# LINE 175 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_draped_box           :: Glyph
xC_draped_box           = 48
{-# LINE 178 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_exchange             :: Glyph
xC_exchange             = 50
{-# LINE 181 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_fleur                :: Glyph
xC_fleur                = 52
{-# LINE 184 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_gobbler              :: Glyph
xC_gobbler              = 54
{-# LINE 187 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_gumby                :: Glyph
xC_gumby                = 56
{-# LINE 190 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_hand1                :: Glyph
xC_hand1                = 58
{-# LINE 193 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_hand2                :: Glyph
xC_hand2                = 60
{-# LINE 196 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_heart                :: Glyph
xC_heart                = 62
{-# LINE 199 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_icon                 :: Glyph
xC_icon                 = 64
{-# LINE 202 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_iron_cross           :: Glyph
xC_iron_cross           = 66
{-# LINE 205 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_left_ptr             :: Glyph
xC_left_ptr             = 68
{-# LINE 208 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_left_side            :: Glyph
xC_left_side            = 70
{-# LINE 211 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_left_tee             :: Glyph
xC_left_tee             = 72
{-# LINE 214 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_leftbutton           :: Glyph
xC_leftbutton           = 74
{-# LINE 217 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_ll_angle             :: Glyph
xC_ll_angle             = 76
{-# LINE 220 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_lr_angle             :: Glyph
xC_lr_angle             = 78
{-# LINE 223 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_man                  :: Glyph
xC_man                  = 80
{-# LINE 226 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_middlebutton         :: Glyph
xC_middlebutton         = 82
{-# LINE 229 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_mouse                :: Glyph
xC_mouse                = 84
{-# LINE 232 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_pencil               :: Glyph
xC_pencil               = 86
{-# LINE 235 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_pirate               :: Glyph
xC_pirate               = 88
{-# LINE 238 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_plus                 :: Glyph
xC_plus                 = 90
{-# LINE 241 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_question_arrow       :: Glyph
xC_question_arrow       = 92
{-# LINE 244 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_right_ptr            :: Glyph
xC_right_ptr            = 94
{-# LINE 247 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_right_side           :: Glyph
xC_right_side           = 96
{-# LINE 250 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_right_tee            :: Glyph
xC_right_tee            = 98
{-# LINE 253 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_rightbutton          :: Glyph
xC_rightbutton          = 100
{-# LINE 256 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_rtl_logo             :: Glyph
xC_rtl_logo             = 102
{-# LINE 259 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sailboat             :: Glyph
xC_sailboat             = 104
{-# LINE 262 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_down_arrow        :: Glyph
xC_sb_down_arrow        = 106
{-# LINE 265 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_h_double_arrow    :: Glyph
xC_sb_h_double_arrow    = 108
{-# LINE 268 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_left_arrow        :: Glyph
xC_sb_left_arrow        = 110
{-# LINE 271 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_right_arrow       :: Glyph
xC_sb_right_arrow       = 112
{-# LINE 274 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_up_arrow          :: Glyph
xC_sb_up_arrow          = 114
{-# LINE 277 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sb_v_double_arrow    :: Glyph
xC_sb_v_double_arrow    = 116
{-# LINE 280 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_shuttle              :: Glyph
xC_shuttle              = 118
{-# LINE 283 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_sizing               :: Glyph
xC_sizing               = 120
{-# LINE 286 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_spider               :: Glyph
xC_spider               = 122
{-# LINE 289 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_spraycan             :: Glyph
xC_spraycan             = 124
{-# LINE 292 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_star                 :: Glyph
xC_star                 = 126
{-# LINE 295 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_target               :: Glyph
xC_target               = 128
{-# LINE 298 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_tcross               :: Glyph
xC_tcross               = 130
{-# LINE 301 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_top_left_arrow       :: Glyph
xC_top_left_arrow       = 132
{-# LINE 304 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_top_left_corner      :: Glyph
xC_top_left_corner      = 134
{-# LINE 307 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_top_right_corner     :: Glyph
xC_top_right_corner     = 136
{-# LINE 310 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_top_side             :: Glyph
xC_top_side             = 138
{-# LINE 313 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_top_tee              :: Glyph
xC_top_tee              = 140
{-# LINE 316 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_trek                 :: Glyph
xC_trek                 = 142
{-# LINE 319 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_ul_angle             :: Glyph
xC_ul_angle             = 144
{-# LINE 322 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_umbrella             :: Glyph
xC_umbrella             = 146
{-# LINE 325 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_ur_angle             :: Glyph
xC_ur_angle             = 148
{-# LINE 328 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_watch                :: Glyph
xC_watch                = 150
{-# LINE 331 "Graphics/X11/Xlib/Cursor.hsc" #-}

xC_xterm                :: Glyph
xC_xterm                = 152
{-# LINE 334 "Graphics/X11/Xlib/Cursor.hsc" #-}

----------------------------------------------------------------
-- End
----------------------------------------------------------------
