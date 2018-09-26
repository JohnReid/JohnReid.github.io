---
layout: page
title: Publications
description: ""
header-img: images/DSC00372.jpg
comments: false
modified: 2018-09-26
---

A more up-to-date list of publications may be found on my [Google Scholar
page](https://scholar.google.co.uk/citations?user=uBSRKwcAAAAJ).

## Journal Articles
-----

<div class='panel-pub'>
<ol>
{% for article in site.data.journal-edited.references %}
    <li>
    <div class="title">
    <span class="title">{{ article.title }}</span>
    {% if article.fulltext %}
        <a title="fulltext" href="{{ site.url }}/downloads/journal/{{ thesis.fulltext }}"><i class="fa fa-file-pdf-o"></i></a>
    {% endif %}
    </div>
    <div class='author'>
    {% for author in article.author %}
        <span class='{{ author.role }}'>{{ author.family }}, {{ author.given }}{% if author.role contains 'corr' %}*{% endif %}; </span>
    {% endfor %}
    </div>
    <div class="pubinfo">
    <span class="source">{{ article.container-title }} </span>
    <span class="year">{{ article.issued[0].year }},</span>
    <span class="volume">{{ article.volume }}, </span>
    <span class="page">{{ article.page }}.</span>
    </div>
    <div class="url">
        <a href="{{ article.URL }}">{{ article.URL }}</a>
    </div>
    </li>
{% endfor %}
</ol>
</div>


## Preprints
------------

<div class='panel-pub'>
<ol>
{% for article in site.data.preprint-edited.references %}
    <li>
    <div class="title">
    <span class="title">{{ article.title }}</span>
    {% if article.fulltext %}
        <a title="fulltext" href="{{ site.url }}/downloads/journal/{{ thesis.fulltext }}"><i class="fa fa-file-pdf-o"></i></a>
    {% endif %}
    </div>
    <div class='author'>
    {% for author in article.author %}
        <span class='{{ author.role }}'>{{ author.family }}, {{ author.given }}{% if author.role contains 'corr' %}*{% endif %}; </span>
    {% endfor %}
    </div>
    <div class="pubinfo">
    <span class="source">{{ article.container-title }} </span>
    <span class="year">{{ article.issued[0].year }},</span>
    <span class="volume">{{ article.volume }}, </span>
    <span class="page">{{ article.page }}.</span>
    </div>
    <div class="url">
        <a href="{{ article.URL }}">{{ article.URL }}</a>
    </div>
    </li>
{% endfor %}
</ol>
</div>


## Theses
-----

<div class='panel-pub'>
<ol>
{% for thesis in site.data.thesis-edited.references %}
    <li>
    <div class="title">
    <span class="title">{{ thesis.title }}</span>
    {% if thesis.fulltext %}
        <a title="fulltext" href="{{ site.url }}/downloads/thesis/{{ thesis.fulltext }}"><i class="fa fa-file-pdf-o"></i></a>
    {% endif %}
    </div>
    <div class='author'>
    {% for author in thesis.author %}
        <span class='{{ author.role }}'>{{ author.literal }}</span>
    {% endfor %}
    </div>
    {% for advisor in thesis.advisor %}
        <span class='advisor'>{{ advisor.role }} : {{ advisor.literal }}</span>
    {% endfor %}
    <div class="pubinfo">
    <span class="source">{{ thesis.genre }}, </span>
    <span class="publisher">{{ thesis.publisher }}, </span>
    <span class="year">{{ thesis.issued[0].year }}.</span>
    </div>
    </li>
{% endfor %}
</ol>
</div>
