Rails.application.routes.draw do
  get("/", { :controller => "misc", :action => "homepage" })

  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest", { :controller => "directors", :action => "min_dob" })

  get("/directors", { :controller => "directors", :action => "index" })
  post("/insert_director", { :controller => "directors", :action => "create" })
  get("/directors/:path_id", { :controller => "directors", :action => "show" })
  get("/modify_director/:path_id", { :controller => "directors", :action => "update" })
  get("/delete_director/:path_id", { :controller => "directors", :action => "destroy" })

  get("/movies", { :controller => "movies", :action => "index" })
  post("/insert_movie", { :controller => "movies", :action => "create" })
  get("/movies/:path_id", { :controller => "movies", :action => "show" })
  get("/modify_movie/:path_id", { :controller => "movies", :action => "update" })
  get("/delete_movie/:path_id", { :controller => "movies", :action => "destroy" })
  
  get("/actors", { :controller => "actors", :action => "index" })
  post("/insert_actor", { :controller => "actors", :action => "create" })
  get("/actors/:path_id", { :controller => "actors", :action => "show" })
  get("/delete_actor/:path_id", { :controller => "actors", :action => "destroy" })
end
