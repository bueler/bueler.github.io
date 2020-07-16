Stuff to type in a terminal
===========================

These are some things to type if you are thinking about what to do next:

  * `ls` = list files
    - `ls -lht` = show the file size and modification date too
  * `cd` = change directory
  * `less foo` = view contents of a text file called `foo`
  * `cat foo | grep bar` = search a text file called `foo` for lines with word `bar`
    - `cat *.txt | grep bar` = search all files ending with `.txt` for lines with word `bar`

In a git repository
-------------------

  * `git status` = show modified and untracked files
  * `git ls-files` = show the tracked files
  * `git pull` = update from github (for example) if you don't have local commits which have not been pushed
    - `git pull --rebase` = update, but making your local commits pushable
  * `git add foo` = add the file called `foo` to the list which will be committed
    - do this if `foo` is untracked _or_ if it is modified
  * `git commit -m 'my message'` = commit with the given message
    - just `git commit` will (should) open an editor so you can type your message
  * `git push` = push local commits to github
    - usually do `git status` and perhaps `git pull` or `git pull --rebase` before pushing

For mac users of TextWrangler
-----------------------------

I haven't tried this, but there is advice [here](http://apple.stackexchange.com/questions/9587/how-can-i-open-a-text-file-with-textwrangler-from-the-terminal-command-line) to make an "alias":

    $ alias tw='open -a /Applications/TextWrangler.app'

Now you can use the alias to open the file

    $ tw myfile.txt

When using linux I do something very similar.




