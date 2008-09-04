Installation
=============

### before everything

Haskore is evolving, try the method on [haskell wiki](http://www.haskell.org/haskellwiki/Haskore) first, which is supposed to work for windows / unix. Haskore didn't build on windows at the time this guide was written, so only use this guide as a reference.

### requirements

* This process will not work under Windows, follow [the guide on haskell wiki](http://www.haskell.org/haskellwiki/Haskore) ( I don't know if it works for windows, yet).
* This process has been reported to be successful under Ubuntu Linux and MacOSX Leopard. 

### install GHC-6.8.3

### get to know cabal

If you're not familiar with cabal, here's a [quick start](http://www.haskell.org/haskellwiki/Cabal/How_to_install_a_Cabal_package).

### get cabal-install

	-- system commands
	
	wget http://hackage.haskell.org/packages/archive/cabal-install/0.5.2/cabal-install-0.5.2.tar.gz
	tar -zxf cabal-install-0.5.2.tar.gz 
	cd cabal-install-0.5.2
	./bootstrap.sh 

	-- after adding ~/.cabal/bin to $PATH
	cabal update
	
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
	
steps to install custom / darcs packages:

	-- system commands
	
	cd $package_dir
	
	runghc Setup.hs configure
	runghc Setup.hs build
	runghc Setup.hs install
	
	-- If you prefer install them in user-space, use

	runghc Setup.hs configure --user --prefix=$HOME
	runghc Setup.hs build
	runghc Setup.hs install
	
### install darcs packages

	-- system commands
	
	darcs get http://darcs.haskell.org/supercollider-ht/
	darcs get http://darcs.haskell.org/record-access/

### install Haskore

#### get yourself the good old darcs 1.0.9

The zip package on Haskore homepage won't work on ghc-6.8.3! You need the darcs version, _but_ the darcs repo is broken on darcs 2.0, so you need darcs1 to fetch it.

#### using darcs 1.0.9 to get the repo and install

	-- system commands
	
	darcs1 get --partial http://darcs.haskell.org/haskore/ 

### Test install

	ghci
	:m + Haskore
	
If you can successfully import this module, everything is cool.

I might miss some cabal dependencies, but they should be easily spotted when installing Haskore.

## [Hello World](hello.markdown)