defmodule Janrain do
  require Logger

  @moduledoc """
  Provides some convenient functions for working with Janrain social login, Guardian, and Phoenix.

  In your Janrain callback function grab the token that's passed to you and then:

  user_logged_in = Janrain.authenticate_user_with token
  case user_logged_in do
    {:ok, profile_info}
      conn
      |> Guardian.Plug.sign_in(identifier)
      |> redirect to: "/"
    {:failed}
      conn
      |> put_flash(:error, "Uh oh. We failed to log you in...")
      |> render("login.html")
  end
  """

  @doc """
  Authenticates a user via a `token` provided by Janrains callback and attempts to get their profile info
  You would generally call this from your janrain callback URL.

  Returns `{:ok, profile_info}`.

  Returns `{:failed}`.

  """
  def authenticate_user_with(token) do
    token
    |> get_auth_info
    |> parse_auth_info
  end

  defp get_auth_info(token) do
    Logger.debug("Going to API URL #{api_url}")
    case HTTPoison.post(api_url, {:form, generate_payload_for(token)}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{body: body}} ->
        Logger.error "Failed to get auth_info: #{body}"
        {:failed}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error "Failed to get auth_info: #{reason}"
        {:failed}
    end
  end

  defp parse_auth_info(body) do
    case body do
      {:ok, body} ->
        Poison.decode! body
      _ -> {:failed}
    end
  end


  defp api_url do
    System.get_env("JANRAIN_API_URL")
  end

  defp api_key do
    System.get_env("JANRAIN_API_KEY")
  end

  defp generate_payload_for(token) do
    [apiKey: api_key, token: token]
  end
end
