import XMonad
import XMonad.Config.Desktop
import XMonad.Prompt.ConfirmPrompt

main = xmonad desktopConfig
	{ terminal	= "urxvt"
	, modMask	= mod4Mask
	}

--myKeys :: [(String, X ())]
--myKeys =
--	("M-S-q", confirmPrompt defaultXPconfig "exit" $ io exitSuccess)
