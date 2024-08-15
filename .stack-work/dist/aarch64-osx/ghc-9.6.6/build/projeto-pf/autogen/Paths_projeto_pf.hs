{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_projeto_pf (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/bin"
libdir     = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/lib/aarch64-osx-ghc-9.6.6/projeto-pf-0.1.0.0-gGMSKUyVjk3UlI3fxWA0F-projeto-pf"
dynlibdir  = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/lib/aarch64-osx-ghc-9.6.6"
datadir    = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/share/aarch64-osx-ghc-9.6.6/projeto-pf-0.1.0.0"
libexecdir = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/libexec/aarch64-osx-ghc-9.6.6/projeto-pf-0.1.0.0"
sysconfdir = "/Users/macbook/repos/pf/projeto-pf/.stack-work/install/aarch64-osx/6b96a5004d8eacf7a6dc80adfcb96504f89b6afe73be590cd1eae41f3ffaff6e/9.6.6/etc"

getBinDir     = catchIO (getEnv "projeto_pf_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "projeto_pf_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "projeto_pf_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "projeto_pf_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "projeto_pf_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "projeto_pf_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
