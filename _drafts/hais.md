---
title: Hamiltonian Annealed Importance Sampling
author: John Reid
output: html_document
layout: post
header-img: images/IMG_2393.jpg
comment: true
---

Estimating expectations with respect to high-dimensional multimodal
distributions is difficult. Here we describe an
[implementation](https://github.com/JohnReid/HAIS) of Hamiltonian annealed
importance sampling in TensorFlow and compare it to other annealed importance
sampling implementations.

<!-- Control how much is shown as an excerpt. -->
<!--more-->


## Introduction

[Radford Neal showed](http://arxiv.org/abs/physics/9803008) how to use
annealing techniques to define importance samplers suitable for complex
multimodal distributions. [Sohl-Dickstein and Culpepper
extended](http://arxiv.org/abs/1205.1925) his work by demonstrating the utility
of Hamiltonian dynamics for the transition kernels between the annealing
distributions.


### Naive Monte Carlo expectations

A naive yet often practical way to estimate the expectation of a function $f(x)$
is simply to sample from the underlying distribution $p(x)$ and take an average:

$$
  \mathbb{E}_p[f(X)] \approx \hat{\mu} = \frac{1}{N} \sum_{n=1}^{N} f(X_n), \qquad X_n \sim p
$$

However when $f(x)$ is close to zero outside some set $\mathcal{A}$ where
$\mathbb{P}(X \in \mathcal{A})$ is small, samples from $p(X)$ typically fall
outside of $\mathcal{A}$ and the variance of $\hat{\mu}$ is high. Estimating
the marginal likelihood (or evidence) for a model given some data $\mathcal{D}$
is a canonical example of this. In this case $f(x) = p(\mathcal{D}|x)$ is the
posterior distribution and $p(x)$ is the prior. For many models and data the
posterior will be highly concentrated around a typical set, $\mathcal{A}$, that
only has small support under the prior.


### Importance Sampling

[Importance sampling](https://en.wikipedia.org/wiki/Importance_sampling) (IS)
is a method that can be well-suited for estimating expectations for which the
naive Monte Carlo estimator has high variance. The IS estimate of the
expectation is

$$
  \hat{\mu}_q = \frac{1}{N} \sum_{n=1}^{N} \frac{f(X_n) p(X_n)}{q(X_n)}, \qquad X_n \sim q
$$

$q$ is the **importance distribution** and $p$ is the **nominal distribution**.
A well chosen $q$ will give $\hat{\mu}_q$ a smaller variance than the
standard Monte Carlo estimate (equivalent to $p = q$). A badly chosen $q$
will give $\hat{\mu}_q$ infinite variance.


### Annealed Importance Sampling

Finding good importance distributions when $X$ is high-dimensional and/or $p$
is multimodal can be difficult. This makes the variance of $\hat{\mu}_q$
difficult to control. [Annealed importance
sampling](http://arxiv.org/abs/physics/9803008) (AIS) is designed to alleviate
this issue. AIS produces importance weighted samples from an unnormalised
target distribution $p_0$ by annealing towards it from some other distribution
$p_N$. For example,

$$p_n(x) = p_0(x)^{\beta_n} p_N(x)^{1-\beta_n}$$
where $1 = \beta_0 > \beta_1 > \dots > \beta_N = 0$. To implement AIS we must be
able to

  * sample from $p_N$
  * evaluate each (potentially unnormalised) distribution $p_n$
  * simulate a Markov transition $T_n$ for each $1 \le n \le N-1$ that leaves $p_n$ invariant


### Hamiltonian Annealed Importance Sampling

[Hamiltonian annealed importance sampling](http://arxiv.org/abs/1205.1925)
(HAIS) is a variant of AIS in which Hamiltonian dynamics are used to simulate
the Markov transitions between the annealed distributions. An important feature
is that the momentum term is partially preserved between transitions.


## Examples


### Log-gamma normalising constant

Unnormalised versions of well known densities are useful test cases for
annealed importance samplers. If $p$ is such an unnormalised density function
then its normalising constant is simply $\mathbb{E}_p[1]$ and can be estimated
using AIS. This estimate can be compared against the exact value to
double-check the validity of the estimate.

$X$ is said to be distributed as $\textrm{log-gamma}(\alpha, \beta)$ when $\log
X \sim \Gamma(\alpha, \beta)$. The probability density function for a gamma
distribution is

$$
f(x; \alpha, \beta) = \frac{\beta^\alpha}{\Gamma(\alpha)} x^{\alpha-1} e^{- \beta x}
$$
for all $x > 0$ and any given shape $\alpha > 0$ and rate $\beta > 0$. Given a change
of variables $y = \log(x)$ we have the density for a log-gamma distribution

$$
f(y; \alpha, \beta) = \frac{\beta^\alpha}{\Gamma(\alpha)} e^{\alpha y - \beta e^y}
$$

Thus if we define our unnormalised density as $p_0(x) = e^{\alpha x - \beta e^x}$
its normalising constant is $\frac{\Gamma(\alpha)}{\beta^\alpha}$.

Running our HAIS sampler on this unnormalised density with $\alpha = 2$ and
$\beta = 3$ gives these samples
![HAIS samples from log-gamma distribution]({{ site.url }}/images/hais-log-gamma-samples.png)
and the estimate of the log normalising constant is -2.1975 (the true value is -2.1972).




### Marginal likelihood


## Implementation

Our implementation is [available](https://github.com/JohnReid/HAIS) under a MIT
license.


### Related work

We have used ideas and built upon the code from some of the following repositories:

  - BayesFlow TensorFlow 1.4 - 1.6 [contribution](https://www.tensorflow.org/versions/r1.6/api_docs/python/tf/contrib/bayesflow/hmc/ais_chain).
    This is now integrated into [TensorFlow Probability](https://github.com/tensorflow/probability).
  - Sohl-Dickstein's Matlab [implementation](https://github.com/Sohl-Dickstein/Hamiltonian-Annealed-Importance-Sampling)
  - Xuechen Li's PyTorch (0.2.0) [implementation](https://github.com/lxuechen/BDMC) of Bi-Directional Monte Carlo
    from ["Sandwiching the marginal likelihood using bidirectional Monte Carlo"](https://arxiv.org/abs/1511.02543)
  - Tony Wu's Theano/Lasagne [implementation](https://github.com/tonywu95/eval_gen) of the methods described in
    ["On the Quantitative Analysis of Decoder-Based Generative Models"](https://arxiv.org/abs/1611.04273)
  - jiamings's (unfinished?) TensorFlow [implementation](https://github.com/jiamings/ais/) based on Tony Wu's Theano code.
  - Stefan Webb's HMC AIS in TensorFlow [repository](https://github.com/stefanwebb/tensorflow-hmc-ais).


### Features

  - Partial momentum refresh (from HAIS paper). This preserves some fraction of the Hamiltonian Monte
    Carlo momentum across annealing distributions resulting in more accurate estimation.
  - Adaptive step size for Hamiltonian Monte Carlo. This is a simple scheme to adjust the step size for
    each chain in order to push the smoothed acceptance rate towards a theoretical optimum.


### Tests

The tests that appear to be working include:

  - `test-hmc`: a simple test of the HMC implementation
  - `test-hmc-mvn`: a test of the HMC implementation that samples from a multivariate normal
  - `test-hais-log-gamma`: a simple test to sample from and calculate the log normaliser of
    an unnormalised log-Gamma density.
  - `test-hais-model1a-gaussian`: a test that estimates the log marginal likelihood for model 1a with
    a Gaussian prior from Sohl-Dickstein and Culpepper (2011).


### Installation

Install either the GPU version of TensorFlow (I don't know why but `tensorflow-gpu==1.8` and
`tensorflow-gpu==1.9` are >10x slower than 1.7 on my machine)
```bash
pip install tensorflow-gpu==1.7
```
or the CPU version
```bash
pip install tensorflow
```
then install the project
```bash
pip install git+https://github.com/JohnReid/HAIS
```


### API documentation

The implementation contains some [documentation](https://johnreid.github.io/HAIS/build/html/index.html)
generated from the docstrings that may be useful. However it is probably easier to examine the
[test scripts](https://github.com/JohnReid/HAIS/tree/master/tests) and adapt them to your needs.


### Who do I talk to?

[John Reid](https://twitter.com/__Reidy__) or [Halil Bilgin](https://twitter.com/bilginhalil)
