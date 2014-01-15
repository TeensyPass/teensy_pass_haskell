{-# LANGUAGE TemplateHaskell #-}

import Options

defineOptions "MainOptions" $ do
    stringOption "optMessage" "message" "Hello world!"
        "A message to show the user."
    boolOption "optQuiet" "quiet" False
        "Whether to be quiet."

main :: IO ()
main = runCommand $ \opts args -> do
    if optQuiet opts
        then return ()
        else putStrLn (optMessage opts)
