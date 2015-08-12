### What is an "Unknown Error"?

Sometimes, you will encounter an "Unknown error". The complete error message is

> Tests didn't pass: Unknown error.

However, this error message is usually misleading. Most important: the error
isn't affiliated with your code. Instead, the test framework didn't actually
run.

You will also encounter the error on __empty tests__. Some katas don't provide
example test cases. <kbd>Run</kbd> won't work in those circumstances, since
there are no tests to run. Instead, press <kbd>Submit</kbd> on those katas.

Another workaround that works *sometimes* is `submit -> reload -> submit`.
However, this doesn't work all the time.
