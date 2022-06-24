defmodule Ec2Mock.Ec2InstanceMetadata do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    request_list = String.split(conn.request_path, "/", trim: true)
    lookup = serve_metadata(request_list)

    case lookup do
      :not_found ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(404, error404())

      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, lookup)
    end
  end

  def serve_metadata(requestlist) do
    keys = List.delete(requestlist, "latest")
    lookup = :nested.get(keys, metadata(), :not_found)

    case lookup do
      :not_found ->
        :not_found

      value ->
        case is_map(value) do
          true ->
            Enum.map(
              Map.keys(value),
              fn key ->
                case is_map(Map.get(value, key)) do
                  true -> "#{key}/\n"
                  false -> "#{key}\n"
                end
              end
            )

          false ->
            value
        end
    end
  end

  def metadata() do
    {:ok, file} = File.read("priv/metadata.json")
    {:ok, result} = JSON.decode(file)
    result
  end

  def error404() do
    "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"
          \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
      <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">
       <head>
        <title>404 - Not Found</title>
       </head>
       <body>
        <h1>404 - Not Found</h1>
       </body
      </html>"
  end
end
