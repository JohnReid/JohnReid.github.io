---
title: Fisher information and K-FAC optimisation
author: John Reid
output: html_document
layout: post
comment: true
...

The Fisher information quantifies how much information observed data carries
about a model's parameters. More recently it has been heavily used as
a pre-conditioner in natural gradient descent, a slower but more efficient
version of gradient descent that can be used when optimising the parameters of
a statistical model.

K-FAC is an optimisation method that approximates the Fisher information as
a pre-conditioner using a Kronecker product.

<!-- Control how much is shown as an excerpt. -->
<!--more-->

## Gradient descent

Fitting a statistical (or ML) model often involves minimising some loss function, for example when
performing maximum-likelihood estimation (MLE) for data $x_n$, we minimise the negative log-likelihood
\begin{align}
  \mathcal{L}(\theta) = - \sum_n \log p(x_n; \theta)
\end{align}
giving the MLE estimator
\begin{align}
  \hat{\theta}_\text{MLE} = \underset{\theta}{\operatorname{argmin}} \mathcal{L}(\theta)
\end{align}

There are many ways to do this but gradient descent is broadly applicable whenever the likelihood
is continuous in $\theta$. Gradient descent works by taking steps in the direction of "steepest descent"
\begin{align}
  \theta \mapsto \theta - \alpha \nabla_\theta \mathcal{L}(\theta)
\end{align}
where the learning rate $\alpha$ controls the step size in the direction of "steepest descent".

## Fisher information

## K-FAC

## EKFAC
