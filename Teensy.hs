module Teensy
(
 initStore
, lsStore
, showStore
, insertEntry
, editEntry
, generateEntry
, rmEntry
, PassName
) where

type PassName = String

gpgOpts = ["--quiet", "--yes", "--batch"]

clip = undefined

{-| 
   Initialize new password storage and use gpg-id for encryption.
   Optionally reencrypt existing passwords using new gpg-id.
-}
initStore :: String -> Bool -> IO ()
initStore gpgID reEncrypt = undefined


{-|
  List passwords.
-}
lsStore :: FilePath -> IO ()
lsStore subFolder = undefined

{-|
  Show existing password and optionally put it on the clipboard.
  If put on the clipboard, it will be cleared in 45 seconds.
-}
showStore :: Bool -> PassName -> IO ()
showStore clip passName = undefined

{-|
  Insert new password. Optionally, the console can be enabled echo
  the password back. Or, optionally, it may be multiline. Prompt
  before overwriting existing password unless forced.
-}
insertEntry :: Bool -> Bool -> Bool -> PassName -> IO ()
insertEntry echo multiLine force passName = undefined

{-|
  Insert a new password or edit an existing password using $EDITOR.
-}
editEntry :: String -> IO ()
editEntry passName = undefined

{-|
  Generate a new password of pass-length with optionally no symbols.
  Optionally put it on the clipboard and clear board after 45 seconds.
  Prompt before overwriting existing password unless forced.
-}
generateEntry :: Bool -> Bool -> Bool -> PassName -> Integer -> IO ()
generateEntry noSymbols clip force passName passLength = undefined

{-|
  Remove existing password or directory, optionally forcefully.
-}
rmEntry :: Bool -> Bool -> PassName -> IO ()
rmEntry recursive force passName = undefined
