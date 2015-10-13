### What does "Submission timed out" mean?

Once in a while, you can encounter the following error:

> Submission timed out. Please try again.

#### What does this mean?

First of all, don't worry. This doesn't mean that your code is wrong.
However, it doesn't mean that your code is correct either. Instead, your
code wasn't even tested. The very process of *submitting the code* timed
out. This can happen under heavy load, if all worker pools are exhausted,
all queues are full, or some other behind the scenes detail gave up.

The actual source of the problem [isn't fully known yet][issue-18].
Sometimes, it's background jobs not processing items from the job queue.
Sometimes, it's another, completely unrelated process on the same machine,
that takes too much resources from a Codewars virtual machine.

#### What should I do?

First of all, relax. Even if the submission timed out, your code is usually
saved. However, you can copy your code into your clipboard and reload the
kata submission page in order to check this: if the code is still there,
you can come back later. If it isn't, paste it and try to submit it again
&ndash; maybe it was just a lost server connection and you can go on.

**If the problem persists** you can notify Jake or at least report the
incident in [the aforementioned issue topic (#18)][issue-18]. You can
also check [the status page](http://status.codewars.com). Note that the status
page isn't always accurate. Also have a look at the dashboard. People usually
post issues or comments about "submission timed out" if this happens.

Again, this error doesn't solely happen to you, and it doesn't have
anything to do with your code. Please do not comment on katas in this case,
as "Submission timed out" comments clutter the comment page, and the kata
author can't do anything to fix this error.

#### Huh? It says now "Process took more than 6000ms", did they change the message?

That, on the other hand, *is* a code related error. It means that *your
code* wasn't able to perform the necessary operations in the given time.
The time limit varies between languages, but it's usually \~6s. Therefore,
this is an error you *can* fix. You need to perform optimizations on your
code. This includes memoization, dynamic programming or even better
algorithms and depends on the kata. If you get stuck, submit a comment on
the specific kata and mark it as "Question".

#### Can I get a TL;DR?

Sure.

  Error message         |Interpretation / meaning
  ----------------------|-------------------------------------------------------
  Submission timed out  |The Codewars platform has some problems. Try again later. \
                         Your code wasn't checked.
  Process timed out     |Your code is to slow and has exceeded the time limit. \
                         Try another approach, algorithm, or optimize.

[issue-18]: https://github.com/Codewars/codewars.com/issues/18 "Issue #18: Submission Timeouts / Poor messaging"
