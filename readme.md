## About
This is my [blog](https://laprade.blog).
It's powered by [Jekyll](https://jekyllrb.com).

Thanks to [Jacopo Rabolini](http://www.jacoporabolini.com) for designing the [theme](https://github.com/KingFelix/emerald), and to Github for hosting Jekyll sites for free.

### Development

Use Ruby 3.3.12 (see `.ruby-version`), then install the locked dependencies:

```bash
bundle install
```

```bash
# start the jekyll server
bundle exec jekyll serve

# if you want to preview drafts
bundle exec jekyll serve --drafts
```

Custom CSS should all go in `./_sass/custom.scss`,
i.e. [here](https://github.com/davidlaprade/blog/blob/master/_sass/custom.scss)

### Deployment

```bash
bin/deploy
```
