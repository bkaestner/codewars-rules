# Tested testing theories

Tests are the bread and butter of Codewars. Without tests, you couldn't
check whether the user has solved your kata, so they're very important. Yet
some neglect them.

Make sure to file an issue if you notice that a kata is lacking some tests.
This will prevent a moderator from approving the kata. This will increase the
overall quality of the approved katas. Also, as long as [#123] stands, one
cannot change the tests in approved katas with more than 500 solutions.

 [#123]: https://github.com/Codewars/codewars.com/issues/123


## Make your test descriptive

Let's have a look at the following test:

```javascript
Test.expect(fizzBuzz(15) === 'FizzBuzz', "Value not what's expected")
```
There are several things wrong with it. First of all, it uses `expect`. You
should __never__ use `expect` in any language, __unless__ there isn't a fitting
function in your test framework. But usually, there is a correct testing
function. Here, one would use `Test.assertEquals`, but it might vary, depending
on your language:

```javascript
Test.assertEquals(fizzBuzz(15), 'FizzBuzz', "Value not what's expected")
```

The additional message will be shown if the test failed. However, "Value not
what's expected" is useless. It doesn't give the user any hint what's gone
wrong:

```
  Expected: "FizzBuzz", actual: "Buzz". Value not what's expected.
```
Either drop the message in this case, or use a better one:

```javascript
Test.assertEquals(fizzBuzz(15), 'FizzBuzz', "testing on 15")
```
This tells the user immediately that their function failed on `15`.


### Group your tests

Furthermore, you should group your tests with `describe` and `it`. After all,
a tests _describes_ the behaviour of something, for example the behaviour
of `fizzBuzz`. _It_ should pass several specifications:

```javascript
Test.describe('fizzBuzz', function(){
  Test.it('should return "Fizz" on 3,6,9,12', function(){
    for(let i = 1; i <= 4; ++i)
      Test.assertEquals(fizzBuzz(3 * i), 'Fizz')
  });

  Test.it('should return "Buzz" on 5,10,20,25', function(){
    for(let i = 1; i <= 4; i += 3)
      Test.assertEquals(fizzBuzz(5 * i),       'Buzz')
      Test.assertEquals(fizzBuzz(5 * (i + 1)), 'Buzz')
  });

  Test.it('should return "FizzBuzz" on 15*n', function(){
    for(let i = 1; i <= 4; ++i)
      Test.assertEquals(fizzBuzz(15 * i), 'FizzBuzz')
  });
});
```
Note that not every language provides `describe` and `it`. Refer to your
language's test framework documentation to find out how to group tests there.

If you use `describe`, keep in mind that you _describe_ __one__ thing:

```javascript
Test.describe('bar', function(){
  Test.it('returns "bar"', function(){
    Test.assertEquals(bar(), "bar");
  });
});

Test.describe('foo', function(){
  Test.it('returns "foo"', function(){
    Test.assertEquals(foo(), "foo");
  });
});
```


### Make errors obvious

Especially if you use random tests (see below), you want to make sure that the
user knows _why_ the test failed. You could print the arguments. You could
show a hint. Either way, a user shouldn't be left alone in face of an error.


## Always test all corner cases of your input domain

If you ask the user to create a function that should work for
`1 <= N <=  1,000,000`, make sure that their function works for *both* 1 and
1,000,000. If you specified that "negative input should return a monkey",
make sure that you actually test negative input.


## Use the tools of your testing framework

If possible, try to use multiple kinds of assertions, e.g. `assertEquals`
and `assertNotEquals`, or `shouldSatisfy` and `shouldNotSatisfy`.  That
way, a cheating user will have some more work to circumvent equality or
predicate based tests.


## Use random tests

Whenever when you state a kata you also have to write a solution. This is
great, as you can use exactly that function to check the users code
in the tests. What's even better: it makes you think
about the input domain.

This is usually the hard part of creating random tests. After all, creating
sufficient random input is most often harder than creating the kata itself.
But it is worth every honour.


## Use __more__ random tests

While it's nice to have a random test which validates that the user returns
the same as your hidden solution, there's no guarantee that your solution
provides the _correct result_. If you provide a predicate that checks whether
the solution makes sense, you can use it in both the hidden _and_ public tests.

For example, if `foo` should always return `false` on negative
inputs, add the following test:

```javascript
Test.it('should return false for negative numbers', function(){
  for (let i = 0; i < 100; ++i) {
    Test.assertEquals(foo(-Math.random() * 1000000), false);
  }
});
```

This prevents both you and the user to forget about those inputs. Generally
this pattern will look like this:

```javascript
Test.it('returns something valid', function(){
  for (let i = 0; i < 100; ++i) {
    var some   = ...
    var random = ...
    var args   = ...
    Test.expect(
      isValid(foo(some, random, args)),
      "predicate failed, invalid answer returned"
    );
  }
});
```


## Hide your solution

If you use random tests, make sure to hide your solution. In Java or C#, this
includes making your function `private`. Haskell doesn't allow mutual imports,
so the user cannot import the tests either way. However, in dynamic languages,
one can sometimes simply use `solve = solution`.

You can prevent this kind of cheating if you

- add static tests (not only random ones),
- move your solution into a local scope.

The first one is obvious. The second one can be realized if you don't provide
a `solution` with the same interface, but instead a `testAgainstSolution`:

```javascript
// bad!
var solution = function(a, b){
  // ...
}

// better
var testFunction = function(a,b){
  var solution = function(a, b) {
    // ...
  }
  Test.assertEquals(userFunc(a,b), solution(a,b));
}
```
There are more creative ways to hide/store the function, but that's one way
at least. Note that all dynamic languages on Codewars (Ruby, Python, CS, JS)
support this kind of local scopes.

## Always have some example tests

Unless you're creating a puzzle where the user has to find *the answer*,
present some example tests. Those tests should also contain the corner
cases and some easy random tests, e.g. check that the user actually returns
a number for arbitrary negative numbers.

## Handle floating point values the right way

Whenever the user returns a floating point number, make sure that you take
floating point behaviour into account. The user might not add the numbers
in the same order as you, and therefore end up with a slightly different
number. Equality tests will always fail for that poor user.

Unless you want to write a kata were the user needs to round a floating
point value to a certain precision, never ever tell the user to round up/down
or truncate a floating point number. Instead, check the
[*relative error*](https://en.wikipedia.org/wiki/Approximation_error). You
might some time need to find a good epsilon, I usually use `1e-12` if I
want to have something "almost exact" and `1e-7` if I want something
"near-ish" the correct solution.

For more information about floating-point arithmetic, read
[What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html).

### An example of floating point dangers

```python
def add_three(a,b,c):
    return a + b + c

def add_three_reference(a,b,c):
    return a + (b + c)

print(add_three_reference(1e-12,1e-12,1) == add_three(1e-12,1e-12,1))
# False
```

### Relative error testing

The following example shows one way to check floating point values in a more
sane way:

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

Most language sections contain their equivalent and use `expect` or a similar
function of their test framework.

### Consider integral tests

If your number is guaranteed to be an integral number, use `int`, `long`
or your language's equivalent instead of floating point numbers. However, keep
in mind that all values, either input, output, or intermediate should fit in
this type, otherwise you might encounter overflow or underflow issues.

## Fix broken tests early and fix them right

While [#163](https://github.com/Codewars/codewars.com/issues/163) will give you
the tools to fix a kata even late, you should take every reported test issue by
heart. If the tests are failing for some only, check whether your current
example tests contain enough corner cases. Ask them for their code
(in spoilers).

There are several ways your tests can be wrong. For examples, your tests can be
too strict. This is usually the case with floating points, where one expects the
user to do things in a certain way.

However, sometimes your reference implementation &ndash; the solution the users
try to write &ndash; is wrong. People have now adjusted their submitted
functions to yours, so that they still solve the kata, even though their logic
is broken. If you now fix your reference solution, the results of many users
might get rejected.

So what can you do?

### Change description to address the bug
You should definitely tell your users if your kata is broken. Especially if your
tests have a defect in only one particular language. It's not the best you can
do, but as long as #163 is still there, it might be the only thing you can do.

### Reject old solutions, they didn't follow the description
This is fine as long as there haven't been many solutions. If your kata has been
solved by hundreds, it might seem a little bit unfair, but correct tests are
a little bit more important.

### Experimental solutions
There are also other alternatives:

- check the time: if the kata solution is submitted after a certain point in
time, use the new tests, otherwise the old. This can lead to problems with
the anti-cheat measurements.
- test against both results: this basically duplicates all your tests, which
  can be hard to maintain if you do it wrong.

Either way, fix them, otherwise it will lead to submitted issues and therefore
to negative honour.
