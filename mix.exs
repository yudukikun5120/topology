defmodule Topology.MixProject do
  use Mix.Project

  def project do
    [
      app: :topology,
      description: "Returns the topology of a set.",
      version: "0.1.4",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        maintainers: ["Arai Yuzuki"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/yudukikun5120/topology"},
        source_url: "https://github.com/yudukikun5120/topology"
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        before_closing_body_tag: &before_closing_body_tag/1
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev]},
      {:excoveralls, "~> 0.10", only: :test}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp before_closing_body_tag(_) do
    """
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.13.19/dist/katex.min.css" integrity="sha384-beuqjL2bw+6DBM2eOpr5+Xlw+jiH44vMdVQwKxV28xxpoInPHTVmSvvvoPq9RdSh" crossorigin="anonymous">
    <script defer src="https://cdn.jsdelivr.net/npm/katex@0.13.19/dist/katex.min.js" integrity="sha384-aaNb715UK1HuP4rjZxyzph+dVss/5Nx3mLImBe9b0EW4vMUkc1Guw4VRyQKBC0eG" crossorigin="anonymous"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/katex@0.13.19/dist/contrib/auto-render.min.js" integrity="sha384-+XBljXPPiv+OzfbB3cVmLHf4hdUFHlWNZN5spNQ7rmHTXpd7WvJum6fIACpNNfIR" crossorigin="anonymous"
        onload="renderMathInElement(document.body);">
    </script>
    <script>
      document.addEventListener("DOMContentLoaded", function() {
          renderMathInElement(document.body, {
            delimiters: [
                {left: '$$', right: '$$', display: true},
                {left: '$', right: '$', display: false},
                {left: '\\(', right: '\\)', display: false},
                {left: '\\[', right: '\\]', display: true}
            ],
            throwOnError : false
          });
      });
    </script>
    """
  end
end
