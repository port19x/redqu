# Redqu
[![bb compatible](https://raw.githubusercontent.com/babashka/babashka/master/logo/badge.svg)](https://babashka.org)

*A reddit rss media queue extractor*

![Showcase](https://user-images.githubusercontent.com/82055622/209588571-310b3e87-a39f-4baf-b2bd-7a9348dccd44.png)

## Usage

```sh
mpv $(redq cats)
mpv $(redq cats top hour)
mpv $(redq cats new)
```
*Redqu outputs a bunch of links, get creative.*

Provide a subreddit name, a sort method and timeframe as an input. \
Accepted sort methods: `hot new top rising controversial` \
Default sort method: `top` \
Accepted time frames: `hour day week month year all` \
Default time frame: `week`

## Installation

### Arch Linux

```
yay -S redqu
```

### From Source

1. Install [babashka](https://github.com/babashka/babashka#installation)
2. Put redqu in your path:
```sh
sudo curl -sL github.com/port19x/redqu/raw/main/redqu -o /usr/local/bin/redqu &&
sudo chmod +x /usr/local/bin/redqu
```
