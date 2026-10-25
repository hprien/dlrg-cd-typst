// ============================================================
// DLRG Corporate Design – Vorlage (DIN A4 quer)
// Erste Seite: grauer Adler-Hintergrund + roter Mustertext-Kasten
// Alle Seiten: roter Balken unten mit Webseite, Logo und Gliederung,
//              darunter die zentrierte Zeile "Stand: TT.MM.JJJJ" (Kompilierdatum)
// ============================================================

// Corporate-Design-Farben
#let cd-red = rgb("#e30613")
#let cd-yellow = rgb("#ffed00")
#let adler-gray = rgb("#dcdddf")

#let cd-font = "DLRG Univers 55 Roman"

#let bar-width = 297mm
#let bar-height = 10mm
#let adler-height = 180mm

#let left-margin = 2cm
#let right-margin = 2.5cm
#let top-margin = 2.5cm
#let bottom-margin = 2.5cm

#let dlrg-footer(url, gliederung, ressort, stand-text, bar-left-offset) = {
  place(bottom + left, dx: -bar-left-offset, dy: -10mm,
    // roter balken
    box(width: bar-width, height: bar-height, fill: cd-red, {
      // url
      place(horizon + left, dx: 7.5mm,
        text(fill: cd-yellow, size: 14pt, weight: "bold", url))

      // Logo
      place(horizon + left, dx: 216.5mm,
        image("res/dlrg.svg", height: 10.0mm))

      // Gliederung, Ressort
      place(horizon + left, dx: 258.5mm,
        align(left, text(fill: cd-yellow, size: 7.5pt, weight: "bold", tracking: 0.045em,
          stack(spacing: 1.5mm, gliederung, ressort))))
    }))

  // Datum
  place(bottom + center, dy: -0.55mm,
    text(fill: black, size: 11pt, "Stand: " + stand-text))
}

#let dlrg-cd-a4-quer-titlepage(
  title: "Mustertext Mustertext Mustertext",
  url: "ubstadt-weiher.dlrg.de",
  gliederung: "Ubstadt-Weiher e.V.",
  ressort: "Musterressort",
  stand: auto,
  body,
) = {
  let stand-text = if stand == auto {
    datetime.today().display("[day].[month].[year]")
  } else {
    stand
  }

  set text(font: cd-font, size: 11pt, lang: "de")
  set page(paper: "a4", flipped: true,
    margin: (top: top-margin, bottom: bottom-margin, left: left-margin, right: right-margin),
    footer: dlrg-footer(url, gliederung, ressort, stand-text, 20mm))

  // ---- Erste Seite ----
  place(bottom + right, dx: right-margin, dy: bottom-margin,
    // Adler
    image("res/adler.svg", height: adler-height))

  place(top + left, dx: -left-margin, dy: -top-margin+15mm,
    // Titel
    box(width: 140.3mm, fill: cd-red, radius: (right: 3mm),
      inset: (top: 7.5mm, left: 7.5mm, right: 7.5mm, bottom: 7.5mm),
      { set par(leading: 9.38mm); text(fill: cd-yellow, size: 28pt, weight: "bold", title) }))

  // ---- Folgende Seite ----
  pagebreak()
  body
}