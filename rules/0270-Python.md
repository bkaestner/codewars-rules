Python
------

***Sorry.*** This section does not contain any helpful information currently.
Instead, have a look at the following PEPs:

- [PEP 0008 -- Style Guide for Python Code][python-pep8]
- [PEP 20 -- The Zen of Python][python-pep20]

If you have some ideas for this section, head over to [GitHub][GH-python-issue].

[python-pep8]: https://www.python.org/dev/peps/pep-0008/ "Style Guide for Python Code"
[python-pep20]: https://www.python.org/dev/peps/pep-0020/ "The Zen of Python"
[GH-python-issue]: https://github.com/bkaestner/codewars-rules/issues/7


### Floating point tests

As written above, one shouldn't use `assert_equals` on floating point
values, since the user might use another order of addition, and adding
floating point numbers isn't associative:

``` python
print ("Is + associative in Python on double values?")
print (1 + (1e-12 + 3e-12) == (1 + 1e-12) + 3e-12)

print ("    :(    ")
```

Therefore, you should plan a little threshold. I usually use `1e-12`,
which is most often good enough, or `1e-6` if the kata is about
approximative results. Just change the value below to whatever you
feel is best. Keep in mind that any value lower than `1e-15` is bogus.

``` python
def assertFuzzyEquals(actual, expected, msg=""):
    import math

    # max error
    merr = 1e-12

    if expected == 0:
        inrange = math.fabs(actual) <= merr
    else:
        inrange = math.fabs((actual - expected) / expected) <= merr

    if msg == "":
        msg = "Expected value near {:.12f}, but got {:.12f}"
        msg = msg.format(expected, actual)

    return Test.expect(inrange, msg)
```

<!--- this is only a placeholder -->
