(ns redqu.core
  (:require [clj-http.client :as client]
            [clojure.string :as str])
  (:gen-class))

(defn timeoptmap
  [time]
  (cond (or (= time "hour") (= time "h")) "?t=hour"
        (or (= time "day") (= time "d")) "?t=day"
        (or (= time "month") (= time "m")) "?t=month"
        (or (= time "year") (= time "y")) "?t=year"
        :else "?t=week"))

(defn sortoptmap
  [sort time]
  (cond (or (= sort "hot") (= sort "h")) "/hot.rss"
        (or (= sort "new") (= sort "n")) "/new.rss"
        (or (= sort "rising") (= sort "r")) "/rising.rss"
        (or (= sort "controversial") (= sort "c")) (str "/controversial.rss" (timeoptmap time))
        :else (str "/top.rss" (timeoptmap time))))

(defn rsslinkbuilder [args]
  (let [sub  (first args)
        sort (fnext args)
        time (fnext (next args))]
    (->> sub
         (str "https://reddit.com/r/")
         (#(str % (sortoptmap sort time))))))

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
         client/get
         str
         snipe
         flatten
         (filter #(not (nil? %)))
         (str/join " ")
         println)
    (catch Exception e (println "Reddit 429 Too Many Requests. Try Again."))))

(defn -main [& args]
  ;Graalvm complains
  (println (rsslinkbuilder args)))
