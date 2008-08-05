Installation
=============


### get GHC-6.8.3

### get cabal-install

I recommend installing cabal-install in user space, so all your cabal packages don't require admin privilege.

### install stock-cabal packages

	-- system commands
	
	cabal install event-list
	cabal install midi
	cabal install markov-chain
	cabal install non-negative

### install custom-cabal packages

you need the following packages of exact versions

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