Collaborative Codewars Catches
------------------------------

The previous section mentioned some practices for your tests. However,
what if you don't know Haskell? Or Java? Or Ruby? You shouldn't provide
tests for a language you don't know, as this will usually lead to bugs
in your test cases (see section
"A user solves a kata in a single language, not many").

That's where translations and collaboration kick in.

### Accepting a translation

Let's stay in the mentioned scenario for a while. You wrote a  kata,
it's currently in beta, and suddenly, you get a notification that someone
provided a translation. So where can you find that translation?

Go to your kata and have a look at the language icon bar. There's a "+"
next to the language icons. Click on it to see the current list of translations.
Here you get a quick overview of all translations. To see them in detail and
approve, decline or fork them, click on the translation's title.

Now you can see their tests (both example and hidden), solution (both
hidden and initial), and the description. There are several things
you want to check before accepting a translation:

- is the kata as hard as in you original languages?
    - does it use the same or comparable tests?
    - does it use the same or comparable input/output types?
- does the description provide some examples in that language?
- do the description changes break your description style?

Those are basically questions that follow from the rules
"Consistency is key" and "A user solves a kata in a single language, not many".

If all questions above can be answered with yes, you can approve the
translation. If one or more questions were answered with no, write a comment on
the translation. Discuss your concerns with the translator until both of you are
happy. If you don't think that the translation is salvageable, decline it.

### Handling merge conflicts
A translation basically copies the description at the time one has started
writing the translation. If the kata's description changes before the translation
got approved, the variants often cannot get merged together. This is called
a *merge conflict*. (By the way, Codewars uses a [3-way merge](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge)).

Either the translator or the kata author has to *fork* the translation, fix the
merge conflict by hand, and publish the translation again.

### Writing a translation

Now you found a kata in JavaScript. You liked it, and want to translate it into
Python. There should be a "+" sign next to the language icons after you solved
it. Click on it and you'll land on the list of current translations. After
you've checked that there isn't a pending translation in Python, you click on
"Translate this kata".

This will open translation kumite editor. Choose the language in the drop-down
menu before you write any code. Then fill the (initial) solution and
(example) tests. Save your progress often to prevent data loss. Whenever you're
ready, publish your translation.
