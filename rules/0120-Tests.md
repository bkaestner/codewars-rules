Tested testing theories
------------------------

Tests are the bread and butter of Codewars. Without tests, you couldn't
check whether the user has solved your kata, so they're very important. Yet
some neglect them.

Make sure to file an issue if you notice that a kata is lacking some tests.
This will prevent a moderator from approving the kata. This will increase the
overall quality of the approved katas. Also, as long as [#123] stands, one
cannot change the tests in approved katas with more than 500 solutions.

 [#123]: https://github.com/Codewars/codewars.com/issues/123



### Always test all corner cases of your input domain

If you ask the user to create a function that should work for
`1 <= N <=  1,000,000`, make sure that their function works for *both* 1 and
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
