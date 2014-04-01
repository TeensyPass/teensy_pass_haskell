import Control.Monad
import Options.Applicative
import Teensy

-- TODO: move into Options type
initDesc = progDesc "Init new pass storage using gpg"
lsDesc = progDesc "List passwords"
showDesc = progDesc "Show existing password."
insertDesc = progDesc "Insert new password"
editDesc = progDesc "edit an entry using $EDITOR"
generateDesc = progDesc "Generate a new password of pass-length"
rmDesc = progDesc "Remove existing password or directory"

data Options = InitOptions { gpgID :: String
                           , reencrypt :: Bool}
             | LsOptions FilePath
             | ShowOptions { clip :: Bool
                           , passName :: PassName}
             | InsertOptions { echo :: Bool
                             , multiline :: Bool
                             , force :: Bool
                             , passName :: PassName}
             | EditOptions PassName
             | GenerateOptions { noSymbols :: Bool
                               , clip :: Bool
                               , force :: Bool
                               , passName :: PassName
                               , passLengh :: Integer }
             | RmOptions { recursive :: Bool
                         , force :: Bool
                         , passName :: PassName}

clipParser = switch (long "clip" <> short 'c')
forceParser = switch (long "force" <> short 'f')
passNameParser = argument str (metavar "PASSNAME")

-- TODO: move into Options type
initParser = InitOptions
             <$> argument str (metavar "GPG-ID")
             <*> switch ( long "reencrypt" <> short 'e' )

lsParser = LsOptions
           <$> strOption (long "subdir"
                          <> metavar "SUBDIR"
                          <> value "" )

showParser = ShowOptions
             <$> clipParser
             <*> argument str (metavar "PASS-NAME")

insertParser = InsertOptions
               <$> switch (long "echo" <> short 'e')
               <*> switch (long "multiline" <> short 'm')
               <*> forceParser
               <*> passNameParser

editParser = EditOptions <$> passNameParser
generateParser = GenerateOptions
                 <$> switch (long "no-symbols" <> short 'n')
                 <*> clipParser
                 <*> forceParser
                 <*> passNameParser
                 <*> argument auto (metavar "PASS-LENGTH")

rmParser = RmOptions
           <$> switch (long "recursive" <> short 'r')
           <*> forceParser
           <*> passNameParser

-- TODO: Ugh this is annoying...need to find a cleaner way dispatch this
cmd :: Options -> IO ()
cmd (InitOptions reEncrypt gpgID) = initStore reEncrypt gpgID
cmd (LsOptions subFolder) = lsStore subFolder
cmd (ShowOptions clip name) = showStore clip name
cmd (InsertOptions echo multiLine force name) = insertEntry echo multiLine force name
cmd (EditOptions name) = editEntry name
cmd (GenerateOptions noSymbols clip force name length) = 
    generateEntry noSymbols clip force name length
cmd (RmOptions recursive force name) = rmEntry recursive force name

subCommands = [("init", initParser, initDesc)
              ,("ls", lsParser, lsDesc)
              ,("show", showParser, showDesc)
              ,("insert", initParser, insertDesc)
              ,("edit", editParser, editDesc)
              ,("generate", generateParser, generateDesc)
              ,("rm", rmParser, rmDesc)]

superParser = subparser $ foldr ((<>) . command') idm subCommands
    where command' (name, parser, desc) = command name (cmd <$> info (helper <*> parser) desc)
                                
main :: IO ()
main = join $ execParser opts
    where opts = info (helper <*> superParser) idm
