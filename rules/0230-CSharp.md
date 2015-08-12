## CSharp
CSharp is the only language that doesn't have a proper documentation on Codewars
currently. This will probably change at some point. The test framework is
[NUnit](http://www.nunit.org/), initially a port from JUnit. It's rather large,
so we cannot cover [everything][Nunit doc] here, but at least some points
should be addressed.

*Note:* C# looks rather ugly in the generated PDF, so I'm going to refer to it
as _CSharp_ instead.

 [Nunit doc]: http://www.nunit.org/index.php?p=docHome&r=2.6.4

### Beware of the assert arguments!
NUnit differs from the other frameworks. Very. Much. Well, overall it doesn't,
it still has it's `Assert.AreEqual` and `Assert.Greater` and others. __But__ the
order of arguments is swapped.

Where CoffeeScript, Ruby, Python and Haskell expect the first argument of
`Test.assert_equals`/`Test.assertEquals`/`shouldBe` to be the actual value and
the second to be the expected, NUnit swaps the order, see the documentation of
[Assert]:

``` charp
Assert.AreEqual( int expected, int actual );
Assert.AreEqual( int expected, int actual, string message );
Assert.AreEqual( int expected, int actual, string message,
                 params object[] parms );
// many other
```

For comparison, here's the syntax of an equality assert in the other languages:

``` haskell
-- Haskell
actual `shouldBe` expected
```
``` javascript
// Javascript
Test.assertEquals(actual, expected, message);
```
``` python
# Python
Test.assert_equals(actual, expected, message)
```
``` ruby
# Ruby
Test.assert_equals(actual, expected, message)
```

Keep this in mind. Your tests won't fail if your swap the arguments, but they
__will__ confuse anyone who fails to pass your assertion.

 [Assert]: http://www.nunit.org/index.php?p=equalityAsserts&r=2.6.4

