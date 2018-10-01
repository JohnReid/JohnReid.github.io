---
layout: page
title: Software
description: "Pseudotime, suffix trees &amp probabilistic models"
header-img: images/IMG_2395.jpg
comments: true
modified: 2018-10-01
---

All the research projects I have undertaken have involved some amount of
software development. I view publishing implementations of models and
algorithms as an integral part of the reproducible research process. My
tools of choice are TensorFlow, R, [Stan](http://mc-stan.org), python and
C++. I would love to learn some [Julia](https://julialang.org/).

------

## DeLorean

[DeLorean](https://github.com/JohnReid/DeLorean) is an R package I developed to
**order single cells in pseudotime**. The **latent variable Gaussian process**
model is coded and inference is performed using the [Stan](http://mc-stan.org/)
probabilistic programming language and library.

------

## STEME

[STEME](https://github.com/JohnReid/STEME) is a C++ implementation of a
branch-and-bound algorithm I developed to speed up the Expectation-Maximisation
algorithm for **finding motifs** in biological sequences. It makes heavy use of
the [SeqAn](http://www.seqan.de/) library for sequence analysis. In particular
most of the computational savings result from the use of **suffix trees**.

------

## pybool

[pybool](https://github.com/JohnReid/pybool) is a python package that infers
**Boolean regulatory networks** given time course expression data under
perturbations and a set of temporal constraints on expression.  Prior knowledge
about the presence or absence of regulatory connections can be incorporated
into the inference. Inference is performed in parallel allowing larger networks
to be inferred on clusters.

------

## HMM

[HMM](https://github.com/JohnReid/HMM) is a C++ library with a python interface
that relies on templated generic programming techniques to efficiently
implement the Baum-Welch and Viterbi algorithms for **hidden Markov models**.
Markov models of any (reasonable) order are supported.

------

## infpy

[infpy](https://github.com/JohnReid/infpy) is a python library that implements
various machine learning inference algorithms and models. In particular it has
an implementation of the **collapsed variational Bayes inference** scheme for
the **hierarchical Dirichlet process model** used in my transcriptional
programs work.  It also contains a python implementation of **Gaussian
processes**. The implementation focusses on ease of composition of kernels and
MAP inference of kernel parameters.

------

## biopsy

[biopsy](https://github.com/JohnReid/biopsy) is a C++ library with a python
interface that implements the **phylogenetic transcription factor binding
scanning** algorithms developed in my thesis. It contains a templated generic
implementation of the maximal chain algorithm that is integral to this work.

------

## pyicl

[pyicl](https://github.com/JohnReid/pyicl) is a python interface to the
[Boost interval container library](http://www.boost.org/doc/libs/release/libs/icl/).
From the library's documentation:

> Intervals are almost ubiquitous in software development. Yet they are very
> easily coded into user defined classes by a pair of numbers so they are only
> implicitly used most of the time. The meaning of an interval is simple. They
> represent all the elements between their lower and upper bound and thus a
> set. But unlike sets, intervals usually can not be added to a single new
> interval. If you want to add intervals to a collection of intervals that does
> still represent a set, you arrive at the idea of interval_sets provided by
> this library.

> One of the most advantageous aspects of interval containers is their very
> compact representation of sets and maps. Working with sets and maps of
> elements can be very inefficient, if in a given problem domain, elements are
> typically occurring in contiguous chunks. Besides a compact representation of
> associative containers, that can reduce the cost of space and time
> drastically, the ICL comes with a universal mechanism of aggregation, that
> allows to combine associated values in meaningful ways when intervals overlap
> on insertion.
