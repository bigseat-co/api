defmodule BigseatWeb.Middleware.Authorized do
  @behaviour Absinthe.Middleware

  def call(resolution = %{context: %{current_person: _}}, _config) do
    resolution
  end

  def call(resolution, _config) do
    resolution
    |> Absinthe.Resolution.put_result({:error, not_authorized_error()})
  end

  defp not_authorized_error do
    %{message: "Not authorized"}
  end
end
