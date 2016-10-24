par(mar = c(1, 1, 1, 1), bg="violetred4")
circlize::chordDiagram(matrix(1, 50, 50),
                       col="white",
                       symmetric = TRUE,
                       transparency = 0.85,
                       annotationTrack = NULL)