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

function request(domain, endpoint)
{
    target = "/inet/tcp/0/" domain "/80"
    payload = "GET " endpoint " HTTP/1.1" "\r\n" "Host: " domain ":80" "\r\n" "User-Agent: gawk" "Connection:close" "\r\n\r\n"
    print payload |& target

    while ((target |& getline line) > 0)
        response = response "\n" line
    close(target)

    return response
}

BEGIN {
    root = "reddit.com"
    #root = "blog.fefe.de"
    subreddit = ARGV[1]
    sort = getsort(ARGV[2])
    if (sort == "/top.rss" || sort == "/rising.rss" || sort == "/controversial.rss")
        time = gettime(ARGV[3])
    endpoint = "/r/" subreddit sort time
    #endpoint = "/"
    delete ARGV
    print request(root, endpoint)
    exit 0
    RS="&quot;"
}
/https:\/\/(v|i).redd.it\/[a-z0-9]*(.(png|jpg|gif))?/ {print}
/https:\/\/i.imgur.com\/[a-zA-Z0-9]*.(jpg|png|gifv)/ {print}
/https:\/\/redgifs.com\/watch\/[a-z]*/ {print}
