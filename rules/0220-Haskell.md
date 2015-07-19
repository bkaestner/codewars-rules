Haskell
-------

[Haskell](http://www.haskell.org) has been my main translation target on
Codewars so far, so it's probably fair that I start with it. QuickCheck
makes it rather easy to create random tests, and Hspec provides a very easy
test framework.

### Tests

Codewars has QuickCheck, Hspec and HUnit installed. Unfortunately, it
doesn't use a recent version of this libraries, but they're recent enough
for most stuff you'll encounter.

#### Use Hspec with enough information for the user

Hspec's `describe` should be used with a *function name*, whereas `it`
should be used with a sentence, so that `it "should be readable"`. There
can be many tests per `it`, but depending on your input you might want to
use one test per `it` or a test by hand in accordance with
`expecationFailure` instead of `shouldBe`. You can also use HUnit, but I
usually stay within Hspec's DSL.

#### Floating point tests

As written above, one shouldn't use `shouldBe` on floating point values,
since the user might use another order of addition, and adding floating
point numbers isn't associative. Therefore, you should plan a little
threshold.

Hspec doesn't have such an operator, but you can easily write one yourself:

``` haskell
import Control.Monad (when)

shouldBeFuzzy :: (Fractional a, Ord a) => a -> a -> Expectation
shouldBeFuzzy actual expected =
  when (abs ((actual - expected) / expected) >= 1e-12) $ do
    expectationFailure $ "Expected " ++ show expected ++ ", but got " ++ show actual
```

Alternatively, if you don't want to import `Control.Monad`, you can use

``` haskell
shouldBeFuzzy :: (Fractional a, Ord a) => a -> a -> Expectation
shouldBeFuzzy actual expected =
  if (abs ((actual - expected) / expected) >= 1e-12)
    then expectationFailure $ "Expected " ++ show expected ++ ", but got " ++ show actual
    else return ()
```

#### Use QuickCheck's `forAll` to constraint random values

The QuickCheck DSL is a little bit too large to explain completely, but
usually that's not necessary. If you want to use an arbitrary `Bool`, `Int`
or anything else [from that
list](http://hackage.haskell.org/package/QuickCheck-2.8.1/docs/Test-QuickCheck-Arbitrary.html#v:arbitrary),
simply do so while wrapping your test with `property`:

``` haskell
  it "should work for arbitrary integers" $ property $ \x ->
    2 * x `shouldBe` x * (2 :: Integer)
```

However, the instance of `Arbitrary` must be clear. Therefore, you might
need to add some types as can be seen above.

What if you want to restrict the random elements on some domain? That's
when you use `forAll` or `==>`. The first will generate only fitting
values, the latter will discard values that don't fit:

``` haskell
  it "should return true for even numbers" $ property $
    forAll (arbitrary `suchThat` even) $ \x ->
      solution x `shouldBe` True

  it "should return true for even numbers" $ property $ \x -> even x ==>
      solution x `shouldBe` True
```

Beware! The latter variant might seem a lot easier, but if your domain is
small, QuickCheck might give up.

If you have several arguments which stem from different domains, use
`forAll` per domain:

``` haskell
  it "should return true if the first argument is a multiple of three and the second one a multiple of five" $
    property $
      forAll (fmap (3*) arbitrary) $ \three ->
      forAll (fmap (5*) arbitrary) $ \five ->
        isFizzBuzz three five `shouldBe` True
```

And yes, `Gen` is a `Functor`. You should use this to your advance.

#### Always import only the expected functions, and use `qualified` if necessary

To prevent name clashes, only import what you need from the user module.
This enables the user to define additional helpers at global namespace.

#### Test template

``` haskell
module Codewars.MyPrefix.KataName.Test where
import Codewars.MyPrefix.KataName (functionName1, functionName2, …)
import Test.Hspec
import Test.QuickCheck
import Module.That.Solves.The.Kata -- e.g. Data.List, Data.Char, sometimes qualified
import Text.Printf (printf) -- if you need to use printf

main = hspec $ do
  describe "functionName1" $ do

    -- multiple tests per it; only reports expected vs actual
    it "should work for some simple examples" $ do
      functionName1 "abc" `shouldBe` "abc"
      functionName1 "xyz" `shouldBe` "xyz"
      functionName1 ""    `shouldBe` "" -- corner case

    -- multiple tests per it; hand written failure message
    it "should work for some other examples" $ do
      let test input result = let actual = functionName1 input
                              in if actual /= result
                                then expectationFailure $ printf "expected \"%s\" on input \"%s\", but got \"%s\"" result input actual
                                else return ()
      test "def" "def"
      test "123" ""

    it "shouldn't change letter-only strings" $ property $
      forAll (listOf $ elements $ ['a'..'z'] ++ ['A'..'Z']) $ \xs ->
        functionName1 xs `shouldBe` xs

    it "should return the right result" $ property $ \xs ->
      functionName1 xs `shouldBe` solution1 xs

  describe "functionName2" $ do
    -- … similar to above
```
