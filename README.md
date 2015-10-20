# My Haskell Education

This repo has a small script `study.rb` for typing examples from a "Real
World Haskell" book. You type an example, run it and if you like the result,
you can remember it in the "database" file called `haskell.yml`. The file
remembers both what was typed in as well as what was generated as a result.

Upon saving the database file, you can then run all your typed examples with
a `doit` script all at once. The `doit` is a runner and the unit test
manager at once--if at any given time the execution result is different from
what you've "registered" in a database initially, the script will find it
out and fail.

Simple way of studying programming languages and remembering what was going
on during the study process.

# How it works

Script reads a series of single-letter commands. So you type a letter and
hit ENTER to perform an action. You can chain commands, in which case you'll
type multiple single-letter commands together, and hit ENTER, and the
commands will execute sequentially.

### Commands List

Command | Explanation
------------- | -------------
e | Edit existing buffer
s | Show a buffer to be executed
c | Clear a buffer
r | Run a buffer
m | Modify a buffer
n | Name the buffer. Name is used by `doit` for snippet file generation
i | Inspect a buffer
w | Write a buffer to a file
a | Append a buffer to a file
h | Help
q | Quit without making changes

# Example

Good example is when you edit, show, name, inspect and run a buffer. And
then you append it to `haskell.yml`. Lets do it for a simple program which
echos "Hello world":

	wk:/w/repos/haskell_edu> ./study.rb
	# help
	# popular: enriac
	e: edit    s: show   n: name   r: run   i: inspect
	m: modify  w: write  q: quit   h: help
	[e,s,c,r,i,m,n,w,q]   0 >esnira
	# editing
	"Hello world"
	#passed:
	"Hello world"
	# /Users/wk/.hs/20151019_211327 written 14 bytes
	# show:
	"Hello world"
	# Enter program's name:
	hello_world_example
	# Got name hello_world_example
	-
	  nam: hello_world_example
	  src: |
	    "Hello world"
	  exp: |
	# running:
	GHCi, version 7.8.3: http://www.haskell.org/ghc/  :? for help
	Loading package ghc-prim ... linking ... done.
	Loading package integer-gmp ... linking ... done.
	Loading package base ... linking ... done.
	Prelude> "Hello world"
	Prelude> Leaving GHCi.
	# Appending
