defmodule NurseWeb.Router do
  use NurseWeb, :router
  # use Plug.ErrorHandler

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {NurseWeb.LayoutView, :root})
    plug(:protect_from_forgery)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(Auth.Plug)
  end

  scope "/", NurseWeb do
    pipe_through(:browser)

    get("/frotend/*path", PageController, :index)
    get("/uploads/:id", ImageController, :get_by_id)
  end

  # Other scopes may use custom stacks.
  scope "/api/:version/", NurseWeb do
    pipe_through([:api])

    scope "/snippets" do
      pipe_through(:auth)
      get("/", PageController, :get_snippets)
      post("/", PageController, :insert_snippet)
    end

    scope "/doc" do
      pipe_through(:auth)
      post("/", PageController, :receive_doc)
      get("/:id", PageController, :send_doc)
      get("/", PageController, :list_doc)
    end

    scope "/template" do
      pipe_through(:auth)
      post("/", PageController, :receive_temp)
      get("/:id", PageController, :send_temp)
      get("/", PageController, :list_temp)
    end
    
    scope "/auth" do
      post("/register", UserController, :register)
      post("/login", UserController, :login)

      pipe_through(:auth)
      get("/me", UserController, :auth_me)
    end

    pipe_through(:auth)

    scope "/user/" do
      get("/search_by_login/:login", UserController, :search_by_login)
      post("/profile_edit", UserController, :profile_edit)

      get("/profile/:login", UserController, :get_profile)
    end

    scope "/image/" do
      get("/get_all", ImageController, :all)
    end

    post("/upload_img", ImageController, :create)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: NurseWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  # def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
  #   IO.inspect(%{kind: kind, reason: reason, stack: stack})

  #   conn
  #   |> put_status(:unauthorized)
  #   |> put_view(NurseWeb.ErrorView)
  #   |> render("error.json", error: %{kind: kind, reason: reason, stack: stack})
  # end
end
