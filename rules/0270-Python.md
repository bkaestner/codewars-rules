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

### Disabling built-in functions

Python certainly does not make this task easy (his "cousin" Ruby in comparison is much, much more easy to deal with, thanks to the `undef` function), but there is some trick to permanently disable a function in your kata and avoid that a sneaky codewarrior can re-enable it again.

Following code template comes from electricjay, partially adapted to prevent the import of the `permutations` function from the `itertools` module.

```python
def crush_itertools_permutations():
  import __builtin__
  orig_import = __builtin__.__import__
  orig_reload = __builtin__.reload

  def disabled(*args):
    print "itertools.permutations has been disabled for this Kata"

  def filter_unwanted_imports(*args, **kwargs):
    if 'permutations' in args[0]:
      return disabled
    if 'imp' == args[0]:  # No legit reason to load this module in this Kata
      return None
    results = orig_import(*args, **kwargs)
    if hasattr(results, 'permutations'):
      results.permutations = disabled
    return results

  def filter_unwanted_reloads(*args, **kwargs):
    results = orig_reload(*args, **kwargs)
    if hasattr(results, 'permutations'):
      results.permutations = disabled
    if hasattr(results, 'reload'):
      results.reload = filter_unwanted_reloads
    if hasattr(results, '__import__'):
      results.__import__ = filter_unwanted_imports
    return results

  __builtin__.__import__ = filter_unwanted_imports
  __builtin__.reload = filter_unwanted_reloads

crush_itertools_permutations()
```

Notice that you can also prevent basic functions from working importing `__builtin__`; mathematical operators can be blocked with their alias, but not with their symbolic aliases - i.e.: you can prevent users from using `operators.__mod__` or `operators.mod`, but not from simply using `%`.

<!--- this is only a placeholder -->
