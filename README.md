# Philosophical Logic LaTeX

This package adapts the [Glossa LaTeX
files](https://github.com/guidovw/Glossalatex) for submissions to
[*Philosophical Logic*](https://www.philosophical-logic.org/). Both journals are
published by the Open Library of Humanities (OLH).

- [Author Guide](AUTHOR-GUIDE.md)
- [Journal author guidelines](https://www.philosophical-logic.org/site/author-guidelines/)
- [Submit a manuscript](https://www.philosophical-logic.org/submissions/)
- Editorial contact: <editorial@philosophical-logic.org>

## Quick start

Keep these four files in the same directory:

- `PL.cls`
- `PL.bst`
- `PL-template.tex`
- `sample.bib`

Copy `PL-template.tex` to a new filename and edit the copy. Keep `PL.cls` and
`PL.bst` beside the article, and replace `sample.bib` with the article's own
bibliography database.

An initial submission is anonymous by default:

```latex
\documentclass{PL}
```

Use the accepted-manuscript mode only after acceptance:

```latex
\documentclass[accepted]{PL}
```

The default mode hides the author block and clears PDF author metadata, but
authors must anonymize all other material. See the [Author Guide](AUTHOR-GUIDE.md)
for the manuscript checklist.

### Compile

With `latexmk` and pdfLaTeX:

```sh
latexmk -pdf PL-template.tex
```

The equivalent manual sequence is:

```sh
pdflatex PL-template.tex
bibtex PL-template
pdflatex PL-template.tex
pdflatex PL-template.tex
```

pdfLaTeX is recommended; XeLaTeX and LuaLaTeX are also supported for
manuscripts requiring Unicode input.

### References

Use natbib with the journal's `PL.bst` style. `PL.cls` loads natbib and selects
`PL.bst` automatically, so do not load natbib separately or add a
`\bibliographystyle` command. End the manuscript with:

```latex
\bibliography{my-references}
```

Biblatex is not supported by the author package.

## Package contents

- `PL.cls` — submission document class
- `PL.bst` — BibTeX bibliography style
- `PL-template.tex` and `PL-template.pdf` — example source and compiled PDF
- `sample.bib` — example BibTeX database
- `AUTHOR-GUIDE.md` — author instructions
- `LICENSE.md` — licensing and maintainer information

This is a submission class. OLH's production vendor converts accepted source
into the journal's publication PDF and XML; the class does not reproduce the
final journal design.

## License

This work is derived from Guido Vanden Wyngaerd's
[Glossalatex](https://github.com/guidovw/Glossalatex) files and is distributed
under the LaTeX Project Public License, version 1.3 or later. The Current
Maintainer is the *Philosophical Logic* editorial team. See
[LICENSE.md](LICENSE.md) for details.
