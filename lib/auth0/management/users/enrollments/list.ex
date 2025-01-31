defmodule Auth0.Management.Users.Enrollments.List do
  @moduledoc """
  Documentation for Auth0 Management Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Enrollments

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: Enrollments.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Enrollments.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
