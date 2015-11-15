---
layout: default
---

<h2 style="text-align: center">Index of Posts</h2>
<br/>

<ul>
  {% for post in site.posts %}
  <li>
    {{ post.date | date: "%m/%d/%y "}} - <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
  </li>
  {% endfor %}
</ul>
