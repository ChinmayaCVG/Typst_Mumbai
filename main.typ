#import "@preview/in-dexter:0.7.2": *
#import "template2.typ": *

// --- TYPOGRAPHY & LAYOUT CONFIGURATION ---
// Note: Text parameters and paragraph parameters are kept in separate rules for strict compatibility.
#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en"
)

//#set text(font: "Libre Franklin", size: 11pt)
//#set text(font: "Inter", features: ("tnum",))
//#set text(font: "Menlo")

#set par(
  justify: true,
  leading: 0.65em
)

// --- TITLE PAGE ---
#align(center)[
  #text(size: 22pt, weight: "bold")[Daily Progress Report (DPR) 2026] \
  #v(0.2em)
  #text(size: 14pt, style: "italic")[Jai Mahakaal] \
  #v(0.5em)
  #line(length: 80%, stroke: 0.5pt + luma(150))
  #v(0.8em)

  #grid(
    columns: (auto, auto),
    column-gutter: 1em,
    row-gutter: 0.6em,
    align: (right, left),
    [*Author:*], [Chaitanya V. Grampurohit],
    [*Designation:*], [SE(P)],
    [*Location:*], [Sivasagar, Assam]
  )
  #v(2em)
]

// --- DOCUMENT OUTLINE ---
#outline(indent: 2em)
#pagebreak()

// --- PROJECT NAVIGATION & INDEXES ---
// 1. Active vs Archived Projects Breakdown
#pagebreak(weak: true)
#show-all-projects()

// 2. Detailed History Logs (Alphabetical Page Headers)
// Note: Page breaks are handled directly inside show-all-project-summaries()
#show-all-project-summaries()

#include "202609.typ"