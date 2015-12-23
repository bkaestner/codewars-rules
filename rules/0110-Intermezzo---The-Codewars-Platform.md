Intermezzo: The Codewars platform
------------------------

Now that you have read all those tips and tricks, you probably cannot
wait to write your next kata, right?  However, before you jump in, you
should learn a little bit about the Codewars platform, if you want to
run random tests or use the "preload" section.


### How Codewars works

Whenever you write a kata, you have at least six input windows:

1. the description (cannot be blank)
2. the initial solution (cannot be blank)
3. the solution (cannot be blank)
4. the example test fixtures
5. the test fixtures (cannot be blank)
6. the preloaded code

All of this is used by the [runner].  The runner is basically a `node`
process, which calls the languages interpreter and either

- creates a temporary dictionary structure containing all code
  (Haskell, Java, CSharp or other module/file based languages)
- or ___concatenates___ and passes the code to the interpreter via command
  line argument (Ruby, JavaScript, CoffeeScript, Python).

It then checks the output of the process for some fields, filters them,
and shows the filtered text to the user.  If the fields indicate that
the user has passed the tests, they will have passed the kata.

This is the big difference between Codewars and other code running sites
like SPOJ, Hackerrank and other.  There, you will have to read from STDIN,
and give formatted answers to STDOUT.  You often don't learn details about
your failed tests, only that you've failed them, since the tests are often
only different `*.txt` files that get streamed into your file.

Unfortunately, the _running_ parts of the Codewars runner are currently
missing in the repository, but still available in its history.  They
are lacking new content like transpilers though.

In case of JavaScript, the code will get transformed via [`babel`][babel]
_before_ it is passed to `node`.  All of this preprocessing is _not_
counted into the users runtime.

However, the important part is the concatenation in interpreted languages.
That's the part where you have to look out, since it works like this:

```bash
$ cp python-framework run.py # add framework
$ echo          "" >> run.py
$ cat preload.py   >> run.py # add preloaded code
$ echo          "" >> run.py
$ cat solution.py  >> run.py # add user solution
$ echo          "" >> run.py
$ cat tests.py     >> run.py # add tests
$ cat run.py | python -e -
```

The `echo ""` parts are there for newlines.  Either way, as you can see,
all of your _and_ the user's code are in the same file.  This means that
while you have access on everything the user has defined, declared and
written, it also means that they have access to everything you have written.

They can also change the test framework unless it's frozen.  Keep in mind
that there's an asynchronous cheating test, that adds non-passing tests.
For example if the user solution exits prematurely with a "passed" output,
they will get a penalty.

Note that there has been a [heated discussion][issue-214] about the tests
in Ruby. @danielpclark discusses some of the issues in the thread, and its
worth a read.

Now to the other languages.  For Haskell, the runner will automatically
create a temporary dictionary structure that matches the module names.
This dictionary will reside in `/tmp/` and get run via `runhaskell`.
The `hspec` framework has been replaced with another one that has some
more features.  Java and CSharp get handled similarly.

So remember: in interpreted languages, all your code and the user's code
will reside in the same context, whereas in compiled languages all code
will reside in the same directory.

By the way, this is the reason you cannot use `process.argv` in Node,
as it would give a user immediate access to the tests.

 [issue-214]: https://github.com/Codewars/codewars.com/issues/214
 [runner]: https://github.com/Codewars/codewars-runner
 [babel]: http://babeljs.io/
