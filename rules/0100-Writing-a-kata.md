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

See also the section on translations.

Consistency is key
------------------

However, in some cases, it is better to strife away from idiomatic code,
especially if it makes the kata *a lot* easier in the other language. It
devalues the achievements of those who solved the harder version. In those
cases make sure to block the library functions (see below).

But consistency should be taken in measurements. If this leads to
completely unidiomatic code during your translation, consider creating a
completely new kata instead.


Follow your language's naming conventions
-----------------------------------------

Every language has its quirks. Some of them get discussed in the later sections.
However, there's one thing that should get mentioned at this point:
**make sure to use your language's proposed naming convention, if there exists
one.**

This includes simple character cases like capitalized class names (almost all
object oriented languages) or method names (CSharp), and whether a multi word
function should be written with underscores (also called `snake_case`, e.g.
`my_awesome_function`, Ruby, Python) or in *camelCase* (Haskell,
JavaScript CoffeeScript).

This obviously concludes that the function will differ in different languages.
But then again, remember the previous rule, *a user solves a kata in a single
language, not many*. Make the user feel at home.

By the way, if you use abbreviations for your function's name, make sure that
they are common. Otherwise just use the full name.


Use proper Grammar, Punctuation and Spelling
--------------------------------------------

While elaborate formulations may fancy ferocious fans of funny
alliterations (or similar), they're usually hard to read. If you write a
kata that is meant for beginners, use simple words. Keep sentences short.
Remove all run-on sentences come on you want to avoid that kind of sentence
in your kata description those sentences are bland and hard to comprehend.

Essentially use the same kind of language you would like to read in a
published programming book. It is hard to get right, but it is worth the
additional time.


Split story and task
--------------------------

If you provide a story, break the description into a _story_ and
a _task_. That way, a reader can enjoy the story without all those `x`s ,
`i`s and numbers. Save that for your task.


Use proper formatting
---------------------

Even with proper grammar and spelling your kata can be hard to read.

Especially if you use arbitrary newlines or code without proper formatting, like

\# do_something(1) should return "Hello world"
do_something(1) == "Hello world"

or similar. That's not really something your readers enjoy. Instead, use
[proper markdown][GFM]:

    ``` python
    # do_something(1) should return "Hello world"
    do_something(1) = "Hello world"
    ```

``` python
# do_something(1) should return "Hello world"
do_something(1) = "Hello world"
```

This looks a lot nicer than the previous one.

While it might seem tempting to use plain HTML and CSS, it's not future
proof, as the Codewars style might change. Learning GitHub flavoured markdown
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

Types are everywhere. Even if you use dynamic typed languages, you've at
least encountered some quirks of your language, like `"12345" + 1` in
JavaScript, or "xy isn't a ab" in Python or Ruby.

There are basically two things that can go wrong with types: you can
ask the user for the wrong return type, or __you__ accidentally use
the wrong type in your reference solution.

The second one is a lot harder to notice, so lets keep this for later.
Instead let us look at one often used wrong return type first: the string.

### The problem with strings

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
5. The current error message doesn't preserve white space, so if a user returns
   `"a      value"` instead of `"a value"`, he might not notice this.

That being said, if you provide a fitting story or motivation, feel free to make
the argument a string, or the return value. But use those strings with care. If
possible, use the proper type and avoid string, unless it leads to convoluted code.


### The wrong return type

Even if you don't use strings, you can end up with the wrong type. Let us
motivate this with an example.

The Fibonacci sequence is defined as follows

$$
f_n = \begin{cases}
 1 & n = 1\\
 1 & n = 2\\
 f_{n-1} + f_{n-2} & \text{otherwise} \\
\end{cases}
$$

Now, lets say you want a user to write a function that returns arbitrary
Fibonacci numbers up to `N = 100`:

``` c
int32_t fibonacci(int8_t N);
```

You might already note where I'm going with this, if not, read on.
Lets have a look at $f_{45}$, $f_{46}$ and $f_{47}$:
$1134903170, 1836311903, 2971215073$. And if you're familiar with the bounds
of signed 32bit integer numbers, you should already see the problem.

