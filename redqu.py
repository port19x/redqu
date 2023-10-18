#!/bin/python
from collections import defaultdict
import re
import requests
import subprocess
import sys

helptext = """Usage: redqu sub sort time
Example: mpv $(redqu cats top week)

Valid sort parameters: hot new top rising controversial
Valid time parameters: hour day week month year all
Top of week is the default

If you're seeing this message in error, please open an Issue:
https://github.com/port19x/redqu/issues"""

time = defaultdict(lambda: "?t=week") 
time["h"] = "?t=hour"
time["d"] = "?t=day"
time["m"] = "?t=month"
time["y"] = "?t=year"
time["a"] = "?t=all"

sort = defaultdict(lambda: "/top.rss")
sort["h"] = "/hot.rss"
sort["n"] = "/new.rss"
sort["r"] = "/rising.rss"
sort["c"] = "/controversial.rss"

def redqu(sub, s="t", t="w", bot=False, n="0"):
    endpoint = ''.join(["https://reddit.com/r/", sub, sort[s[0]], time[t[0]]])
    agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0'
    headers = {'User-Agent': agent}
    resp = requests.get(endpoint, headers=headers)
    fulltext = resp.content.decode()
    
    res = [r"https://i.redd.it/[a-z0-9]*.png",
           r"https://i.redd.it/[a-z0-9]*.jpg",
           r"https://i.redd.it/[a-z0-9]*.gif",
           r"https://i.imgur.com/[a-zA-Z0-9]*.jpg",
           r"https://i.imgur.com/[a-zA-Z0-9]*.png",]

    if not bot:
        res.append(r"https://v.redd.it/[a-z0-9]*",)
        res.append(r"https://i.imgur.com/[a-zA-Z0-9]*.gifv")
        res.append(r"https://redgifs.com/watch/[a-z]*")

    links = [re.findall(i, fulltext) for i in res]
    links = [item for row in links for item in row]

    if bot:
        n = int(n)
        links = links[n:n+5]

    return links

if __name__ == "__main__":
    args = sys.argv[1:]
    if (len(args) == 1):
        links = redqu(args[0])
    elif (len(args) == 2):
        links = redqu(args[0], args[1])
    elif (len(args) == 3):
        links = redqu(args[0], args[1], args[2])
    else:
        print(helptext)
        exit(1)
    links.insert(0, "mpv")
    subprocess.run(links)
