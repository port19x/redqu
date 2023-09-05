#!/bin/awk -f

function help(arg)
{
    print "Usage: redqu sub sort time\
    \nExample: mpv $(redqu cats top week)\
    \nValid sort parameters: hot new top rising controversial\
    \nValid time parameters: hour day week month year all\
    \nTop of week is the default\n\
    \nIf you're seeing this message in error, please open an Issue:\
    \nhttps://github.com/port19x/redqu/issues"
    exit 1
}

function getsort(arg)
{
    switch (substr(arg,1,1)) {
    case "h":
        return "/hot.rss"
    case "n":
        return "/new.rss"
    case "t":
        return "/top.rss"
    case "r":
        return "/rising.rss"
    case "c":
        return "/controversial.rss"
    default:
        help()
    }
}

function gettime(arg)
{
    switch (substr(arg,1,1)) {
    case "h":
        return "?t=hour"
    case "d":
        return "?t=day"
    case "w":
        return "?t=week"
    case "m":
        return "?t=month"
    case "y":
        return "?t=year"
    case "a":
        return "?t=all"
    default:
        help()
    }
}

BEGIN {
    subreddit = ARGV[1]
    sort = getsort(ARGV[2])
    if (sort == "/top.rss" || sort == "/rising.rss" || sort == "/controversial.rss")
        time = gettime(ARGV[3])
    endpoint = "/r/" subreddit sort time
    print endpoint
    delete ARGV

    target = "/inet/tcp/0/localhost/111"
    agent = "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0"
    payload = "GET " endpoint " HTTP/1.1" "\r\n" "Host: www.reddit.com:443" "\r\n" "User-Agent: gawk" "\r\n" "Connection:close" "\r\n\r\n"
    print payload |& target
    while ((target |& getline line) > 0)
        response = response "\n" line
    close(target)

    RS="&quot;"
    print response
}

/https:\/\/(v|i).redd.it\/[a-z0-9]*(.(png|jpg|gif))?/ {print}
/https:\/\/i.imgur.com\/[a-zA-Z0-9]*.(jpg|png|gifv)/ {print}
/https:\/\/redgifs.com\/watch\/[a-z]*/ {print}
