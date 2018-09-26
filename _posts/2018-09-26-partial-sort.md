---
title: Retrieving the k largest (or smallest) elements in R
author: John Reid
output: html_document
layout: post
comment: true
---




A common problem in computer science is selecting the $k$ largest (or smallest)
elements from an unsorted list containing $n$ elements.

This is a form of [partition-based selection](
https://en.wikipedia.org/wiki/Selection_algorithm#Partition-based_selection).
For example, when computing k-nearest-neighbour distances, we first calculate
all the pairwise distances between samples, then for each sample we select the
$k$ closest distances. In R this is implemented too often as


{% highlight r %}
sort(dists)[1:k]
{% endhighlight %}

which is correct but does not scale well. It sorts the entire vector `dists`
before selecting the first $k$ elements. As the number of elements $n$ grows
this is inefficient as the `sort()` call runs in $\mathcal{O}(n \log n)$ time.
Partition-based selection algorithms do not sort the entire list nor the
selected elements. They run in $\mathcal{O}(n + k \log k)$ resulting in savings
of a factor of $\log n$.

The statistical programming language R has an inbuilt and under-appreciated
partial sorting implementation that can help tremendously. We showcase,
benchmark and discuss this functionality here.


## Set up

Load the necessary packages.

{% highlight r %}
suppressPackageStartupMessages({
  library(tidyverse)
  library(ggthemes)
  library(microbenchmark)
})
{% endhighlight %}


Configure plots and seed RNG.

{% highlight r %}
set.seed(3737)
theme_set(theme_few())
{% endhighlight %}


Set parameters.

{% highlight r %}
n <- 3000  # Number of samples
k <- 20  # How many to select
zoom.margin <- 10  # Margin for zoomed-in plot
{% endhighlight %}


## An example

Just to demonstrate what R's partial sorting implementation does, we generate
some test samples.


{% highlight r %}
x <- rnorm(n = n)  # samples
{% endhighlight %}

R's standard `sort` function takes a `partial` argument specifying the indexes
at which you wish the vector to be partitioned. Here we want to select the
smallest $k$ elements so we have just one such index, $k$ itself.


{% highlight r %}
x_selected <- sort(x, partial = k)
{% endhighlight %}

We plot the selected array to show that every element beneath the $k$'th is indeed
smaller than the $(k+1)$'th.


{% highlight r %}
gp <-
  qplot(1:n, x_selected) +
    geom_vline(xintercept = k, linetype = 2) +
    geom_hline(yintercept = x_selected[k], linetype = 2)
gp
{% endhighlight %}

![plot of chunk plotPartial](/../_posts/../images/R-figs/plotPartial-1.svg)

Zoom in to the detail around the $k$'th element.


{% highlight r %}
gp +
  xlim(k - zoom.margin, k + zoom.margin) +
  ylim(x_selected[k - zoom.margin], x_selected[k + zoom.margin])
{% endhighlight %}

![plot of chunk plotPartialZoom](/../_posts/../images/R-figs/plotPartialZoom-1.svg)


## Benchmarks

Here we use the `microbenchmark` package to show how much quicker
partition-based selection is than full sorting. Note we also test finding the
largest $k$ elements (`sort(x, partial = length(x) - k)`).


{% highlight r %}
microbenchmark(
  sort(x, partial = k),
  sort(x, partial = length(x) - k),
  sort(x)
)
{% endhighlight %}



{% highlight text %}
## Unit: microseconds
##                              expr     min       lq      mean   median
##              sort(x, partial = k)  48.626  50.6075  54.18525  53.0365
##  sort(x, partial = length(x) - k)  46.398  48.2705  51.06711  50.1240
##                           sort(x) 151.349 153.8045 161.37612 156.5275
##        uq     max neval cld
##   54.9455 101.500   100  a 
##   52.3850  73.985   100  a 
##  158.7200 284.841   100   b
{% endhighlight %}


## Asymptotics

The running time should be linear in $n$. We define a function to time the
partition-based selection.


{% highlight r %}
time_partial_sort <- function(n) {
  samples_n <- samples[1:n]
  then = proc.time()
  sort(samples_n, partial = k)
  return(proc.time() - then)
}
{% endhighlight %}

We choose 50 problem sizes ($n$) ranging from 100,000 to 100,000,000.


{% highlight r %}
problem_sizes <- round(10^(seq(5, 8, length.out = 50)))
{% endhighlight %}

Sample data to test with.

{% highlight r %}
samples <- rnorm(n = max(problem_sizes))
{% endhighlight %}

Time the partition-based selection.


{% highlight r %}
timings <-
  t(sapply(problem_sizes, time_partial_sort)) %>%
  as.data.frame() %>%
  mutate(n = problem_sizes)
{% endhighlight %}

Plot the elapsed times. We observe a linear relationship between the running
time and $n$.


{% highlight r %}
ggplot(timings, aes(x = n, y = elapsed)) +
  geom_point() +
  geom_smooth(method = 'lm')
{% endhighlight %}

![plot of chunk plotElapsed](/../_posts/../images/R-figs/plotElapsed-1.svg)


# Drawbacks

Frequently we are interested not in the values of the $k$ smallest elements but
their indexes. Unfortunately R's `sort()` will not let us retrieve these
indexes as the `index.return = TRUE` parameter is not compatible with the
`partial` argument.


{% highlight r %}
sort(x, partial = k, index.return = TRUE)
{% endhighlight %}



{% highlight text %}
## Error in sort.int(x, na.last = na.last, decreasing = decreasing, ...): unsupported options for partial sorting
{% endhighlight %}

One possible solution is to find the $k$'th largest element by partition-based
selection and then to run through the data again to locate those elements that
are less than or equal to it.


{% highlight r %}
kth <- sort(x, partial = k)[k]
kth
{% endhighlight %}



{% highlight text %}
## [1] -2.642236
{% endhighlight %}



{% highlight r %}
indexes <- which(x <= kth)
indexes
{% endhighlight %}



{% highlight text %}
##  [1]   74   82  305  335  347  509  594  656  744 1093 1384 1512 2003 2103
## [15] 2403 2494 2512 2638 2736 2815
{% endhighlight %}



{% highlight r %}
x[indexes]
{% endhighlight %}



{% highlight text %}
##  [1] -2.664565 -2.645308 -2.801753 -2.642236 -3.058703 -2.997622 -2.690972
##  [8] -3.167249 -2.934196 -2.656970 -2.685767 -2.647660 -3.342775 -4.279542
## [15] -2.984152 -3.673439 -2.849113 -2.884244 -3.026133 -3.874028
{% endhighlight %}

Note this does not deal with ties when there is more than one $k$'th smallest element.
This still has running time $\mathcal{O}(n + k \log k)$ but with a worse constant and
memory requirements.

A more sophisticated approach could build upon this Rcpp
[example](http://gallery.rcpp.org/articles/sorting/).
