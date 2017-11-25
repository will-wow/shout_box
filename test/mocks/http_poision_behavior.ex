defmodule ShoutBox.HTTPoisonBehavior do
  @callback get!(
    HTTPoison.binary,
    HTTPoison.headers,
    Keyword.t) :: 
      HTTPoison.Response.t | HTTPoison.AsyncResponse.t

  @callback post!(
    HTTPoison.binary,
    HTTPoison.body,
    HTTPoison.headers,
    Keyword.t) :: 
      HTTPoison.Response.t | HTTPoison.AsyncResponse.t
end