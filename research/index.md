---
layout: page
title: Research Interests
description: "Non-parametric Bayes &amp; Regulatory networks"
header-img: images/DSC00346.jpg
comments: false
modified: 2016-03-18
---


I work both on theoretical models of biological systems and their application
to real-world data.

Theoretically, I am an advocate of Bayesian non-parametric
models such as Dirichlet processes and Gaussian processes. I also have a
background in biological sequence analysis, in particular locating
transcription factor binding sites and inferring motifs that represent their
binding preferences.

In terms of applications, I mainly work with
transcriptome data, most recently this has been single-cell expression data in
developmental systems and also with transcription binding location data (e.g.
ChIP-seq).  I am interested in using these data to infer genetic regulatory
networks.


### Ordering single cells in pseudotime

Many single cell experiments take samples at a handful of time points within a
biological process. Unfortunately individual cells may progress through the
process at different rates and this can confound any analysis of the data. In
this project I modelled this effect using a latent variable Gaussian process
model and inferred latent pseudotime variables to place each cell on a
trajectory within the process. Downstream analyses of the data are more
effective when these pseudotimes are estimated well ([bioRxiv
paper](http://biorxiv.org/content/early/2015/05/21/019588)).


### Efficient motif finding using suffix trees

Transcriptional regulation is an important mechanism that cells use to control
gene expression. Unfortunately determining transcription factor binding
preferences (motifs) from location data is a challenging problem. In particular
experimental techniques have progressed rapidly and generate more data than
state-of-the-art motif finding techniques can handle. I used a branch-and-bound
approximation to significantly speed up one of the most popular motif finding
methods (expectation-maximisation). This work was published in [Nucleic Acids
Research](http://nar.oxfordjournals.org/content/39/18/e126).


### Transcriptional programs

Transcription factors do not act in isolation. Strong evidence suggests that
many regulatory networks rely on combinatorial control via sets of
transcription factors working together. I applied a hierarchical Dirichlet
process document-topic model that is well studied in the machine learning
literature to noisy data of predicted transcription factor binding sites
throughout the regulatory genome. This model revealed this combinatorial
structure in the form of transcriptional programs. In this application the
transcriptional programs are analagous to topics in the original machine
learning application ([BMC Bioinformatics
paper](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-218)).
