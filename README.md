# Biomart-Frontend

A [backbone](http://backbonejs.org/) frontend client for [biomart](https://github.com/biomart/biomart-rc7)

## Install:

    $: git clone https://github.com/yortz/biomart-frontend.git
    $: cd biomart-frontend
    $: bundle
    $: rake coffee
    $: rake compile

## Test:

Once you have cloned the repo and installed dependencies via bundler, you are ready to run tests via rake: e.g.

    $: rake test

You can also choose to not specify any task and by default Rake will compile your coffeescript files and run tests for you: e.g.

    $: rake

Rake will automatically look for changes and compile only those files that have been modified.

## Contribute:

* Fork repo
* Create your feature branch: `git checkout -b feature-branch`
* Commit your changes: `git commit -am 'Some feature'`
* Push to your branch: `git push origin feature-branch`
* Create a Pull Request

## Dependencies:

* [ruby](https://www.ruby-lang.org) 
* [coffeescript](http://coffeescript.org/)
* [capybara](https://github.com/jnicklas/capybara)
* [phantomjs](http://phantomjs.org/)




