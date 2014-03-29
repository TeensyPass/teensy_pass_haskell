import Control.Monad
import Options.Applicative

type PassName = String

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
           
initStore (InitOptions _ _) = print "hello"
lsStore (LsOptions _) = print "hello"
showStore (ShowOptions _ _) = print "hello"
insertStore (InsertOptions _ _ _ _) = print "hello"
editStore (EditOptions _) = print "hello"
generate (GenerateOptions _ _ _ _ _) = print "hello"
rm (RmOptions _ _ _) = print "hello"

initDesc  = ( fullDesc
              <> progDesc ""
              <> header "")


superParser = subparser
              (command "init" (initStore <$> info (helper <*> initParser) initDesc)
               <> command "ls" (lsStore <$> info lsParser idm)
               <> command "show" (showStore <$> info showParser idm)
               <> command "insert" (insertStore <$> info insertParser idm)
               <> command "edit" (editStore <$> info editParser idm)
               <> command "generate" (generate <$> info generateParser idm)
               <> command "rm" (rm <$> info rmParser idm))

main :: IO ()
main = join $ execParser opts
    where opts = info (helper <*> superParser)
                 ( fullDesc
                   <> progDesc ""
                   <> header "")
