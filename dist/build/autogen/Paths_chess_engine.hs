{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_chess_engine (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/awilliamson/.cabal/bin"
libdir     = "/home/awilliamson/.cabal/lib/x86_64-linux-ghc-8.6.5/chess-engine-0.1.0.0-2saZPYids77CfNwipPJdRQ"
dynlibdir  = "/home/awilliamson/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/awilliamson/.cabal/share/x86_64-linux-ghc-8.6.5/chess-engine-0.1.0.0"
libexecdir = "/home/awilliamson/.cabal/libexec/x86_64-linux-ghc-8.6.5/chess-engine-0.1.0.0"
sysconfdir = "/home/awilliamson/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "chess_engine_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "chess_engine_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "chess_engine_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "chess_engine_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "chess_engine_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "chess_engine_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
