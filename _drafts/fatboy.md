---
title: "Fatboy: a backgammon AI"
author: John Reid
output: html_document
layout: post
header-img: images/DSC00285.jpg
comment: true
---

DeepMind's
[AlphaZero](https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go)
may have all garnered all the
[headlines](https://www.theguardian.com/sport/2018/dec/11/creative-alphazero-leads-way-chess-computers-science)
in the last few years as the best go, chess, and shogi playing entity on the
planet. Its playing strength is often attributed to its ability to learn
through self-play but this technique is not new, its use was pioneered by
Gerald Tesauro in the late 1980s and early 90s. Tesauro created
*[TD-Gammon](http://www.mitpressjournals.org/doi/10.1162/neco.1994.6.2.215)*,
a world-class backgammon AI that learned by self-play.

In 1993-94 I was introduced to neural networks whilst studying for
a postgraduate Diploma in Computer Science at the University of Cambridge and
I wanted to learn more. Somehow, although I cannot remember how, I had heard of
Gerald Tesauro's revolutionary work and was interested in replicating his
results for my thesis. I was already playing backgammon in the university club
and at the pure maths department, so the project naturally combined two
interests.

The result was *Fatboy*, a backgammon playing agent taught entirely through
self-play. Fatboy included an interface to [FIBS](http://www.fibs.com/) and to
the best of my knowledge was the first AI agent to play online against
all-comers on the internet.

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

Out of all these early examples why was it that the most success was found in
backgammon with TD-Gammon? Many of these agents shared the same learning
algorithm and used similar neural architectures. The consensus is that it is
the nature of backgammon that enabled TD-Gammon to perform so well. Backgammon
is a stochastic game, the randomness of the dice precludes long-term planning.
Calculating tactical skirmishes is less important in backgammon than in games
such as chess. The evaluation of most chess positions (especially those
critical to the outcome of the game) relies heavily on deep tree search to
resolve these tactics. In contrast, the evaluation of backgammon positions
depends more on the recognition of positional features and an understanding of
how they interact rather than resolving a tree of variations.

In addition to the effect the dice have on how to evaluate backgammon
positions, they may also help the learning algorithm explore positions it might
not otherwise have visited. Reinforcement learning algorithms for game playing
can get stuck in local strategic minima when they believe their sub-optimal
strategies are best. A bad roll can force the agent to visit positions it would
not ordinarily choose.


## Reinforcement learning

Reward signal


### Temporal difference learning

Richard Sutton


## Early 90s neural networks

- no TensorFlow or PyTorch
- back-propagation from scratch
- ANSI C


## Fatboy

- architecture
- training
- playing strength
- code lost


## Online backgammon

- interaction with human players
- forum comments


## Playing style
