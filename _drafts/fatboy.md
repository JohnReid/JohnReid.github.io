---
title: "Fatboy: a backgammon AI"
author: John Reid
output: html_document
layout: post
header-img: images/DSC00285.jpg
comment: true
---

This is the story of *Fatboy*, a neural network that taught itself to play
backgammon back in the early 90s. It was probably the first autonomous AI game
playing agent on the internet when it was connected to the [First Internet
Backgammon Server](http://www.fibs.com/) (FIBS) 24 hours a day, 7 days a week.
It wasn't the strongest backgammon playing network, that title was taken by
TD-Gammon and later by JellyFish, however it played at a decent level and
generated a lot of interest on FIBS when it first appeared.

DeepMind's
[AlphaZero](https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go)
may have all garnered all the
[headlines](https://www.theguardian.com/sport/2018/dec/11/creative-alphazero-leads-way-chess-computers-science)
in the last few years as the best go, chess, and shogi playing entity on the
planet. Its playing strength is often attributed to its ability to learn
through self-play but this technique is not new, its use was pioneered by
Gerald Tesauro in the late 80s and early 90s. Tesauro created
*[TD-Gammon](http://www.mitpressjournals.org/doi/10.1162/neco.1994.6.2.215)*,
a world-class backgammon AI that learned by self-play.

In 1993-94 I was introduced to neural networks whilst studying for
a postgraduate Diploma in Computer Science at the University of Cambridge and
I wanted to learn more. Somehow, although I cannot remember how, I had heard of
Gerald Tesauro's revolutionary work and was interested in replicating his
results for my thesis. I was already playing backgammon for the Cambridge
University Backgammon Club and socially at the Department of Pure Mathematics
and Mathematical Statistics, so the project naturally combined two interests.

The result was *Fatboy*, a backgammon playing agent taught entirely through
self-play. Fatboy included an interface to FIBS and to the best of my knowledge
was the first AI agent to play online against all-comers on the internet.

<!-- Control how much is shown as an excerpt. -->
<!--more-->


## Game-playing AIs

Game playing is a natural environment to research and develop AI and has been
used as such since Samuel's
[checker](https://ieeexplore.ieee.org/abstract/document/5392560)
[programs](https://ieeexplore.ieee.org/abstract/document/5391906) in the 50s.
Some other notable early examples include:

  - Tesauro's world class backgammon neural network agent
    [TD-Gammon](https://en.wikipedia.org/wiki/TD-Gammon) (1989)
  - Boyan's [modular
    networks](https://bkgm.com/articles/Grater/Bibliography/files/Boyan-BackgammonThesis.pdf)
    for playing backgammon (1992)
  - Schraudolph, Dayan and Sejnowski's 9x9 [Go playing neural network
    agent](http://www.gatsby.ucl.ac.uk/~dayan/papers/sds94.html) (1994)
  - Moriarty and Miikkulainen's [genetic
    algorithms](http://nn.cs.utexas.edu/downloads/papers/moriarty.discovering.pdf)
    for Othello (1995)


## Why backgammon?

Out of all these early game-playing AIs why was it that the most success was
found in backgammon with TD-Gammon? Many of these agents shared the same
learning algorithm and used similar neural architectures. The consensus is that
it was the nature of the game of backgammon that enabled TD-Gammon to perform
so well. The dice in backgammon are stochastic and this precludes long-term
planning. Calculating tactical skirmishes is less important in backgammon than
in games such as chess. The evaluation of most chess positions (especially
those critical to the outcome of the game) relies heavily on deep tree search
to resolve these tactics. In contrast, the evaluation of backgammon positions
depends more on the recognition of positional features and an understanding of
how they interact rather than resolving a tree of variations.

In addition to the effect the dice have on the principles of evaluating
backgammon positions, they may also aid the learning algorithm. Reinforcement
learning algorithms for game playing can get stuck in local strategic minima
when they believe their sub-optimal strategies are best. A bad roll can force
the agent to visit positions it would not ordinarily choose. Exploration of
these positions can be vital for successful learning as previous evaluations
can be over-turned. Indeed, exploration/exploitation trade-offs are an active
area for reinforcement learning research.


## Reinforcement learning

[Reinforcement learning](https://en.wikipedia.org/wiki/Reinforcement_learning)
is concerned with how to optimise an agent's behaviour to maximise some reward
signal. The reward signal is typically sparse in board games as the only
feedback the agent receives when it is told the result of the game.


### Temporal difference learning

TO DO: expand: Richard Sutton


## Early 90s neural networks

In the early 90s there were no deep learning frameworks such as TensorFlow or
PyTorch. Fatboy was implemented from scratch in ANSI C. Modern optimisers like
ADAM were not available, although I did have to make a choice between back
propagation (with momentum), (scaled) conjugate gradient descent,
delta-bar-delta, and RProp.


## Fatboy

The final Fatboy agent consisted of:

  - a set of hand-crafted position features (a la TD-Gammon)
  - a neural network with three hidden layers
  - outputs that represent the probability that a single or double game would
    be won or lost (backgammons were ignored as they were so rare and could
    almost always be avoided by a roll-off database)
  - an almost perfect database for bearing off
  - an understanding of backgammon match equity in relation to cube decisions

As described above the TD-Lambda reinforcement learning was used to update
the position evaluations arrived at through self-play.

Unfortunately, despite purchasing a USB floppy disk drive and trawling through
some antiquated disks, Fatboy's source code and weights have been lost and he
will probably never play backgammon again. This is probably for the best as he
could not compete with modern neural network backgammon playing monsters.

- playing style


## Online backgammon

- interaction with human players
- forum comments
