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
it still has `Assert.AreEqual`, `Assert.Greater` and others. But the
order of arguments is swapped.

Where CoffeeScript, Ruby, Python and Haskell expect the first argument of
`Test.assert_equals`/`Test.assertEquals`/`shouldBe` to be the actual value and
the second to be the expected, NUnit swaps the order, see the documentation of
[Assert]:

``` cs
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

Keep this in mind. Your tests won't fail on correct solutions if you swap the
arguments, but they __will__ confuse anyone who fails them. By the way, Java
uses the same convention. This isn't surprising, since NUnit was inspired by
JUnit.

 [Assert]: http://www.nunit.org/index.php?p=equalityAsserts&r=2.6.4

### Use descriptive test names
This was already addressed in the previous chapter, but it's rather important
in CSharp. NUnit doesn't give you any method to label a test. Instead, a test
is simply a public static method with a `[Test]` attribute inside a class with
the `[TestFixture]` attribute. The _name_ of your test is the method's name.

Make that name descriptive. A method called `test1` doesn't help. Name it after
the property you're testing, e.g. `ReturnsTrueOnEven`, or
`ThrowsExceptionOnNull`.

### Use `[TestCase]` to create parametrized tests
A test function doesn't have to be of type `void ...(void)`. You can use
parameters, which will be shown automatically. This is possible via the
[TestCase] attribute. It enables you to specify the arguments for a test
function. This works best if you use `TestCase` together with `Result`:

 [TestCase]: http://www.nunit.org/index.php?p=testCase&r=2.6.4

``` cs
[Test]
[TestCase(2, Result=true)]
[TestCase(4, Result=true)]
[TestCase(6, Result=true)]
[TestCase(-10, Result=true)]
public static bool ReturnsTrueOnEven(int n){
  return Evener.isEven(n);
}

[Test]
[TestCase(3, Result=false)]
[TestCase(5, Result=false)]
[TestCase(7, Result=false)]
[TestCase(-1, Result=false)]
public static bool ReturnsFalseOnOdd(int n){
  return Evener.isEven(n);
}
```
Unfortunately, `[TestCase]` does not report the used parameters on a failed
test. An alternative is to use `Assert.*` with a custom message:

``` cs
[Test]
[TestCase(3, false)]
[TestCase(5, false)]
[TestCase(7, false)]
[TestCase(-1, false)]
public static void ReturnsFalseOnOdd(int n, bool result){
  Assert.AreEqual(result, Evener.isEven(n),
    String.Format("Returned the wrong result on {}", n));
}
```

### Use `[Random]` for simple random values
The [Random] attribute can be used on arguments. This enables you to create
random integers or doubles within a range:

``` cs
[Test]
public static void RandomTests([Random(10, 500000, 100)] int n)) {
    Assert.AreEqual(PersistTests.Sol(n), Persist.Persistence(n));
}
```
This would draw random integers between 10 and 500000 (inclusive) and run a
total of 100 tests. Note that the drawbacks of `[TestCase]` also affect
`[Random]`, `NUnit` does not report the generated random values. Provide a
message if you want your users to know what arguments they didn't get right.

 [Random]: http://www.nunit.org/index.php?p=random&r=2.6.4

### Use `[Theory]` for a QuickCheck light experience
Haskell's QuickCheck enables you to test only certain combinations of random
values via `forAll`. That's also possible with [Theory] and `Assume`:

``` cs
[Theory]
public static void ReturnsTrueOnEven([Random(1, 50000, 100)] int n){
  Assume.That(n % 2 == 0);
  Assert.That(Evener.isEven(n));
}

[Theory]
public static void ReturnsFalseOnOdd([Random(1, 50000, 100)] int n){
  Assume.That(n % 2 == 1);
  Assert.That(! Evener.isEven(n));
}
```
However, this should be used with care. After all, NUnit will still check only
100 random values, and if they don't hold the assumption, the test case is
still completely executed but any failed assertion is disregarded. And yes, this
will also not report the used values.

 [Theory]: http://www.nunit.org/index.php?p=theory&r=2.6.4
