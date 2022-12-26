# Redqu

*A reddit rss media queue extractor*

## Usage

Provide a subreddit name as an input.
Extraction is hardcoded to be top of week for now.

Redqu outputs a bunch of links.
Get creative.

I like the following
```sh
mpv --fs $(java -jar redqu-1.0.jar cats)
```

Sometimes reddit is grumpy and doesn't wanna cooperate.
Just try again.
The relevant error message: `Reddit 429 Too Many Requests. Try Again.`

## Installation

Dependency Alert: you need some sort of java runtime for this.

Check the releases and download the .jar file.

## Building from Source

```sh
clj -T:build uber
```
