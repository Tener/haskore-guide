Installation
=============

### requirements

	Haskore won't build on Windows.
	
	This process has been reported to be succesful under Ubuntu Linux and MacOSX Leopard. 

### install GHC-6.8.3

### get to know cabal

If you're not familiar with cabal, here's a [quick start](http://www.haskell.org/haskellwiki/Cabal/How_to_install_a_Cabal_package).

### get cabal-install

I recommend installing [cabal-install](http://hackage.haskell.org/trac/hackage/wiki/CabalInstall) in user space, so all your cabal packages don't require admin privilege.

Note 1: you might need to manually get other _cabal packages_ that cabal-install depends on as well, e.g. HTTP, zlib, etc. cabal-install will notify you during installation on which packages you need to get. You can find them in [Hackage](http://hackage.haskell.org/packages/archive/pkg-list.html).

Note 2: You get `cabal` binary after installing `cabal-install`. You can view all your installed packages using `ghc-pkg list`. Use `ghc-pkg help` to get more information on package management.

Note 3: Super quick start on installing cabal packages

	-- system commands
	
	cd $package_dir
	
	runghc Setup.hs configure
	runghc Setup.hs build
	runghc Setup.hs install
	
	-- If you prefer install them in user-space, use

	runghc Setup.hs configure --user --prefix=$HOME
	runghc Setup.hs build
	runghc Setup.hs install

### install stock-cabal packages

	-- system commands
	
	cabal install event-list
	cabal install midi
	cabal install markov-chain
	cabal install non-negative
	cabal install unix
	cabal install binary

Note: run `cabal help install` to get more information, e.g. `--global` to force install in root space.

### install custom-cabal packages

you need the following packages exactly. ( Haskore needs these older versions to compile )

	-- fetch urls
	
	http://hackage.haskell.org/packages/archive/hosc/0.1/hosc-0.1.tar.gz
	http://hackage.haskell.org/packages/archive/hsc3/0.1.1/hsc3-0.1.1.tar.gz
	
### install darcs packages

	-- system commands
	
	darcs get http://darcs.haskell.org/supercollider-ht/
	darcs get http://darcs.haskell.org/record-access/

### install Haskore

#### get yourself the good old darcs 1.0.9

The zip package on Haskore homepage won't work on ghc-6.8.3! You need the darcs version, _but_ the darcs repo is broken on darcs 2.0, so you need darcs1 to fetch it.

#### using darcs 1.0.9 to get the repo and install

	-- system commands
	
	darcs1 -- partial http://darcs.haskell.org/haskore/ 

### Test install

	ghci
	:m + Haskore
	
If you can successfully import this module, everything is cool.

I might miss some cabal dependencies, but they should be easily spotted when installing Haskore.

## [Hello World](hello.markdown)