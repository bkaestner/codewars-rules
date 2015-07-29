General rules
=============

Here we inspect some general rules which I try to follow. They are mostly
language agnostic.

A user solves a kata in a single language, not many
---------------------------------------------------

When your kata is out of beta, the typical user will solve it in his
preferred language. He will either be fascinated and solve your kata
multiple times (which is rather unlikely), or go on. Therefore, your kata
should shine in that language.

However, this concludes that you may need to change return types in some
circumstances or the input. For example, JavaScript, Python, Ruby and
CoffeeScript allow a variable number of arguments (JS, CS: `arguments`). C
(without `varlist`), C++ (without variadic templates), Haskell, Java
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

Use proper English
-------------------

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

Have complete tests
-------------------

Tests are the bread and butter of Codewars. Without tests, you couldn't
check whether the user has solved your kata, so they're very important. Yet
some neglect them.

Make sure to file an issue if you notice that a kata is lacking some tests.
This will prevent a moderator from approving the kata.

### Always test all corner cases of your input domain

If you ask the user to create a function that should work for
`1 <= N <=  1,000,000`, make sure that his function works for *both* 1 and
1,000,000. If you specified that "negative input should return a monkey",
make sure that you actually test negative input.

### Use random tests

Whenever when you state a kata you also have to write a solution. This is
great, as you can use exactly that function to check the users code
in the tests. What's even better: it makes you think
about the input domain.

This is usually the hard part of creating random tests. After all, creating
sufficient random input is most often harder than creating the kata itself.
But it is worth every honor.

### Always have some example tests

Unless you're creating a puzzle where the user has to find *the answer*,
present some example tests. Those tests should also contain the corner
cases and some easy random tests, e.g. check that the user actually returns
a number for arbitrary negative numbers.

### Handle floating point values the right way

Whenever the user returns a floating point number, make sure that you take
floating point behaviour into account. The user might not add the numbers
in the same order as you, and therefore end up with a slightly different
number. Equality tests will always fail for that poor user.

Unless you want to write a kata were the user needs to round a floating
point value to a certain precision, never ever tell the user to round,
truncate, floor or ceil a floating point number. Instead, check the
[*relative error*](https://en.wikipedia.org/wiki/Approximation_error). You
might some time need to find a good epsilon, I usually use `1e-12` if I
want to have something "almost exact" and `1e-7` if I want something
"near-ish" the correct solution.

**Example:**

```python
def add_three(a,b,c):
    return a + b + c

def add_three_reference(a,b,c):
    return a + (b + c)

print(add_three_reference(1e-12,1e-12,1) == add_three(1e-12,1e-12,1))
# False
```
