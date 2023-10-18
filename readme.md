# Redqu

*A media centric reddit client*

![Showcase](https://user-images.githubusercontent.com/82055622/209588571-310b3e87-a39f-4baf-b2bd-7a9348dccd44.png)

## Usage

```sh
redqu cats
redqu cats top hour
redqu cats new
```

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

```sh
sudo curl -sL github.com/port19x/redqu/raw/master/redqu.py -o /usr/local/bin/redqu.py &&
sudo chmod +x /usr/local/bin/redqu.py &&
sudo ln -sf /usr/local/bin/redqu.py /usr/local/bin/redqu
```
