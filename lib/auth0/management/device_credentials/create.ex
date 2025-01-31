defmodule Auth0.Management.DeviceCredentials.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.DeviceCredential

  defmodule Params do
    defstruct device_name: nil,
              type: nil,
              value: nil,
              device_id: nil,
              client_id: nil

    @type t :: %__MODULE__{
            device_name: String.t(),
            type: String.t(),
            value: String.t(),
            device_id: String.t(),
            client_id: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: DeviceCredential.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, DeviceCredential.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
