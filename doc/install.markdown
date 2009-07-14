Installation
=============

### requirements

* This process might not work under Windows, follow [the guide on haskell wiki](http://www.haskell.org/haskellwiki/Haskore) ( I don't know if it works for windows, yet).
* This process has been reported to be successful under Ubuntu Linux and MacOSX Leopard. 

### install GHC

### install [cabal-install](http://hackage.haskell.org/trac/hackage/wiki/CabalInstall)
	
### install Haskore

    cabal update
    cabal install haskore

### Test install

	ghci
	:m + Haskore
	
If you can successfully import this module, everything is cool.

## [Hello World](hello.markdown)