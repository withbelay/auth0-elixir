defmodule Auth0.Management.Guardian.Twilio.Sms.Configuration.Get do
  @moduledoc """
  Documentation for Auth0 Management Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianTwilioConfiguration

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianTwilioConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianTwilioConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
