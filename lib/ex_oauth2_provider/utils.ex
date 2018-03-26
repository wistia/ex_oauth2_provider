defmodule ExOauth2Provider.Utils do
  @moduledoc false

  @doc false
  @spec remove_empty_values(Map.t) :: Map.t
  def remove_empty_values(map) when is_map(map) do
    map
    |> Enum.filter(fn {_, v} -> v != nil && v != "" end)
    |> Enum.into(%{})
  end

  @doc false
  @spec generate_token(Map.t) :: String.t
  def generate_token(opts \\ %{}) do
    token_size = Map.get(opts, :size, 32)
    string = :crypto.strong_rand_bytes(token_size)
    Base.encode16(string, case: :lower)
  end

  @spec belongs_to_clause(Ecto.Schema, atom, Ecto.Schema.t) :: Keyword.t
  def belongs_to_clause(module, association, struct) do
    %{owner_key: owner_key, related_key: related_key} = ExOauth2Provider.Utils.schema_association(module, association)
    value = Map.get(struct, related_key)
    Keyword.new([{owner_key, value}])
  end

  @spec schema_association(Ecto.Schema, atom) :: {atom, atom}
  def schema_association(module, association) do
    module.__schema__(:association, association)
  end

  @spec schema_belongs_to_opts(Ecto.Schema | nil) :: Keyword.t
  def schema_belongs_to_opts(nil), do: []
  def schema_belongs_to_opts(module), do: [type: module.__schema__(:type, :id)]
end
