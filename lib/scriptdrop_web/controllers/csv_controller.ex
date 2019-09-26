defmodule ScriptdropWeb.CsvController do
  use ScriptdropWeb, :controller


  alias Scriptdrop.Company.{Pharmacy, Courier}
  alias Scriptdrop.Customer.{Patient, Order}
  alias Scriptdrop.Repo

  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def export(conn, _params) do
    #    query = from(
    #      t in Task,
    #      join: u in User,
    #      where: t.user_id == u.id,
    #      join: e in Entry,
    #      where: e.task_id == t.id,
    #      group_by: t.id,
    #      select: %{
    #        t |
    #        total_time: sum(e.duration)
    #      }
    #    )
    #
    #    tasks = Repo.all(query)
    #    tasks = Repo.preload(tasks, :users)
    #    csv = List.foldl(
    #      tasks,
    #      [],
    #      fn task, acc ->
    #        [
    #          [task.users.name, task.task_name, task.total_time.secs] | acc
    #        ]
    #      end
    #    )


    csv = from(
      o in Order,
      join: p in assoc(o, :pharmacy),
      join: y in assoc(o, :patient),
      join: a in assoc(y, :address),
      join: c in assoc(p, :courier),
      select: [y.name, a.street, p.name, o.delivered, o.undelieverable, c.name]
    )
    |> Repo.all()
    csv = [["Patient name", "Patient Address", "Pharmacy Name", "Delivered?", "Undeliverable?", "Courier Company"] | csv ]


    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"A Real CSV.csv\"")
    |> send_resp(200, csv_content(csv))
  end

  defp csv_content(report) do
    csv_content = report

                  |> CSV.encode
                  |> Enum.to_list
                  |> to_string
  end
end


