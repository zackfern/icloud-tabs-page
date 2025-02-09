# iCloud Tabs Page

## Overview

This is a simple Ruby script which will parse Safari's internal CloudTabs SQLite database and output your iCloud Tabs in a simple HTML page.

Why? Because I use Safari on my iPhone & iPad, but I don't use it on the computer!
Sometimes I'd like to access the tabs that I have open in Safari but not actually _browse_ using Safari.

Note that you'll probably need to open Safari before running this script in order to allow iCloud to sync up. I don't know how computers work.

## Use

Just run `./main.rb` and it should work! Note that you might have to allow your terminal access to your Library if you haven't already, because macOS security.

## Kudos

Shoutout to [this GitHub comment][1] for pointing out the location of the database.

[1]: https://github.com/josh-/CloudyTabs/issues/70#issuecomment-1094519118