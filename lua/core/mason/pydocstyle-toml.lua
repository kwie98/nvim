return U.load({ "mason-core.package", "mason-core.managers.pip3" }, function(Pkg, pip3)
    return Pkg.new({
        name = "pydocstyle[toml]",
        desc = "Custom pydocstyle mason package with toml dependencies installed.",
        homepage = "https://www.pydocstyle.org/",
        languages = { Pkg.Lang.Python },
        categories = { Pkg.Cat.Linter },
        install = pip3.packages({ "pydocstyle[toml]", bin = { "pydocstyle" } }),
    })
end)
