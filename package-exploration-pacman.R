# Pacman package fun

# Vignette can be found here: https://cran.r-project.org/web/packages/pacman/vignettes/Introduction_to_pacman.html

pacman::p_load(XML, devtools, RCurl, fakePackage, SPSSemulate)

pacman::p_load_gh("Dasonk/githubSearch", "trinker/regexr", "hadley/httr@v0.4")

p_unload(lattice)

p_update()