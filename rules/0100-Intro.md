---
title: The conjured Codewars codex
author: github.com/bkaes
language: english
toc: true
---

This document contains some rules I've employed for my katas and my translation on [Codewars]. Some of them are very simple (e.g same arguments, same order), others are sometimes really hard to fulfill (random tests). But only rules aren't interesting. This document contains also some tips, so that you (or I) can implement them.

 [Codewars]: http://www.codewars.com

If you find an error, have a better idea, or think that all of this is a pile of unicorn misery, feel free to create an issue or a pull-request. Have a look at the LICENCE.

# General rules
Here we inspect some general rules which I try to follow. They are mostly language agnostic.

## A user solves a kata in a single language, not many
When your kata is out of beta, the typical user will solve it in his preferred language. He will either be fascinated and solve your kata multiple times (which is rather unlikely), or go on. Therefore, your kata should shine in that language.

However, this concludes that you may need to change return types in some circumstances or the input. For example, JavaScript, Python, Ruby and CoffeeScript allow a variable number of  arguments (JS, CS: `arguments`). C (without `varlist`), C++ (without variadic templates), Haskell, Java (without generics) and some other don't. Furthermore, some languages (like Haskell) don't allow list of heterogeneous types, which rules out some katas entirely.

And this is fine. If you need to use serious magic just to create a translation to another language, consider whether the user will enjoy the kata, or whether he will disdain the hideous abomination. Always remember to use your language's idiomatic code. And if someone proposes a translation to your kata and you think it's not really idiomatic, ask them.

## Consistency is key
However, in some cases, it's better to strife away from idiomatic code, especially if it makes the kata _a lot_ easier in the other language. It devalues the achievements of those who solved the harder version. In those cases make sure to block the library functions (see below).

But consistency should be taken in measurements. If this leads to completely unidiomatic code during your translation, consider creating a completely new kata instead.

## Stringly typed code is bad
Nothing to say about that. Unless it leads to convoluted code avert stringly types. _Please._

## Have complete tests
Tests are the bread and butter of Codewars. Without tests, you couldn't check whether the user has solved your kata, so they're damn important. Yet some neglect them.

### Always test all corner cases of your input domain
If you ask the user to create a function that should work for `1 <= N <=  1,000,000`, make sure that his function works for _both_ 1 and 1,000,000. If you specified that "negative input should return a monkey", make sure that you actually test negative input.

### Use random tests
Whenever when you state a kata, you have to write a solution. This is great, because when you write the tests, you can simply use exactly that function to check the users code. What's even better: it makes you think about the input domain. That's the hard part of creating random tests, sure; creating sufficient random input is most often harder than creating the kata itself. But it's worth every honor.

### Always have some example tests
Unless you're creating a puzzle where the user has to find _the answer_, present some example tests. Those tests should also contain the corner cases and some easy random tests, e.g. check that the user actually returns a number for arbitrary negative numbers.

### Handle floating point values the right way
Whenever the user returns a floating point number, make sure that you take floating point behaviour into account. The user might not add the numbers in the same order as you, and therefore end up with a slightly different number. Equality tests will always fail for that poor user.

Unless you want to write a kata were the user needs to round a floating point value to a certain precision, never ever tell the user to round, truncate, floor or ceil a floating point number. Instead, check the [_relative error_](https://en.wikipedia.org/wiki/Approximation_error). You might some time need to find a good epsilon, I usually use `1e-12` if I want to have something "almost exact" and `1e-7` if I want something "near-ish" the correct solution.