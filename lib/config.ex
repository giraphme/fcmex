defmodule Fcmex.Config do
  @moduledoc ~S"
    A configuration for FCM
  "

  def new do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "key=#{server_key()}"}
    ]
  end

  def server_key do
    retrieve_server_key() || raise "FCM Server key is not found on your environment variables"
  end

  defp retrieve_server_key() do
    case Application.get_env(:fcmex, :server_key) do
      {:system, env} -> retrieve_on_run_time(env)
      server_key when is_binary(server_key) -> server_key
      _ -> retrieve_on_run_time("FCM_SERVER_KEY")
    end
  end

  defp retrieve_on_run_time(key) do
    System.get_env(key)
  end
end
