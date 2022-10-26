using MagneticColloids
using Documenter

DocMeta.setdocmeta!(MagneticColloids, :DocTestSetup, :(using MagneticColloids); recursive=true)

makedocs(;
    modules=[MagneticColloids],
    authors="Coy Zimmermann",
    repo="https://github.com/czimm79/MagneticColloids.jl/blob/{commit}{path}#{line}",
    sitename="MagneticColloids.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://czimm79.github.io/MagneticColloids.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/czimm79/MagneticColloids.jl",
    devbranch="master",
)
