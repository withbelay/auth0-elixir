defmodule Auth0.Management.Hooks.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Hook

  defmodule Params do
    defstruct name: nil,
              enabled: nil,
              script: nil,
              dependencies: nil

    @type t :: %__MODULE__{
            name: String.t(),
            enabled: boolean,
            script: String.t(),
            dependencies: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Hook.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Hook.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
