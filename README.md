# The conjured Codewars codex

This document contains some rules I've employed for my katas and my translation on [Codewars]. Some of them are very simple (e.g same arguments, same order), others are sometimes really hard to fulfill (random tests). But only rules aren't interesting. This document contains also some tips, so that you (or I) can implement them.

If you find an error, have a better idea, or think that all of this is a pile of unicorn misery, feel free to create an issue or a pull-request. Have a look at the LICENCE.

# General rules
Here we inspect some general rules which I try to follow. They are mostly language agnostic.

## A user solves a kata in a single language, not many
When your kata is out of beta, the typical user will solve it in his preferred language. He will either be fascinated and solve your kata multiple times (which is rather unlikely), or go on. Therefore, your kata should shine in that language.

However, this concludes that you may need to change return types in some circumstances or the input. For example, JavaScript, Python, Ruby and CoffeeScript allow a variable number of  arguments (JS, CS: `arguments`). C (without `varlist`), C++ (without variadic templates), Haskell, Java (without generics) and some other don't. Furthermore, some languages (like Haskell) don't allow list of heterogeneous types, which rules out some katas entirely.

And this is fine. If you need to use serious magic just to create a translation to another language, consider whether the user will enjoy the kata, or whether he will disdain the hideous abomination. Always remember to use your language's idiomatic code. And if someone proposes a translation to your kata and you think it's not really idiomatic, ask them.

## Consistency is key
However, in some cases, it's better to strife away from idiomatic code, especially if it makes the kata _a lot_ easier in the other language. It devalues the achievements of those who solved the harder version. In those cases make sure to block the library functions (see below).

But consistency should be taken in measurements. If this leads to completely unidiomatic code during your translation, consider creating a completely new kata insteaed.

## Stringly typed code is bad
Nothing to say about that. Unless it leads to convoluted code avert stringly types. _Please._

## Have complete tests
Tests are the bread and butter of Codewars. Without tests, you couldn't check whether the user has solved your kata, so they're damn important. Yet some neglect them.

### Always test all corner cases of your input domain
If you ask the user to create a function that should work for `1 <= N <=  1,000,000`, make sure that his function works for _both_ 1 and 1,000,000. If you specified that "negative input should return a monkey", make sure that you actually test negative input.

### Use random tests
Whenever when you state a kata, you have to write a solution. This is great, because when you write the tests, you can simply use exactly that function to check the users code. What's even better: it makes you think about the input domain. That's the hard part of creating random tests, sure; creating sufficient random input is most often harder than creating the kata itself. But it's worth every honor.

### Always have some example tests
Unless you're creating a puzzle where the user has to find _the answer_, present some example tests. Those tests should also contain the corner cases and some easy random tests, e.g. check that the user actually returns a number for arbitrary negative numbers.

# Language rules
Here are some language specific rules.

## Haskell
[Haskell](http://www.haskell.org) has been my main translation target on Codewars so far, so it's probably fair that I start with it. QuickCheck makes it rather easy to create random tests, and Hspec provides a very easy test framework.

### Tests
Codewars has QuickCheck, Hspec and HUnit installed. Unfortunately, it doesn't use a recent version of this libraries, but they're recent enough for most stuff you'll encounter.

#### HSpec 
Hspec's `describe` should be used with a _function name_, whereas `it` should be used with a sentence, so that `it "should be readable"`. There can be many tests per `it`, but depending on your input you might want to use one test per `it` or a test by hand in accordance with `expecationFailure` instead of `shouldBe`. You can also use HUnit, but I usually stay within Hspec's DSL.

#### QuickCheck
The QuickCheck DSL is a little bit too large to explain completely, but usually that's not necessary. If you want to use an arbitrary `Bool`, `Int` or anything else [from that list](http://hackage.haskell.org/package/QuickCheck-2.8.1/docs/Test-QuickCheck-Arbitrary.html#v:arbitrary), simply do so while wrapping your test with `property`:

```haskell
  it "should work for arbitrary integers" $ property $ \x ->
    2 * x `shouldBe` x * (2 :: Integer)
```
However, the instance of `Arbitrary` must be clear. Therefore, you might need to add some types as can be seen above.

What if you want to restrict the random elements on some domain? That's when you use `forAll` or `==>`. The first will generate only fitting values, the latter will discard values that don't fit:
```haskell
  it "should return true for even numbers" $ property $ 
    forAll (arbitrary `suchThat` even) $ \x ->
      solution x `shouldBe` True

  it "should return true for even numbers" $ property $ \x -> even x ==>    
      solution x `shouldBe` True
```
Beware! The latter variant might seem a lot easier, but if your domain is small, QuickCheck might give up. 

If you have several arguments which stem from different domains, use `forAll` per domain:

```haskell
  it "should return true if the first argument is a multiple of three and the second one a multiple of five" $ 
    property $ 
      forAll (fmap (3*) arbitrary) $ \three ->
      forAll (fmap (5*) arbitrary) $ \five ->
        isFizzBuzz three five `shouldBe` True
```
And yes, `Gen` is a `Functor`. You should use this to your advance.

#### Test template

```haskell
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

  describe "functionName2" $ do 
    -- … similar to above

 [Codewars]: http://www.codewars.com
