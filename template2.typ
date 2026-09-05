// ==========================================
// TEMPLATE2.TYP - DPR & Project Management
// ==========================================

// --- GLOBAL STATE & DICTIONARIES ---
#let project-state = state("projects", ())
#let tag-state = state("tags", ())

// --- CUSTOM MACROS ---

/// Register an active or archived project entry
#let register-project(name, status: "Active", details: "") = {
  project-state.update(projects => {
    projects.push((
      name: name,
      status: status,
      details: details
    ))
    projects
  })
}

/// Tag logger for indexed engineering items / equipment tags
#let log-tag(tag-id, description, status: "OK") = {
  tag-state.update(tags => {
    tags.push((
      id: tag-id,
      desc: description,
      status: status
    ))
    tags
  })
  // Render inline badge
  box(
    fill: rgb("#eef2f7"),
    inset: (x: 4pt, y: 2pt),
    radius: 3pt,
    stroke: 0.4pt + rgb("#cbd5e1")
  )[#text(size: 8.5pt, weight: "medium", font: "Menlo")[#tag-id]]
}

// --- DISPLAY COMPONENTS (Typst 0.11+ Compatible) ---

/// Render overview matrix of all registered projects
#let show-all-projects() = {
  v(1em)
  text(size: 14pt, weight: "bold", fill: rgb("#1a2b4c"))[Active & Archived Projects]
  v(0.5em)
  
  // Modern Context expression replacing deprecated locate()
  context {
    let projects = project-state.get()
    if projects.len() == 0 [
      #text(fill: luma(120), style: "italic")[No projects logged yet.]
    ] else {
      table(
        columns: (1.5fr, 1fr, 3fr),
        align: (left, center, left),
        stroke: (x, y) => if y == 0 { (bottom: 1pt + luma(80)) } else { 0.4pt + luma(200) },
        fill: (x, y) => if y == 0 { rgb("#f1f5f9") } else if calc.even(y) { rgb("#f8fafc") } else { none },
        inset: 6pt,
        [*Project Name*], [*Status*], [*Details / Scope*],
        ..projects.map(p => (
          [*#p.name*],
          if p.status == "Active" [
            #text(fill: rgb("#15803d"), weight: "bold")[Active]
          ] else [
            #text(fill: rgb("#64748b"))[#p.status]
          ],
          [#p.details]
        )).flatten()
      )
    }
  }
  v(1em)
}

/// Render detailed project summaries with page breaks
#let show-all-project-summaries() = {
  context {
    let projects = project-state.get()
    for p in projects {
      pagebreak(weak: true)
      heading(level: 2)[Project Summary: #p.name]
      v(0.5em)
      
      grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 0.5em,
        [*Status:*], [#p.status],
        [*Overview:*], [#p.details]
      )
      
      v(1em)
      line(length: 100%, stroke: 0.5pt + luma(200))
    }
  }
}

/// Print grouped log of registered equipment tags
#let print_taglog_grouped() = {
  v(1em)
  heading(level: 2)[Registered Equipment Tags]
  v(0.5em)
  
  context {
    let tags = tag-state.get()
    if tags.len() == 0 [
      #text(fill: luma(120), style: "italic")[No tags registered.]
    ] else {
      table(
        columns: (1.2fr, 2.5fr, 1fr),
        align: (left, left, center),
        stroke: 0.4pt + luma(200),
        fill: (x, y) => if y == 0 { rgb("#f1f5f9") } else { none },
        inset: 6pt,
        [*Tag ID*], [*Description*], [*Condition*],
        ..tags.map(t => (
          [#text(font: "Menlo", size: 9pt)[#t.id]],
          [#t.desc],
          [#t.status]
        )).flatten()
      )
    }
  }
}