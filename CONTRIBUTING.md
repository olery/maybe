# Contributing

Everybody is more than welcome to contribute to this project, no matter how
small the change. To keep everything running smoothly there are a few guidelines
that one should follow. These are as following:

* When changing code make sure to write RSpec tests for the changes.
* Document code using YARD. At the very least the method arguments and return
  value(s) should be documented.
* Wrap lines at 80 characters per line.
* Git commits should have a <= 50 character summary, optionally followed by a
  blank line and a more in depth description of 72 characters per line.

## Editor Setup

Whatever editor you use doesn't matter as long as it can do two things:

* Use spaces for indentation.
* Hard wrap lines at 80 characters per line.

To make this process easier this project comes with an
[EditorConfig][editorconfig] configuration file. If your editor supports this it
will automatically apply the required settings for you.

## Hacking Guide

Assuming you have a local Git clone of this project, the first step should be to
install all the required Gems:

    bundle install

Running the tests is as simple as running `rake` (or `rspec spec`).

For more information about the available tasks, run `rake -T`.

## Legal

By contributing to this project you agree with both the Developer's Certificate
of origin, found in `doc/DCO.md` and the license, found in `LICENSE`. This
applies to all content in this repository unless stated otherwise.

[editorconfig]: http://editorconfig.org/
