(ns redqu.core
  (:require [clj-http.client :as client])
  (:require [clojure.string :as str])
  (:gen-class))

(def cli-options
  [["-s" "--sort"
    :default "top"
    :validate [(let [states #{"hot" "new" "top" "rising" "controversial" "h" "n" "t" "r" "c"}]
                 #(contains? states %))]]
   ["-t" "--time"
    :default "week"
    :validate [(let [states #{"hour" "day" "week" "month" "year" "all" "h" "d" "w" "m" "y" "a"}]
                 #(contains? states %))]]
   ["-h" "--help"]])

(defn snipe [x]
  (let [targets [#"https://i.redd.it/[a-z0-9]*.png"
                 #"https://i.redd.it/[a-z0-9]*.jpg"
                 #"https://i.redd.it/[a-z0-9]*.gif"
                 #"https://v.redd.it/[a-z0-9]*"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.jpg"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.png"
                 #"https://i.imgur.com/[a-zA-Z0-9]*.gifv"
                 #"https://redgifs.com/watch/[a-z]*"]]
    (map #(re-seq % x) targets)))

(defn refinery [x]
  (try
    (->> x
         (#(str "https://reddit.com/r/" % "/top.rss?limit=25;t=week"))
         client/get
         str
         snipe
         flatten
         (filter #(not (nil? %)))
         (str/join " ")
         println)
    (catch Exception e (println "Reddit 429 Too Many Requests. Try Again."))))

(defn -main [args]
  ;Graalvm complains
  (refinery args))
