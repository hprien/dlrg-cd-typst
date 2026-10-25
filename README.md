# dlrg-cd-typst
DLRG Corporate Design Typst Templates

## Benutzung

```typst
#import "templates/dlrg-cd-a4-quer-titlepage.typ": dlrg-cd

#show: dlrg-cd.with(
  title: "Mustertext Mustertext Mustertext",  // roter Kasten auf der 1. Seite
  url: "ubstadt-weiher.dlrg.de",              // Webseite im roten Balken
  gliederung: "Ubstadt-Weiher e.V.",          // rechts neben dem Logo, Zeile 1
  ressort: "Musterressort",                   // rechts neben dem Logo, Zeile 2
  // stand: "25.10.2026",                    // optional; Voreinstellung = Kompilierdatum
)

Haupttext …
```

Kompilieren (PDF; die DLRG-Schrift liegt in `templates/res/dlrg-font`):

```bash
typst compile --font-path templates/res/dlrg-font main.typ main.pdf
```