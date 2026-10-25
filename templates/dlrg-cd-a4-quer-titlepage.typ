// ============================================================
// DLRG Corporate Design – Vorlage (DIN A4 quer)
// Erste Seite: grauer Adler-Hintergrund + roter Mustertext-Kasten
// Alle Seiten: roter Balken unten mit Webseite, Logo und Gliederung,
//              darunter die zentrierte Zeile "Stand: TT.MM.JJJJ" (Kompilierdatum)
// Schrift: "DLRG Univers 55 Roman" (res/dlrg-font)
// Farben:  Rot #e30613, Gelb #ffed00, Adler #dcdddf
// ============================================================

// Corporate-Design-Farben
#let cd-red = rgb("#e30613")
#let cd-yellow = rgb("#ffed00")
#let cd-gray = rgb("#dcdddf")

// Schrift – Dateien in res/dlrg-font, laden per `--font-path res/dlrg-font`
// (aus dem Verzeichnis templates/) bzw. `--font-path templates/res/dlrg-font`
#let cd-font = "DLRG Univers 55 Roman"

// Bildmaße (bezogen auf die Referenzgestaltung, DIN A4 quer: 297 × 210 mm)
#let bar-width = 297mm       // roter Balken über volle Seitenbreite
#let bar-height = 9.3mm      // Balkenhöhe
#let adler-height = 180mm    // Adler: rechte/untere Kante bündig zur Seitenkante

// Unterer Bereich: Balken + Zeile "Stand:" (wird über dem Inhalt gezeichnet)
#let dlrg-footer(url, gliederung, ressort, stand-text, bar-left-offset) = {
  // Roter Balken über die volle Seitenbreite (rechts/links bis zur Seitenkante)
  place(bottom + left, dx: -bar-left-offset, dy: -9.85mm,
    box(width: bar-width, height: bar-height, fill: cd-red, {
      // Webseite, gelb, links im Balken
      place(top + left, dx: 9.7mm, dy: 3.5mm,
        text(fill: cd-yellow, size: 14pt, weight: "bold", url))
      // Logo (DLRG | Wortmarke), Mittellinie des Balkens
      place(horizon + left, dx: 216.5mm, dy: 0.75mm,
        image("res/dlrg.svg", height: 10.0mm))
      // Gliederung + Ressort, gelb, zweizeilig rechts vom Trennstrich
      place(top + left, dx: 258.5mm, dy: 2.44mm,
        align(left, text(fill: cd-yellow, size: 7.5pt, weight: "bold", tracking: 0.045em,
          stack(spacing: 1.85mm, gliederung, ressort))))
    }))
  // "Stand:" – zentriert im Textbereich (wie in Word), Kompilierdatum
  place(bottom + center, dy: -0.55mm,
    text(fill: black, size: 11pt, "Stand: " + stand-text))
}

// Die Vorlage:
//
//   #import "templates/dlrg-cd-a4-quer-titlepage.typ": dlrg-cd
//   #show: dlrg-cd.with(title: "...", url: "...", gliederung: "...", ressort: "...")
//   Haupttext …
//
// Ersetzbare Texte: title (Kasten auf S. 1), url (Balken links),
// gliederung + ressort (Balken rechts). `stand` ist per Voreinstellung
// das Datum der Kompilierung (TT.MM.JJJJ).
#let dlrg-cd(
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
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2.5cm),
    footer: dlrg-footer(url, gliederung, ressort, stand-text, 20mm))

  // ---- Erste Seite ----
  // Grauer Adler: rechte Kante an die rechte Seitenkante,
  // untere Kante an die untere Seitenkante (Textkörper-Ränder ausgeglichen)
  place(bottom + right, dx: 25mm, dy: 25mm,
    image("res/adler.svg", height: adler-height))
  // Roter Mustertext-Kasten: bündig mit der linken Seitenkante,
  // nur die rechten Ecken abgerundet
  place(top + left, dx: -20mm, dy: 15.0mm,
    box(width: 140.3mm, fill: cd-red, radius: (right: 3.1mm),
      inset: (top: 8.0mm, left: 9.25mm, right: 9.25mm, bottom: 7.55mm),
      { set par(leading: 9.38mm); text(fill: cd-yellow, size: 28pt, weight: "bold", title) }))

  // Haupttext beginnt auf Seite 2
  pagebreak()
  body
}