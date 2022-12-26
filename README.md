# Redqu

*A reddit rss media queue extractor*

![2022-12-27_00-20](https://user-images.githubusercontent.com/82055622/209588571-310b3e87-a39f-4baf-b2bd-7a9348dccd44.png)

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

If you want to you can copy this to your path: `cp redqu-1.0.jar /usr/local/bin`
And maybe add a small wrapperscript (redq would be a good name):
```sh
#!/bin/sh
java -jar /usr/local/bin/redqu-1.0.jar $*
```

## Building from Source

```sh
clj -T:build uber
```
