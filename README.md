## Installation steps

  1) Open your terminal
  2) **Type:** cd ~/desktop
  3) **Type:** mkdir chad
  4) **Type:** cd chad
  5) **Type:** git int
  6) **Type:** git pull https://github.com/seamuswc/chad
  7) **Type:** bundle install
  8) **Type:** ruby chad.rb

## ISSUES & NOTES
  1) Opensea limits 50 assets per API call, so not accurate with larger wallets.
  Beacuse of this limitation the program makes two seperate api calls and combines them. One sorts by **Sale_Price DESC** and the other by **Sale_Count ASC**. These combine and cross cancel to give and accurate picture of the accounts holdings. **Sale_Price DESC** was used to hit big purchases and **Sale_Count ASC** was used to hit mints.
  2) This program only tracks **NON-FUNGIBLE** NFTS, so non unique NFTS will not appear. An example of these are https://opensea.io/collection/byovape.
  This is partly because even the opensea UX has a hard time determing the floor price, and it is difficult to tell which are minted vs bought via API. These will also be common in the future as tickets to events, etc...
  3) Assets that are **transfered** are being listed as MINTED. Should I not count transfers at all? 

### Notes
This assumes ruby is installed on your computer.

It should be by default, if not: https://www.ruby-lang.org/en/documentation/installation/

This also assumes git is installed on your computer.

It should be by default, if not: https://git-scm.com/