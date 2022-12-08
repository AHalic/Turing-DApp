# Turing-DApp
An Ethereum Decentralized Application for a fictional coin called Turing


# DApp
The smart contract implements three functions:

```
function issueToken(addr receiver, saTurings amount)

function vote(nickname, saTurings amount)

function endVoting()
```
saTurings is the smallest denomination of Turing. The first function issues an amount of tokens on the receivers wallet, only one specific address can use it (the professor), just as the third one. 
The vote function receives the nickname of one of the participants and the amount they will receive, the amount must be at most 2 Turings. Only allowed address can vote, and they can't vote for themselves. The voter also receives 0.2 Turings. 
Finally, the endVoting allows the professor to end ou re-start the voting.


# Interface
The interface was implemented using JS, CSS and HTML. To access the voting page you can either enter this [link](https://turing-dapp.vercel.app), or run the implementation with the following command:
```
npm install
npm start
```
The admin also has a page, which will be available at `localhost:8000/admin`
