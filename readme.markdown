A dummy guide to Haskore
=========================



Installation
------------


### get GHC-6.8.3

### get cabal-install

I recommend installing cabal-install in user space, so all your cabal packages don't require admin privilege.

### install stock-cabal packages

	cabal install event-list
	cabal install midi
	cabal install markov-chain
	cabal install non-negative
	cabal install record-access

### install custom-cabal packages

you need the following packages of exact versions

	hsc3-0.1.1
	hosc-0.1
	
### install darcs packages

	http://darcs.haskell.org/supercollider-ht/

### install Haskore

#### get yourself the good old darcs 1.0.9

The zip package on Haskore homepage won't work on ghc-6.8.3! You need the darcs version, _but_ the darcs repo is broken on darcs 2.0, so you need darcs1 to fetch it.

#### using darcs 1.0.9 to get the repo and install

	http://darcs.haskell.org/haskore/ 
	
Hint: using the `partial` flag, or it takes forever.