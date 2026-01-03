
---

## TwoCandidateVoting — Solidity Voting Contract

This smart contract enables a fair and transparent voting process between two candidates. Each Ethereum wallet address can cast **only one vote**, and voting can be toggled **ON/OFF** by the contract administrator.

### Features

* Supports two fixed candidates (Candidate 1 and Candidate 2)
* Each wallet address can vote only once
* Voting can be enabled or disabled by the admin
* Voting is allowed only when status is ON
* Vote counts can be retrieved at any time

---

## Contract Behavior

### Voting Function

`vote(uint _candidateId)` allows a user to vote for:

* `1` → Candidate 1
* `2` → Candidate 2

Rules enforced inside the function:

1. The voter must not have voted before
2. Voting must be ON
3. The candidate ID must be valid

After a successful vote:

* The respective candidate’s counter is incremented
* The address is marked as having voted

---

## Ownership and Access Control

The contract assigns **ownership** during deployment:

* The wallet that deploys the contract becomes the `admin`
* The admin address is stored in the `admin` variable

Only the admin is allowed to control voting status.

This is enforced using the `onlyAdmin` modifier:

* Any function using this modifier checks that `msg.sender` equals `admin`
* If the caller is not the admin, the transaction reverts

The admin can toggle voting using:

`toggleVoting(Status _status)`

This allows the admin to switch between:

* `Status.ON`
* `Status.OFF`

When voting is OFF, no one can vote.

The `votingOpen` modifier ensures that:

* The `vote()` function can only run when the status is ON

---

## Retrieving Vote Counts

The function `getVotes()` returns:

* Total votes for Candidate 1
* Total votes for Candidate 2

in the form:

`(candidate1Votes, candidate2Votes)`

---

