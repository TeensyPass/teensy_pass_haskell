import Control.Monad
import Options.Applicative

type PassName = String

data Options = InitOptions { gpgID :: String
                           , reencrypt :: Bool}
             | LsOptions FilePath
             | ShowOptions { clip :: Bool
                           , passName :: PassName}

initParser = InitOptions
             <$> argument str (metavar "GPG-ID")
             <*> switch ( long "reencrypt"
                          <> short 'e' )

lsParser = LsOptions 
           <$> strOption (long "subdir"
                          <> metavar "SUBDIR"
                          <> value "" )

showParser = ShowOptions
             <$> switch (long "clip"
                         <> short 'c')
             <*> argument str (metavar "PASS-NAME")

           
initStore (InitOptions _ _) = print "hello"
lsStore (LsOptions _) = print "hello"
showStore (ShowOptions _ _) = print "hello"

superParser = subparser
              (command "init" (initStore <$> info initParser idm)
               <> command "ls" (lsStore <$> info lsParser idm)
               <> command "show" (showStore <$> info showParser idm))

main :: IO ()
main = join $ execParser opts
    where opts = info (helper <*> superParser)
                 ( fullDesc
                   <> progDesc ""
                   <> header "")
