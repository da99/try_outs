(ns hello-world.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(defroutes app-routes
  (context "/map" []
    (GET "/" [] "The map")
    (GET "/1" [] "The map: 1")
    (context "/1/2" []
      (GET "/" [] "The map: 1/2")
      (GET "/3" [] "The map: 1/2/3")
    )
  )
  (GET "/" [] "<strong>Yo, yo</strong>... ahoy me matey.")
  (route/not-found "Not Found")
) ; -- defroutes

(def app
  (wrap-defaults app-routes site-defaults)
) ; -- def app
