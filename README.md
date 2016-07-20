## About

An interpreter written in [Ruby](https://www.ruby-lang.org) for the imperative, stack based language called [Whitespace][1].

## Installation

Install it yourself using:

```bash
$ gem install whitespace-ruby
```

You would now have access to an executable called `whitespace`. Type

```bash
$ whitespace --help
```

to learn more.

## Usage

Let's say you've written a [Whitespace][1] program and stored it in the file `program.ws`. Then, to execute that program, type:

```bash
$ whitespace program.ws
```

This gem comes with example [Whitespace][1] programs that you can check out at [examples](/examples). Be sure to run them to see what they do.

For example, here's the [factorial program](/examples/fact.ws) and a sample execution (assuming you're in the examples directory):

```bash
$ whitespace fact.ws
Enter a number: 40
40! = 20397882081197443358640281739902897356800000000
```

## References

- [Whitespace tutorial](http://compsoc.dur.ac.uk/whitespace/tutorial.html)

## Credits

Thanks to Edwin Brady and Chris Morris for developing this programming language (also developers of the [Idris][2] programming language). I've had lots of fun playing with it and writing interpreters (in [Racket](https://github.com/dwayne/whitespace-racket), [Haskell](https://github.com/dwayne/whitespace-haskell) and now [Ruby](https://www.ruby-lang.org)) for it.

## Copyright

Copyright (c) 2016 Dwayne Crooks. See [LICENSE](/LICENSE.md) for further details.

[1]: https://en.wikipedia.org/wiki/Whitespace_\(programming_language\)
[2]: https://en.wikipedia.org/wiki/Idris_(programming_language)
