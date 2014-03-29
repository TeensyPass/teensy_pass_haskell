type PassName = String

{-| 
   Initialize new password storage and use gpg-id for encryption.
   Optionally reencrypt existing passwords using new gpg-id.
-}
init :: Bool -> String -> IO ()
init reEncrypt gpgID = undefined


{-|
  List passwords.
-}
ls :: FilePath -> IO ()
ls subFolder = undefined

{-|
  Show existing password and optionally put it on the clipboard.
  If put on the clipboard, it will be cleared in 45 seconds.
-}
show :: Bool -> PassName -> IO ()
show clip passName = undefined

{-|
  Insert new password. Optionally, the console can be enabled echo
  the password back. Or, optionally, it may be multiline. Prompt
  before overwriting existing password unless forced.
-}
insert :: Bool -> Bool -> Bool -> PassName -> IO ()
insert echo multiLine force passName = undefined

{-|
  Insert a new password or edit an existing password using $EDITOR.
-}
edit :: String -> IO ()
edit passName = undefined

{-|
  Generate a new password of pass-length with optionally no symbols.
  Optionally put it on the clipboard and clear board after 45 seconds.
  Prompt before overwriting existing password unless forced.
-}
generate :: Bool -> Bool -> Bool -> PassName -> Integer -> IO ()
generate noSymbols clip force passName passLength = undefined

{-|
  Remove existing password or directory, optionally forcefully.
-}
rm :: Bool -> Bool -> PassName -> IO ()
rm recursive -> force -> passName = undefined
