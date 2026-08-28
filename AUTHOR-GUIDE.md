# Author Guide

This package adapts the [Glossa LaTeX
files](https://github.com/guidovw/Glossalatex) for submissions to
*Philosophical Logic*. Both journals are published by the Open Library of
Humanities (OLH).

This guide explains how to prepare a manuscript with `PL.cls`. For current
journal policies and submission instructions, see the [Author
Guidelines](https://www.philosophical-logic.org/site/author-guidelines/),
[Journal Policies](https://www.philosophical-logic.org/site/journal-policies/),
and [Submissions page](https://www.philosophical-logic.org/submissions/).

## 1. Initial submission

Submit a review-ready PDF containing the complete manuscript, including all
tables, figures, and displayed formulas. Upload separate figure and
supplementary files as appropriate.

*Philosophical Logic* uses double-anonymous review. Use the default class mode:

```latex
\documentclass{PL}
```

Before submitting, check the finished PDF for:

- names, affiliations, email addresses, ORCIDs, biographies, and running heads;
- acknowledgements, funding details, or repository links that identify an
  author;
- self-citations phrased in a way that discloses authorship;
- author names or other identifying fields in PDF document properties; and
- identifying text inside figures, supplements, or linked files.

The default mode hides the author block and PDF author metadata. Anonymize all
other identifying material yourself.

## 2. Accepted manuscript

After acceptance, enable author information explicitly:

```latex
\documentclass[accepted]{PL}
```

Restore all author names, affiliations, contact details, and applicable
back-matter sections. Supply ORCIDs and editable source files as requested,
including the `.tex` source, `.bib` database, figures, and supplementary files.

To keep accepted-only material in the same source file, use:

```latex
\ifPLaccepted
% acknowledgements, funding details, or other identifying material
\fi
```

Use only fonts included in a standard LaTeX installation.

Use pdfLaTeX unless the manuscript requires Unicode input. XeLaTeX and
LuaLaTeX are also supported. The class supplies `amssymb` under every engine;
requesting it again in a manuscript is redundant but harmless.

## 3. Title, abstract, keywords, and headings

- Use title case for the article title.
- Use sentence case for numbered section and subsection headings.
- Include an abstract and keywords. There is no prescribed abstract word limit
  or keyword count.
- Do not place a word count beneath the title.

Apply these capitalization rules to ordinary words; retain the standard
capitalization of proper names, symbols, and technical notation.

## 4. Citations and references

Use natbib with `PL.bst`. `PL.cls` loads natbib and selects the bibliography
style automatically. Do not load natbib separately, use biblatex, or add a
`\bibliographystyle{...}` command.

Use standard natbib commands, for example:

```latex
\citet{marcus:1961}
\citep{tarski:1936}
\citep[89]{kripke:1963}
```

List works in a grouped parenthetical citation chronologically by ordering the
keys from oldest to newest:

```latex
\citep{tarski:1936,marcus:1961,kripke:1963,lewis:1973,haack:1976,fischer-servi:1977}
```

Provide complete and accurate data in the `.bib` file. Protect capitalization
that must survive bibliography processing—such as acronyms, proper names, and
formal-system names—with BibTeX braces. Enter a DOI as either a bare identifier
or a `doi.org` URL. End the manuscript with the database command only:

```latex
\bibliography{my-references}
```

The journal's bibliography style determines the formatting of the reference
list; do not hand-format it.

## 5. Tables, figures, and supplementary material

- Every table and figure must be numbered, captioned, cited in the text, and
  visible in the review PDF.
- Upload separate source or high-resolution figure files when requested.
- Keep labels and mathematical notation consistent between the prose, figures,
  tables, and source files.
- Clearly label and describe supplementary files, including formal-verification
  files, code, data, and computational materials.

## 6. Back matter

Include each applicable back-matter section. Omit identifying sections from
the anonymous review PDF and restore them in accepted mode.

Include the following sections as applicable, in the order shown. Always
include a competing-interests statement.

- **Ethics and consent** — include this when the research involves human
  participants, personal data, or other work requiring approval or consent.
  Identify the approving body and reference and describe consent as applicable.
- **Data availability or supplementary files** — identify relevant materials
  and persistent locations, where applicable.
- **AI-use declaration** — follow the current [OLH AI
  policy](https://www.openlibhums.org/site/ai-policy/).
- **Funding information** — identify funders and grants, where applicable.
- **Acknowledgements** — recognize assistance and contributions that do not
  qualify for authorship.
- **Authors' contributions** — state each author's contributions when required
  or appropriate.
- **Competing interests** — disclose all competing interests. If there are
  none, state: “The authors declare that they have no competing interests.” See
  the [OLH competing-interests
  policy](https://www.openlibhums.org/site/competing-interests/).

## 7. Help

For policy and submission questions, contact
<editorial@philosophical-logic.org>. When reporting a LaTeX problem, include
the TeX engine and version, the class version, a minimal example, and the
relevant `.log` output.
