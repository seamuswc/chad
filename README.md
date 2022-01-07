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
  1) Opensea limits 50 assets per API call, so not accurate with wallets that have over 50 NFTs.
  There was an attempted solution of stacking API calls and ordering them different. One by **Sale_Price DESC** and the other by **Sale_Count ASC**. These would combine and cross cancel to give and accurate picture of the account's holdings. **Sale_Price DESC** is used to hit big purchases and **Sale_Count ASC** is used to hit mints. However, this was still missing NFTs. The best solution is to apply for an API key with Opensea to remove the limit.
  2) This program only tracks **NON-FUNGIBLE** NFTs, so non unique NFTs will not appear. An example of these are https://opensea.io/collection/byovape.
  This is partly because even the Opensea UX has a hard time determing the floor price of these. It is also difficult to tell which are minted vs bought via API. These will also be common in the future as tickets to events, etc... & will pile up.
  3) Assets that are **transfered** are being listed as MINTED. Should I not count transfers at all? 

### Notes
This assumes ruby is installed on your computer.

It should be by default, if not: https://www.ruby-lang.org/en/documentation/installation/

This also assumes git is installed on your computer.

It should be by default, if not: https://git-scm.com/