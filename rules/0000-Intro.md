---
title: The conjured Codewars codex
author: Benjamin Kästner
language: english
documentclass: scrreprt
links-as-notes: true
toc: true
abstract: |
  This document contains some rules I have employed for my katas and my
  translation on [Codewars](http://www.codewars.com). Some of them are very
  simple (e.g same arguments, same order), others are sometimes really hard
  to fulfill (random tests). This document contains also some tips, so that you
  (or I) can implement them.
---

Preface
=======

When I started using Codewars, there were only a handful of Haskell warriors,
and Haskell support was only recent. While I was eager to solve the Haskell
katas, there weren't many of them, so I started translating. I've translated
about 23% of my solved katas, either to Haskell or to another language.

And while Codewars provides
[some documentation](http://www.codewars.com/docs/kata-creator), I often ended
up answering the same questions in the comments

- "Why no strings?"
- "Why random tests?"
- "How do I write those random tests?"

To prevent repeating myself over and over again, and to have some kind of
reference for some nifty tricks, I've started writing this "guide". And while
its [GitHub repository](https://github.com/bkaes/codewars-rules) is called
"codewars-rules", it's meant as a light-hearted lecture for the interested
reader.

Therefore, it's dismissed as "The conjured Codewars codex". What can I say, I
like arbitrary alliterations. The repository's description is a reference on
`QuickCheck`'s `Arbitrary`.

About the word "rules"
----------------------

You've read the previous section and therefore know that "rules" are more or
less meant as "tips and tricks". But to make this a little bit more distinct,
let's quote a (fictitious) pirate:

> [T]he code is more what you'd call "guidelines" than actual rules.
>
> -- Barbossa in "Pirates of the Caribbean: The Curse of the Black Pearl"

This also means that whenever you read the word "rules" in this document, you
can simply substitute it by "tips" or "guidelines". Heave ho!


Contributing
------------

If you find an error, have a better idea, or think that all of this is a
pile of unicorn misery, feel free to create an issue or a pull-request.
Have a look at the LICENCE.

Contributors
------------
*Note: This section might change or will be moved to another section in a later
version*.

Please check the GitHub pages for contributors. While some contributed code, one
should not forget those who provided feedback via GitHub issues, so check them
too.

Copyright
---------
&copy; 2015 Benjamin Kästner. This document is licenced under the [Creative
Commons Attribution-ShareAlike 4.0 International Public License][CC-BY-SA].
Additionally, all code fragments used throughout the document are licenced
under the [Unlicense](http://unlicense.org/) and can be used without
attribution, UNLESS stated otherwise.

 [CC-BY-SA]: http://creativecommons.org/licenses/by-sa/4.0/.
