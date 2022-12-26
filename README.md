# Redqu

*A reddit rss media queue extractor*

![Showcase](https://user-images.githubusercontent.com/82055622/209588571-310b3e87-a39f-4baf-b2bd-7a9348dccd44.png)
## Usage

Provide a subreddit name as an input.
Extraction is hardcoded to be top of week for now.
Redqu outputs a bunch of links, get creative.

Example:
```sh
mpv $(redq cats)
```

Sometimes reddit is grumpy and doesn't wanna cooperate.
Just try again.
The relevant error message: `Reddit 429 Too Many Requests. Try Again.`

## Installation

Dependency Alert: you need some sort of java runtime for this.

```sh
sudo curl -sL github.com/port19x/redqu/raw/main/redq -o /usr/local/bin/redq &&
sudo curl -sL github.com/port19x/redqu/raw/main/redqu-1.0.jar -o /usr/local/bin/redqu-1.0.jar &&
sudo chmod +x /usr/local/bin/redq
```

## Building from Source

```sh
clj -T:build uber
```
