# OCR Kata

This is my solution for the OCR kata exercise as defined by PROMPT.md.

I wasn't able to get all the way through all four user stories in a reasonable amount of time, and since I knew I was
running out of time, I rushed my way through number three. As such, the logic to generate the results report is untested
as of this writing, although most of the important units underlying that logic are tested.

From the outset, knowing I was under some time pressure, I wanted to do my best to balance quality of work, code
performance, and making good progress on the problem. The way this application came together - from separation of
concerns to the names of each individual unit - was for the most part a thoughtfully-forward-only process, meaning that
I spent a little more time thinking about how to structure things as I went, knowing I probably wasn't going to have the
time to go back and refactor / restructure things based on what I learned along the way. That said, although I would
probably make some slight changes to unit boundaries if I had more time to do it over again and I would harden the test
coverage a little around the edge-cases, I'm pretty happy with the way everything turned out! I hope you enjoy reviewing
and testing my solution as much as I did writing it!

## Getting set up

**You'll need Ruby**

First, you'll need to have a recent version of Ruby installed, which should include the `gem` Rubygems executable. I
used Ruby version 2.5.3 to build, test, and run this project.

**Then you'll want to bundle**

This should do the trick:

```shell
$ gem install bundler
$ bundle install
```

**Now, you should be set to run the tests**

You should see a bunch of lovely green dots when you run the following:

```shell
$ bundle exec rake
```

## Exercising the code

In the `doc` directory lives a file called `example_account_numbers.txt`. This file has a bunch of valid account
numbers, a couple of unreadable numbers, several with invalid checksums, and one number that's too short to use. You can
validate the contents of this file with:

```shell
$ bundle exec rake validate_account_numbers_file
```

...and you should see some output that looks something like:

```plain
950322520
599548576
684819309
461370352
10164443  ILL
40246431? ILL
648726508 ERR
```

That same rake task can be used to **validate your own file** by specifying a path to an alternate file (replace
`<path>` in the following with the path to your own file):

```shell
$ ACCOUNT_NUMBERS_FILE=<path> bundle exec rake validate_account_numbers_file
```

Just for funsies, if you want to generate a brand new file and modify it manually, you can use the following rake task
(WARNING: this will overwrite the existing example file in the doc directory):

```shell
$ bundle exec rake generate_account_numbers_file
```
