Haskell
-------

[Haskell](http://www.haskell.org) has been my main translation target on
Codewars so far, so it's probably the one I know most. [QuickCheck] makes it
tremendously easy to create random tests, and Hspec provides a very convenient
test framework.

Codewars has QuickCheck, [Hspec] and [HUnit] installed. Unfortunately, it
doesn't use a recent version of this libraries, but they're recent enough
for most stuff you'll encounter.

 [QuickCheck]: http://hackage.haskell.org/package/QuickCheck
 [Hspec]: http://hackage.haskell.org/package/hspec/
 [HUnit]: http://hackage.haskell.org/package/HUnit/

### Use Hspec with enough information for the user

Hspec's `describe` should be used with a *function name*, whereas `it`
should be used with a sentence, so that `it "should be readable"`. There
can be many tests per `it`, but depending on your input you might want to
use one test per `it` or a test by hand in accordance with
`expecationFailure` instead of `shouldBe`. You can also use HUnit, but I
usually stay within Hspec's DSL.

### Floating point tests

As written above, one shouldn't use `shouldBe` on floating point values,
since the user might use another order of addition, and adding floating
point numbers isn't associative. Therefore, you should plan a little
threshold.

Hspec doesn't have such an operator, but you can easily write one yourself:

``` haskell
import Control.Monad (when)

shouldBeFuzzy :: (Fractional a, Ord a) => a -> a -> Expectation
shouldBeFuzzy a e =
    when (abs ((a - e) / e) >= 1e-12) $ expectationFailure msg
  where msg = "Expected " ++ show e ++ ", but got " ++ show a
```

Alternatively, if you don't want to import `Control.Monad`, you can use

``` haskell
shouldBeFuzzy :: (Fractional a, Ord a) => a -> a -> Expectation
shouldBeFuzzy a e =
    if cond
      then expectationFailure msg
      else return ()
  where
    msg = "Expected " ++ show a ++ ", but got " ++ show e
    cond
      | e == 0    = abs a >= 1e-12
      | otherwise = (abs $ (a - e) / e) >= 1e-12
```

### Use QuickCheck's `forAll` to constraint random values

The QuickCheck DSL is a little bit too large to explain completely, but
usually that's not necessary. If you want to use an arbitrary `Bool`, `Int`
or anything else [from that list][q-arb], simply do so while wrapping
your test with `property`:

 [q-arb]: http://hackage.haskell.org/package/QuickCheck-2.8.1/docs/Test-QuickCheck-Arbitrary.html#v:arbitrary

``` haskell
  it "should work for arbitrary integers" $ property $ \x ->
    2 * x `shouldBe` x * (2 :: Integer)
```

However, the instance of `Arbitrary` must be clear. Therefore, you might
need to add some types as can be seen above.

What if you want to restrict the random elements on some domain? That's
when you use `forAll` or `==>`. The first will generate only fitting
values (if you use it correctly), the latter will discard values that don't fit:

``` haskell
  it "should return true for even numbers" $ property $
    forAll (arbitrary `suchThat` even) $ \x ->
      solution x `shouldBe` True

  it "should return true for even numbers" $ property $ \x -> even x ==>
      solution x `shouldBe` True
```

Beware! The latter variant might seem a lot easier, but if your domain is
small, QuickCheck might give up. Note that this will also happen in the first
case. If you want to generate a value, it's often better to generate an
arbitrary value and then `fmap`, e.g. `forAll (fmap (2*) arbitrary)`.

If you have several arguments which stem from different domains, use
`forAll` per domain:

``` haskell
  it "returns true on (3*n) (5*k)" $
    property $
      forAll (fmap (3*) arbitrary) $ \three ->
      forAll (fmap (5*) arbitrary) $ \five ->
        isFizzBuzz three five `shouldBe` True
```
You could also multiply the values later, but that will change the error message
QuickCheck returns:

```haskell
  it "returns true on even values" $
    forAll (arbitrary) $ \x ->
      -- bad, prints `x`, not `2 * x`
      isEven (2 * x) `shouldBe` True

  it "returns true on even values" $
    forAll (fmap (2*) arbitrary) $ \x ->
      -- better, still prints x, but after
      -- the application of (2*)
      isEven x `shouldBe` True
```

### Always import only the expected functions

To prevent name clashes, only import what you need from the user module.
This enables the user to define additional helpers at global namespace.

### Test example

``` haskell
module Codewars.MyPrefix.KataName.Test where
import Codewars.MyPrefix.KataName (functionName1, functionName2, ...)
import Test.Hspec
import Test.QuickCheck

-- Solving modules, e.g. Data.List, Data.Char, sometimes qualified:
import Module.That.Solves.The.Kata
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
      let test i r = if a /= r
                      then expectationFailure $ p
                      else return ()
            where
              a = functionName1 i
              p = concat ["expected ", show r, " on "
                         , show i, " but got ", show a
                         ]

      test "def" "def"
      test "123" ""

    it "shouldn't change letter-only strings" $ property $
      forAll (listOf $ elements $ ['a'..'z'] ++ ['A'..'Z']) $ \xs ->
        functionName1 xs `shouldBe` xs

    it "should return the right result" $ property $ \xs ->
      functionName1 xs `shouldBe` solution1 xs

  describe "functionName2" $ do
    -- ... similar to above
```
