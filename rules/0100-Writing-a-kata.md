Writing a kata
==============

You want to write a kata? That's great! You've probably already solved a
bunch of them, found issues and participated in the beta process. If you haven't,
I strongly suggest you to check katas in beta before you start your own. It
gives you great insight about what you might forget in your tests or in your
description. And since issues get resolved, but not deleted, you can check what
kind of issues your favourite kata had during its early days or beta.

So please, check things out. We'll wait here.

You're back? Great! Now you're ready to write your own kata. Well, almost.
There's another page, hidden in the inner depths of the [forums]:
the [kata best practices]. You should also read them, as they provide
additional insight.

 [forums]: http://www.codewars.com/topics
 [kata best practices]: http://www.codewars.com/topics/kata-best-practices

Now that you've read all that's available on Codewars itself,
here are some tips and remarks you might find handy or want to keep in mind.

A user solves a kata in a single language, not many
---------------------------------------------------

When your kata is out of beta, the typical user will solve it in their
preferred language. They will either be fascinated and solve your kata
multiple times (which is rather unlikely, sorry), or go on. Therefore,
your kata should shine in that language.

However, this concludes that you may need to change return types in some
circumstances or the input. For example, JavaScript, Python, Ruby and
CoffeeScript allow a variable number of arguments (JS, CS: `arguments`),
while C (without `varlist`), C++ (without variadic templates), Haskell, Java
(without generics) and some other don't. Furthermore, some languages (like
Haskell) don't allow list of heterogeneous types, which rules out some
katas entirely.

And this is fine. If you need to use serious magic just to create a
translation to another language, consider whether the user will enjoy the
kata, or whether he will disdain the hideous abomination. Always remember
to use your language's idiomatic code. And if someone proposes a
translation to your kata and you think it is not really idiomatic, ask them.

Consistency is key
------------------

However, in some cases, it is better to strife away from idiomatic code,
especially if it makes the kata *a lot* easier in the other language. It
devalues the achievements of those who solved the harder version. In those
cases make sure to block the library functions (see below).

But consistency should be taken in measurements. If this leads to
completely unidiomatic code during your translation, consider creating a
completely new kata instead.

Use proper Grammar, Punctuation and Spelling
--------------------------------------------

While elaborate formulations may fancy ferocious fans of funny
alliterations (or similar), they're usually hard to read. If you write a
kata that is meant for beginners, use simple words. Keep sentences short.
Remove all run-on sentences come on you want to avoid that kind of sentence
in your kata description those sentences are bland and hard to comprehend.

If you provide a story, break the description into a _story_ and
a _task_. That way, a reader can enjoy the story without all those `x`s ,
`i`s and numbers. Save that for your task.

Essentially use the same kind of language you would like to read in a
published programming book. It is hard to get right, but it is worth the
additional time.


Use proper formatting
---------------------

Even with proper grammar and spelling your kata can be hard to read.

Especially if you use arbitrary newlines or code without proper formatting, like

do_something(1) = "Hello world"

or similar. That's not really something your readers enjoy. Instead, use
[proper markdown][GFM].
While it might seem tempting to use plain HTML and CSS, it's not future
proof, as the Codewars style might change. Learning GitHub flavored markdown
doesn't take long so make sure to read it.

Also make sure that your text isn't [ragged] too much.
Getting typographic features right is hard and can take a while. Just play
around with different paragraph lengths, headings and tables. But __always__
format your code. You don't want to have something like the aforementioned
`do_something` in your description.

 [GFM]: https://help.github.com/articles/github-flavored-markdown/
 [ragged]: https://en.wikipedia.org/wiki/Typographic_alignment

Use the proper types whenever possible
--------------------------------------

Have a look at the following function:

```java
static public string do_the_thing(string){
  // ...
}
```
What does this function do? It takes a string, and it returns a string. But
it's not clear what happens there. Does the string need to follow a certain
pattern, like `/\s*(\d+\s+)+\s*/g`? Is the string actually an array or a
list, but as a text?

Compare the function above with the function below:

```java
static public int sum_all_things(int[] numbers){
  // ...
}
```
The function's type already tells you that you'll get a bunch of numbers,
and if this compiles, the caller probably gave you a bunch of numbers
(or no number or `null`, but that's not important).

Using a string has several drawbacks, some of them mentioned above:

1. Your users have to convert the value to a String, where another type would
   be more natural, e.g. "YES"/"NO" instead of `true` and `false`.
   It doesn't give you any more information than the boolean.
2. Your users may have to convert the argument from a String to an array, list
   or somewhat similar.
3. It removes precision if used on a floating point value. See the section below
   if you're worried about rounding in floating point values.
4. It doesn't make testing easier for you, especially if you work with
   stringified arrays.
5. The current error message doesn't preserve whitespace, so if a user returns
   `"a      value"` instead of `"a value"`, he might not notice this.

That being said, if you provide a fitting story or motivation, feel free to make
the argument a string, or the return value. But use those strings with care. If
possible, use the proper type and avoid string, unless it leads to convoluted code.


Use the preloaded section only for helpers or constraints
---------------------------------------------------------
While it might seem tempting to put your solution into the preloaded code
section, don't. Some languages provide reflection or similar means to check your
preloaded code, which enables a user to cheat rather easily.

Also, if you're using a dynamic language like Python, JavaScript or Ruby, keep
in mind that the user can change `Math.random` or similar features unless you
use `Object.freeze` or similar. Java, Haskell, C# and potential other statically
typed languages don't share this problem.


Provide helpers for tasks that are dull
---------------------------------------
Sometimes, you'll ask your user to provide the answer in a given format, or to
use certain pre-defined values. Those values should be preloaded too. For the
format, either a fixed format string (`printf` style) or a full-fledged wonders
helps you to get rid of a bunch of troubles, like additional whitespace,
ambiguous syntax and so on.
