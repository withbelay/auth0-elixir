defmodule Auth0.Management.Organizations.Invitations.Delete do
  @moduledoc """
  Documentation for Auth0 Management Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type invitation_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id

  """
  @spec execute(endpoint, id, invitation_id, config) :: response
  def execute(endpoint, id, invitation_id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{invitation_id}", invitation_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
