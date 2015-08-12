JavaScript / CoffeeScript
-------------------------

The JavaScript tests on CodeWars use a [custom] test framework. Any kata written
in CoffeeScript will use the same framework, since CoffeeScript gets compiled
to JavaScript.

Therefore, you won't find a section about CoffeeScript in this document. Also,
keep in mind that the current support of ES2015 is implemented via [Babel], so
you won't get the real source code if you use `.toString()`, but the result of
the Babel compiler.

 [custom]: http://www.codewars.com/docs/js-slash-coffeescript-test-reference
 [Babel]: https://babeljs.io/

### Floating point tests

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

### Random tests

Unlike Haskell, JavaScript doesn't provide an automatic framework like
QuickCheck, although there is an [implementation for
node](https://github.com/mcandre/node-quickcheck). Until the Codewars
platform provides an built-in way, you can use the following functions to
create random tests in JavaScript.

Note that both expect your solution to be pure (don't change the argument,
for example if it's an object or an array) and cannot check side-effects,
so you probably edit the functions for your needs. Also note that
`randomAssertSimilar` is rather verbose.

`generator` should return an array.

**NOTE:** The functions haven't been tested thoroughly. Use them with care
and feel free to create an issue or a pull-request if they contain any errors.

``` javascript
/**
 * @brief Tests a user defined function against a reference function.
 * @param generator generates random arguments (must return an array)
 * @param userSol is the solution provided by the user
 * @param refSol is the solution provided by the original kata author
 * @param tests is the number of tests (optional)
 *
 * The `refSol` should be pure, it shouldn't modify it's arguments,
 * since `userSol` will work on the same array afterwards.
 *
 * The values are compared via equality (===), and the number of
 * shown tests is limited to three.
*/
var randomAssertEquals = function(generator, userSol, refSol, tests){
  tests = tests || 100;
  var i = 0, user, reference, values;
  while( tests --> 0){
    values = generator();
    reference = refSol.apply(this, values);
    user      = userSol.apply(this,      values);
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
```

``` javascript
/**
 * @brief Tests a user defined function against a reference function.
 * @param generator generates random arguments (must return an array)
 * @param userSol is the solution provided by the user
 * @param refSol is the solution provided by the original kata author
 * @param tests is the number of tests (optional)
 *
 * The `refSol` should be pure, it shouldn't modify it's arguments,
 * since `userSol` will work on the same array afterwards.
 *
 * The values are compared via assertSimilar.
*/
var randomAssertSimilar = function(generator, userSol, refSol, tests){
  tests = tests || 100;
  var user, reference, values;
  while( tests --> 0){
    values = generator();
    reference = refSol.apply(this, values);
    user      = userSol.apply(this,      values);
    Test.assertSimilar(
      user, reference,
      "didn't work on the following argument array: " + values
    );
  }
}
```

### Test example

``` javascript
Test.describe("functionName1", function(){
  var solution = function(){
    // your solution
  };
  Test.it("should work for some simple examples", () => {
    Test.assertEquals(functionName1("abc"), "abc");
    Test.assertEquals(functionName1("xyz"), "xyz");
    Test.assertEquals(functionName1("")   , ""); // corner case
  });

  Test.it("should not return strings longer than 3 chars", () => {
    for(let i = 0; i < 100; ++i){
      const str = Test.randomToken();
      Test.expect(functionName1(str).length <= 3,
                  'returned more than 3 characters on' + str);
    }
  });

  Test.it("returns the correct string", () => {
    for(let i = 0; i < 100; ++i){
      const str = Test.randomToken();
      Test.assertEquals(
        functionName1(str),
        solution(str)
      );
    }
  });
});
```
