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
  1) Opensea limits 50 assets per API call, so not accurate with larger wallets.
  Beacuse of this limitation the program makes two seperate api calls and combines them. One sorts by **Sale_Price DESC** and the other by **Sale_Count ASC**. These combine and cross cancel to give and accurate picture of the accounts holdings. **Sale_Price DESC** was used to hit big purchases and **Sale_Count ASC** was used to hit mints.

## MINTING ISSUES
  1) Assets that are minted but NOT UNIQUE are currently being listed as PURCHASES.
  2) Assets that are transfered are being listed as MINTED 

### Notes
This assumes ruby is installed on your computer.

It should be by default, if not: https://www.ruby-lang.org/en/documentation/installation/

This also assumes git is installed on your computer.

It should be by default, if not: https://git-scm.com/