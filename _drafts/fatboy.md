---
title: "Fatboy: a backgammon AI"
author: John Reid
output: html_document
layout: post
header-img: images/DSC00285.jpg
comment: true
---

This is the story of *Fatboy*, a neural network that taught itself to play
backgammon back in the early 90s. When it connected to the [First Internet
Backgammon Server](http://www.fibs.com/) (FIBS) 24 hours a day and 7 days
a week in the summer of 94, it was probably the first autonomous AI game
playing agent on the internet. It wasn't the strongest backgammon playing
network, that title was taken by TD-Gammon and later by JellyFish, but for
a while it was the strongest freely available program. It played at a decent
level and generated a lot of
[interest](https://groups.google.com/forum/#!searchin/rec.games.backgammon/fatboy|sort:date/rec.games.backgammon/U7uYIu3wk6Q/htGTNKMWz5AJ)
on FIBS when it first appeared.

<!-- Control how much is shown as an excerpt. -->
<!--more-->

DeepMind's
[AlphaZero](https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go)
may have attracted all the
[headlines](https://www.theguardian.com/sport/2018/dec/11/creative-alphazero-leads-way-chess-computers-science)
in the last few years as the best Go, chess, and shogi playing entity on the
planet. Its playing strength is often attributed to its ability to learn
through self-play but this technique is not new - its use was pioneered by
Gerald Tesauro in the late 80s and early 90s. Tesauro created
*[TD-Gammon](http://www.mitpressjournals.org/doi/10.1162/neco.1994.6.2.215)*,
a world-class backgammon AI that learned by self-play.

In 1993-94 I was introduced to neural networks while studying for
a postgraduate Diploma in Computer Science at the University of Cambridge and
I wanted to learn more. Somehow, although I cannot remember how, I had heard of
Gerald Tesauro's revolutionary work and was interested in replicating his
results for my thesis. I was already playing backgammon for the Cambridge
University Backgammon Club and socially at the Department of Pure Mathematics
and Mathematical Statistics, so the project naturally combined two interests.

The result was *Fatboy*, a backgammon playing agent taught entirely through
self-play. Fatboy included an interface to FIBS and to the best of my knowledge
was the first AI agent to play online against all-comers on the internet.

![Cover of the thesis describing Fatboy]({{ site.url }}/images/fatboy-cover.jpg)

## Game-playing AIs

Game playing is a natural environment to research and develop AI and has been
used as such since Samuel's
[checker](https://ieeexplore.ieee.org/abstract/document/5392560)
[programs](https://ieeexplore.ieee.org/abstract/document/5391906) in the 50s.
Some other notable early examples include:

  - [Hans Berliner's](https://en.wikipedia.org/wiki/Hans_Berliner) (the
    well-known computer chess programmer and correspondence chess world
    champion) rules-based [backgammon
    program](http://www.sciencedirect.com/science/article/pii/0004370280900417)
    that in 1979 defeated the world champion of that time.
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
planning. Calculating tactical skirmishes is less important than in games such
as chess. The evaluation of most chess positions (especially those critical to
the outcome of the game) relies heavily on deep tree search to resolve these
tactics. In contrast, the evaluation of backgammon positions depends more on
the recognition of positional features and an understanding of how they
interact rather than resolving a tree of variations.

In addition to the effect the dice have on the principles of evaluating
backgammon positions, they may also aid the learning algorithm. Reinforcement
learning algorithms for game playing can get stuck in local strategic minima
when they believe their sub-optimal strategies are best. However, a bad roll
can force the agent to visit positions it would not ordinarily choose. This
exploration can be vital for successful learning when previous evaluations are
over-turned. Indeed, exploration/exploitation trade-offs remain an active area
for reinforcement learning research today.


## Reinforcement learning

[Reinforcement learning](https://en.wikipedia.org/wiki/Reinforcement_learning)
is concerned with how to optimise an agent's behaviour to maximise some reward
signal. The reward signal is typically sparse in board games as the only
feedback the agent receives is when it is told the result of the game.


### Temporal difference learning

TO DO: expand on TD-Lambda and Richard Sutton


## Fatboy


### Training

![Hyperparameter search]({{ site.url }}/images/fatboy-params.jpg){: width="400px" .align-center}


### Early 90s neural networks

In the early 90s there were no deep learning frameworks such as TensorFlow or
PyTorch. Fatboy was implemented from scratch in ANSI C. Modern optimisers like
ADAM were not available, although I did have to make a choice between back
propagation (with momentum), (scaled) conjugate gradient descent,
delta-bar-delta, and RProp.

![Fatboy's forward propagation algorithm]({{ site.url }}/images/fatboy-forward-i.jpg){: .center-image width="400px" }
![Fatboy's forward propagation algorithm]({{ site.url }}/images/fatboy-forward-ii.jpg){: .center-image width="400px" }

The final Fatboy agent consisted of:

  - a set of hand-crafted position features (à la TD-Gammon)
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
might embarrass himself against the modern neural network backgammon playing
monsters.


## Online backgammon

Playing 24-by-7 had some advantages and Fatboy soon became the most active
player on FIBS. By November 1995 he had played over [36,000
games](https://groups.google.com/forum/#!topic/rec.games.backgammon/C8KL6uF9vuU).

There was some [discussion](https://bkgm.com/rgb/rgb.cgi?view+181) of his
playing strength. Several in the community were convinced he was over-rated but
the evidence didn't support this as he played many more games than human
players and also had virtually no defences against individuals who would not
complete matches they were about to lose. In any case, he was rated well over
the median rating and was getting into expert territory. He was never close to
challenging TD-Gammon for the title of strongest backgammon playing bot and
soon other neural network bots also overtook him. However for a while he was
the strongest freely available bot.

Fatboy was popular with at least some of the FIBS
[community](https://groups.google.com/forum/#!searchin/rec.games.backgammon/fatboy|sort:date/rec.games.backgammon/S4T7wmYE5Bs/BJKMz9lc8k0J):

> "I find fatboy to be one of the politest players on FIBS.  He never
> whines about bad rolls.  He almost always plays quickly (unless lagged)
> and yet never complains if you play slowly.  He accepts matches from
> anyone, no matter how inexperienced or annoying they may be.  I think
> a lot of people on FIBs could take a lesson in proper conduct from
> fatboy.

> Many people must agree with me -- otherwise, why would he be the most
> popular player on FIBS?

> So he's a little on the quiet side -- maybe he's shy.  :-)

> In any case, there are many many other candidates more deserving of the
> Least Congenial award." - Darse Billings

This is presumably the same [Darse
Billings](https://webdocs.cs.ualberta.ca/~darse/) who went on to research poker
playing AI. Anyway thanks for the quote Darse!
