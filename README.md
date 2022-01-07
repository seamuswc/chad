## Installation steps

  1) Open your terminal
  2) **Type:** cd ~/desktop
  3) **Type:** mkdir chad
  4) **Type:** cd chad
  5) **Type:** git int
  6) **Type:** git pull https://github.com/seamuswc/chad
  7) **Type:** bundle install
  8) **Type:** ruby chad.rb

## ISSUES
  1) Opensea limites 50 assets per API call, so not accurate with larger wallets 
  2) Does NOT detect MINTED assets, this is tricky, fixable at some point
  3) 1 Wallet address per time. We can make it loop through a txt.file of address though.
  4) **ctrl c** will exit the program at any time.


### Notes
This assumes ruby is installed on your computer.

It should be by default, if not: https://www.ruby-lang.org/en/documentation/installation/

This also assumes git is installed on your computer.

It should be by default, if not: https://git-scm.com/