Installation
=============


### install GHC-6.8.3

### get to know the cabal

If you're not familiar with the cabal package management system for Haskell, spent 5 minuets reading [This wiki](http://www.haskell.org/haskellwiki/Cabal/How_to_install_a_Cabal_package). It could save you some time later.

### get cabal-install

I recommend installing [cabal-install](http://hackage.haskell.org/trac/hackage/wiki/CabalInstall) in user space, so all your cabal packages don't require admin privilege.

Note 1: you might need to manually get other _cabal packages_ that cabal-install depends on as well, e.g. HTTP, zlib, etc. cabal-install will notify you during installation on which packages you need to get. You can find them in [Hackage](http://hackage.haskell.org/).

Note 2: You get `cabal` binary after installing `cabal-install`. You can view all your installed packages using `ghc-pkg list`. Use `ghc-pkg help` to get more information on package management.


### install stock-cabal packages

	-- system commands
	
	cabal install event-list
	cabal install midi
	cabal install markov-chain
	cabal install non-negative

### install custom-cabal packages

you need the following packages exactly. ( Haskore needs these older versions to compile )

	-- fetch urls
	
	http://hackage.haskell.org/packages/archive/hosc/0.1/hosc-0.1.tar.gz
	http://hackage.haskell.org/packages/archive/hsc3/0.1.1/hsc3-0.1.1.tar.gz
		
### install darcs packages

	-- darcs url
	
	http://darcs.haskell.org/supercollider-ht/
	http://darcs.haskell.org/record-access/

### install Haskore

#### get yourself the good old darcs 1.0.9

The zip package on Haskore homepage won't work on ghc-6.8.3! You need the darcs version, _but_ the darcs repo is broken on darcs 2.0, so you need darcs1 to fetch it.

#### using darcs 1.0.9 to get the repo and install

	-- darcs url
	
	http://darcs.haskell.org/haskore/ 
	
Hint: using the `partial` flag, or it takes forever.

### Test install

	ghci
	:m + Haskore
	
If you can successfully import this module, everything is cool.

I might miss some cabal dependencies, but they should be easily spotted when installing Haskore.

## [Hello World](hello.markdown)