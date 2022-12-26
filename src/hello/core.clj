(ns redqu.core
  (:require [remus :refer [parse-url parse-file]]))

(def cli-options
  [["-s" "--sort"
    :default "top"
    :validate [(let [states #{"hot" "new" "top" "rising" "controversial" "h" "n" "t" "r" "c"}]
               #(contains? states %))]
    ]
   ["-t" "--time"
    :default "week"
    :validate [(let [states #{"hour" "day" "week" "month" "year" "all" "h" "d" "w" "m" "y" "a"}]
                 #(contains? states %))]]
   ["-h" "--help"]])

(defn genred [x]
  (str "https://www.reddit.com/r/" x "/top.rss?limit=25;t=week"))
;(assert (= (genred "animemidriff") "https://www.reddit.com/r/animemidriff/top.rss?limit=25;t=week"))

(defn snipe [x]
  (let [targets [#"https://i.redd.it/[a-z0-9]*.png"
                 #"https://i.redd.it/[a-z0-9]*.jpg"
                 #"https://i.redd.it/[a-z0-9]*.gif"
                 #"https://v.redd.it/[a-z0-9]*"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.jpg"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.png"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.gifv"
                 #"https://redgifs.com/watch/[a-z]*"]]
  (map #(re-find % x) targets)))

(defn refinery [x]
  (->> x
       genred
       parse-url
       :feed
       :entries
       (mapcat :contents)
       (map :value)
       (mapcat snipe)
       (filter #(not (nil? %))))
)
