Writing a kata
==============

You want to write a kata? That's great! You've probably already solved a
bunch of them, found issues and participated the beta process. If you haven't,
I strongly suggest you to check katas in beta before you start your own. It
gives you great insight about what you might forget in your tests or in your
description. And since issues get resolved, but not deleted, you can check what
kind of issues your favourite kata had during its early days or beta.

So please, check things out. I'll wait here.

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
published programming book. it is hard to get right, but it is worth the
additional time.

Stringly typed code is bad
--------------------------

Nothing to say about that. Unless it leads to convoluted code avert
stringly types. *Please.*

Ok, maybe you're confused. "What's stringly typed code?", you ask.
Well, stringly typed code is when you take a value that could be easily
returned in its correct type (e.g. an `int`, a `double`, a `bool`) and wrap
it in a `String` (or your language's equivalent).

This has several drawbacks:

1. Your users have to convert the value to a String, where another type would
   be more natural, e.g. "YES"/"NO" instead of `true` and `false`.
   It doesn't give you any more information than the boolean.
2. Your users may have to convert the argument from a String to an array, list
   or somewhat similar.
3. It removes precision if used on a floating point value. See the section below
   if you're worried about rounding in floating point values.
4. It doesn't make testing easier for you, especially if you work with
   stringified arrays.

That being said, if you provide a fitting story or motivation, feel free to make
the argument a string, or the return value. But use those strings with care. If
possible, use the proper type.


Use the preloaded section only for helpers or constraints
---------------------------------------------------------
While it might seem tempting to put your solution into the preloaded code
section, don't. Some languages provide reflection or similar means to check your
preloaded code, which enables a user to cheat rather easily.

Also, if you're using a dynamic language like Python, JavaScript or Ruby, keep
in mind that the user can change `Math.random` or similar features unless you
use `Object.freeze` or similar. Java, Haskell, C# and potential other staticly
typed languages don't share this problem.
