# Shop

## Overview

* Points: 50
* Category: Reverse Engineering
* Author: Thelshell

## Description
Best Stuff - Cheap Stuff, Buy Buy Buy... Store Instance: [source](https://mercury.picoctf.net/static/e8e966fcaa1ff5ea48574046d0cf9c19/source). The shop is open for business at `nc mercury.picoctf.net 37799`.

## Hints

1. Always check edge cases when programming

## Approach

1. After connecting with netcat, we get an interactive shop where we can buy and sell stuff. The shop is made up of a very simple menu:
```
Welcome to the market!
=====================
You have 40 coins
        Item            Price   Count
(0) Quiet Quiches       10      12
(1) Average Apple       15      8
(2) Fruitful Flag       100     1
(3) Sell an Item
(4) Exit
Choose an option: 
```
2. After testing both the buy and sell option, we can start trying to mess up with the inputs. As we can see, there are no printouts of our own input, so this clearly can't be a format string vulnerability. We can try entering characters instead of numbers, trying to crash the program, but it only accepts valid numbers. What if we can find a way to mess it up just by using numbers? The given hint is `"Always check edge cases when programming"`. Maybe there isn't a check on __negative__ number inputs.
3. Entering a negative number while selecting an option seems to not be working. However, if we enter a negative number while prompted with `How many do you want to buy?` we can easily inject a negative number, messing up the cost calculation: `Cost = Price * Quantity`. Since the quantity is given as an input by the user, if we enter a negative quantity we get a negative cost, which means that the shop actually pays us!
4. By abusing this found exploit, we can farm up moneys untill we reach 100 coins, which enables us to buy a __Fruitful Flag__. When trying to buy this item, we get the flag printed out as ASCII decimal code, which needs to be simply converted back to characters to achieve the flag.

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{b4d_brogrammer_591a895a}__
</details>