The number $2971215073$ cannot get represented with 32 bits (if signed integers
are used), since $\log_2 (2971215073) > 31$. If you were to ask the user for
$f_{50}$ (or even $N = 100$), you (and they!) end up with a wrong answer:

``` c
printf("f 47: %d\n", fibonacci(47));
// prints -1323752223
```

This indicates that `int32_t` isn't enough for your kata. Even `uint64_t` isn't,
since $\log_2 (f_{100}) > 64$,
so you have to switch to your languages `BigInteger` variant, e.g. `BigInt`,
`bignum`, `Integer`.

By the way, this particular error could have been prevented by a test that
checks that every returned number is positive. Also, if you use a dynamic
typed language, make sure to check the return type in one of the first tests:

``` ruby
Test.expect (fib(0) is Bignum, "Your function doesn't return a BigNum")
```

### Wrong internal types

This is usually a mess. Your return type is correct, and you check for the
correct type, but your users complain about invalid results. This indicates
that you accidentally used the wrong type somewhere in your own computation,
for example `int16_t` in a helper function. This is __really__ hard to spot,
so you should add some static test values. More on that in the later sections.

### Integral vs floating point arithmetic
There's a later section on floating point numbers, but this section is also
fitting for the delicate problem. As you (hopefully) know, floating point
arithmetic isn't exact. The usual double value has 54 bits for its significant,
which is better than `int32_t`, but worse than `int64_t`. So if you ask for an
__exact__ solution, you should ask for an integral type and also check
that the user returns an integral type (in dynamic typed languages).

Note that JavaScript doesn't really differ between integral and floating point
numbers. You can force numbers to behave as `int32` (or `uint32`), but you
cannot help the user with an appropriate error message in this case.

Also, JavaScript doesn't have a large integer class/type, so you need to
improvise a little bit.

Use the preloaded section only for helpers or constraints
---------------------------------------------------------
The preloaded code is both usable by you and the user. It's the perfect place to
put helpers or data structures that the user should use, or to freeze objects in
dynamic languages.

However, __never__ put your solution into the preloaded code! Some languages
provide reflection or similar means to check your preloaded code, which enables
a user to cheat rather easily. Instead, put your solution into a local scope
(see [Hide your solution](#hide-your-solution)).


Provide helpers for tasks that are dull
---------------------------------------
Sometimes, you'll ask your user to provide the answer in a given format, or to
use certain pre-defined values. Those values should be preloaded too. For the
format, either a fixed format string (`printf` style) or a full-fledged wonders
helps you to get rid of a bunch of troubles, like additional white space,
ambiguous syntax and so on.


A word of warning
-----------------

Before we dive into tests in the next section, here's a word of warning.
The next section does not replace the documentation of your testing framework.
It gives _general tips_. However, in order to write good tests, a deep
understanding of your testing framework is mandatory. Otherwise, it will
take much time to write those, especially if you don't know the programming
language well enough yet.

Have a look at the following test:

```haskell
main = do
  if solution 1 /= 1
    then exitFailure
    else
      if solution 2 /= 1
        then exitFailure
        else
          if solution 3 /= 2
            then exitFailure
            else
              if solution 4 /= 3
                then exitFailure
                else
                  if solution 5 /= 3
                    then exitFailure
                    else return ()
```
This test checks whether `solution` returns the first five Fibonacci numbers.
It's bad for several reasons:

- it doesn't return any helpful error message if the solution is wrong
- it's not modular
- it's not compatible to the CodeWars testing framework

Another variant, which uses Hspec and random tests could be written as

```haskell
main = do
  rs <- replicateM 100 (randomRIO (1,100))
  hspec $ do
    describe "fibonacci" $ do
      forM_ rs $ \x ->
        it ("works for " ++ show x) $
          fibonacci x `shouldBe` solution x
```
While better, it doesn't use Hspec's interoperability with QuickCheck:

```haskell
main = hspec $ describe "fibonacci" $ do
    prop "works for random numbers" $ \x ->
      fibonacci x `shouldBe` solution x
  where
    solution = ...
```

So before you dive into the next section, make sure that you have at least
a rough overview of the capabilities of your language's testing framework.
