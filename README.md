## ReactiveExtensions
[![Gem Version](https://badge.fury.io/rb/reactive_extensions.svg)](http://badge.fury.io/rb/reactive_extensions) [![Build Status](https://travis-ci.org/danascheider/reactive_extensions.svg?branch=master)](https://travis-ci.org/danascheider/reactive_extensions) [![Coverage Status](https://img.shields.io/coveralls/danascheider/reactive_extensions.svg)](https://coveralls.io/r/danascheider/reactive_extensions) [![Code Climate](https://codeclimate.com/github/danascheider/reactive_extensions/badges/gpa.svg)](https://codeclimate.com/github/danascheider/reactive_extensions) [![Inline docs](http://inch-ci.org/github/danascheider/reactive_extensions.svg?branch=master)](http://inch-ci.org/github/danascheider/reactive_extensions)

The ReactiveExtensions gem adds a variety of useful methods into core Ruby classes
in the spirit of [ActiveSupport](https://github.com/rails/activesupport). This gem can 
be used in any kind of project and is not dependent on any frameworks, gemsets, etc.
Its only runtime dependency is [ReactiveSupport](https://github.com/danascheider/reactive_support).
To add ReactiveExtensions to your project, add this to your Gemfile and run `bundle install`:
<pre><code>gem 'reactive_extensions', '~> 0.5.0.beta'</code></pre>
To install locally:
<pre><code>sudo gem install reactive_extensions</code></pre>
Or if you're using RVM: 
<pre><code>gem install reactive_extensions</code></pre>

You can also point your Gemfile to this repo:
<pre><code>gem 'reactive_extensions', '~> 0.5.0.beta', git: 'https://github.com/danascheider/reactive_extensions.git</code></pre>

After installing, simply include this in your main project file:
<pre><code>require 'reactive_support'</code></pre>

Please note that version 0.4.0.beta is the earliest available version of ReactiveExtensions.

### Contributing
Contributions are welcome and I will respond promptly to all issue reports and pull
requests. Particularly helpful are pull requests adding support for additional Rubies.
(Currently, only Matz Rubies >= 1.9.3 are supported.) Here are some general guidelines 
to get you started:
  * Include passing RSpec tests with your pull request. I aim for 100% test coverage.
  * Run the whole test suite before you make your PR. Make sure your changes don't
    break the rest of the gem.
  * Don't add any new dependencies to ReactiveExtensions, or methods that are specific
    to a particular framework, gemset, or type of app.
  * Include documentation. ReactiveExtensions uses [Inch CI](http://inch-ci.org) to
    evaluate the quality of documentation. Please help make it easy for others to
    use and contribute to this project.
  * ReactiveExtension is designed with principles of stability, simplicity, and 
    transparency in mind. Its functionality should be easy to understand and use.