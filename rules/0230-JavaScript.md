JavaScript
----------

*This section is under construction. Beware of the dragon, ye who enter his
lair*.

### Snippets

#### Floating point tests

As written above, one shouldn't use `assertEquals` on floating point
values, since the user might use another order of addition, and adding
floating point numbers isn't associative:

``` javascript
console.log("Is + associative in JS on double values?")
console.log(1 + (1e-12 + 3e-12) === (1 + 1e-12) + 3e-12)

console.log("    :(    ")
```

Therefore, you should plan a little threshold.

ES6 provides `Number.EPSILON`, but that's actually a little bit too low for
most cases. I usually use `1e-12`, which is *good enough*, or `1e-6` if the
kata is about approximative results. Just change the value below to
whatever you feel is best. Just keep in mind that any value lower than
`Math.min(1e-15,Number.EPSILON)` is bogus.

``` javascript
var assertFuzzyEquals = function(actual, expected, msg){
    var inrange = Math.abs((actual - expected) / expected) <= 1e-12;
    Test.expect(inrange,
      msg || "Expected value near " + expected.toExponential(13) +
             ", but got " + actual.toExponential(13)
    );
}
```

#### Random tests

Unlike Haskell, JavaScript doesn't provide an automatic framework like
QuickCheck, although there is an [implementation for
node](https://github.com/mcandre/node-quickcheck). Until the Codewars
plattform provides an built-in way, you can use the following functions to
create random tests in JavaScript.

Note that both expect your solution to be pure (don't change the argument,
for example if it's an object or an array) and cannot check side-effects,
so you probably edit the functions for your needs. Also note that
`randomAssertSimilar` is rather verbose.

`generator` should return an array.

**NOTE:** The functions haven't been tested thoroughly. Use them with care
and feel free to edit them if they contain any errors.

``` javascript
/**
 * @brief Tests a user defined function against a reference function.
 * @param generator generates random arguments, it must return an array
 * @param userSolution is the solution provided by the user
 * @param refSolution is the solution provided by the original kata author
 * @param tests is the number of tests (optional)
 *
 * The `refSolution` should be pure, it shouldn't modify it's arguments,
 * since `userSolution` will work on the same array afterwards.
 *
 * The values are compared via equality (===), and the number of shown tests is
 * limited to three.
*/
var randomAssertEquals = function(generator, userSolution, refSolution, tests){
  tests = tests || 100;
  var i = 0, user, reference, values;
  while( tests --> 0){
    values = generator();
    reference = refSolution.apply(this, values);
    user      = userSolution.apply(this,      values);
    if(i++ < 3){
      Test.assertEquals(
        user, reference,
        "didn't work on the following argument array: " + values
      );
    } else if(reference !== user){
      Test.assertEquals(
        user, reference,
        "didn't work on the following argument array: " + values
      );
    }
  }
}

/**
 * @brief Tests a user defined function against a reference function.
 * @param generator generates random arguments, it must return an array
 * @param userSolution is the solution provided by the user
 * @param refSolution is the solution provided by the original kata author
 * @param tests is the number of tests (optional)
 *
 * The `refSolution` should be pure, it shouldn't modify it's arguments,
 * since `userSolution` will work on the same array afterwards.
 *
 * The values are compared via assertSimilar.
*/
var randomAssertSimilar = function(generator, userSolution, refSolution, tests){
  tests = tests || 100;
  var user, reference, values;
  while( tests --> 0){
    values = generator();
    reference = refSolution.apply(this, values);
    user      = userSolution.apply(this,      values);
    Test.assertSimilar(
      user, reference, 
      "didn't work on the following argument array: " + values
    );
  }
}
```
