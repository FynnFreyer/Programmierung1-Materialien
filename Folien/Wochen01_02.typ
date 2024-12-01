#import "@preview/polylux:0.3.1": *
#import "@preview/colorful-boxes:1.3.1": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond, ellipse
#import themes.university: *

#set text(
  hyphenate: true,
  lang: "de"
)

#show: university-theme.with(
  color-a: rgb("#76B900"),
  color-b: rgb("#0082D1"),
  color-c: rgb("#EDf5DF"),
  short-title: "Programmierung 1 IKG",
  short-date: "WiSe 24/25"
)

#show link: underline

#title-slide(
  title: "Programmierung 1",
  subtitle: "Wochen 1-2: Allgemeines und Grundlagen",
  date: "10.10.2024",
  institution-name: "HTW Berlin"
)

#slide(title: "Allgemeines", new-section: "Organisatorisches")[

- Selber programmieren wichtig -> 1 SWS VL, 3 SWS PCÜ
- Präsenzzeit reicht *nicht*!
  - Zusatzaufgaben zum selber üben, Tutorium 
  - Hausaufgaben - Prüfung ab 75% Abgaben, 50% Punkte
  - Fragen stellen (Forum, SL)! 
- Prüfungsleistung: Wie Hausaufgabe, aber größer (2 Wochen)
- Bonuspunkte für Verbesserungsvorschläge (siehe #link("https://github.com/dabrowskiw/Programmierung1-Materialien/tree/IKGneu")[#underline("git-repo")]): 2.5% für Vorschlag, 5% für Code (mail, pull request), max. 2/Semester

]

#slide(title: "Fahrplan")[

- Was ist allgemein Programmierung?
- Visuelle Übungen mit "Scratch" und Flussdiagrammen (2 Wochen)
- "Fingerübungen" mit Java (ca. 4 Wochen)
- Anwendungsaufgaben (ca. 6-8 Wochen):
  - Arrays
  - Grundlagen der Objektorientierung
  - Externe Bibliotheken am Beispiel von Plots
- Puffer
- Übungen liegen diesmal blöd - Vorschlag: Versetzen

]

#slide(title: "Was tun wir hier eigentlich?", new-section: "Allgemeines")[

- Grundlagen des Programmierens (in Java) beherrschen
- Einfache Algorithmen selber ausdenken und implementieren
- Grundbegiffe der (objektorientierten) Programmierung beherrschen
- Desillusionierung:
  - Programmieren lernen ist zeitaufwendig!
  - Ich kann es Ihnen nicht beibringen!
- Wichtig: Ab Anfang konsequent mitmachen, gerne Laptop in die VL mitbringen

]


#slide(title: "Was ist Programmierung?")[

- Wie mit jemandem reden, der gar nicht mitdenkt
- Anweisungen müssen extrem exakt formuliert sein
- Einfachste Herangehensweise:
  - Problem selber lösen
  - Sich selber dabei beobachten ("warum tue ich das gerade?")
  - Beobachtungen idiotensicher zum Nachkochen aufschreiben
-> Algorithmus: Finite Abfolge von ausführbaren Anweisungen

]

#slide(title: "Beispiel-Algorithmus", new-section: "Algorithmen")[

- Schreiben Sie ein Programm, das mich zur Tür bringt
- Erlaubte Anweisungen:
  - "Schritt": Ich mache einen Schritt
  - "Drehen": Ich drehe mich um 90 Grad nach links
- Freiwillige/r an der Tafel
- Bitte mich nicht umbringen!

]


#slide(title: "Wie schreibt man das auf?")[

  #place(top+left, dx: -20pt, box(width: 280pt, clip: true, image(width: 800pt, "Bilder/flow.png")))

  #place(top+right, dx: 40pt, image(width: 500pt, "Bilder/flow_xkcd.png"))
]

#slide(title: "Beispiel: Zur Tür laufen")[
  Annahme: Ich schaue schon Richtung Tür.

  #uncover(2)[
    #diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0,0), [Start], radius: 1.3em),
      edge("-|>"),
      node((0,1), shape: diamond, align(center)[Vor der Tür?]),
      edge("r", "-|>", [nein]),
      edge("d", "-|>", [ja]),
      node((1,1), [Mache einen Schritt], corner-radius: 5pt),
      edge((1,1), (1,0.5), (0,0.5), (0,1), "-|>"),
      node((0,2), [Öffne die Tür], corner-radius: 5pt),
      edge("r", "-|>"),
      node((1,2), [Ende], radius: 1.3em),
    )
  ]
]

#slide(title: "Beispiel: Gewichtszone")[
  Über- bzw. Untergewicht ist an BMI schätzbar

  $"BMI" = frac("Körpergewicht in kg", "Körpergröße in m"^2)$

  #table(columns: 3,
    [*Geschlecht*], [*BMI*], [*Zustand*],
    [Männlich], [\<20], [Untergewicht],
    [Männlich], [20-24.9], [Normalgewicht],
    [Männlich], [\>24.9], [Übergewicht],
    [Weiblich], [\<19], [Untergewicht],
    [Weiblich], [19-23.9], [Normalgewicht],
    [Weiblich], [\>23.9], [Übergewicht],
  )
]

#slide(title: "Beispiel: Gewichtszone II")[
  #place(top+left)[
    #diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      node((0,0), shape: ellipse, width: 7em, height: 3em, [w=weight\ h=height]),
      node((1,0), height: 2em, [$"BMI"=frac("w", "h*h")$]),
      node((1,1), shape: diamond, height: 2em, align(center)[BMI < 20?]),
      node((1,2), shape: diamond, height: 2em, align(center)[BMI <= 24.9?]),
      node((2,1), shape: ellipse, width: 7em, height: 2em, [Untergewicht]),
      node((2,2), shape: ellipse, width: 7em, height: 2em, [Normalgewicht]),
      node((0,2), shape: ellipse, width: 7em, height: 2em, [Übergewicht]),
      edge((0,0), (1,0), "-|>"),
      edge((1,0), (1,1), "-|>"),
      edge((1,1), (2,1), "-|>", [ja]),
      edge((1,2), (2,2), "-|>", [ja]),
      edge((1,2), (0,2), "-|>", [nein]),
      edge((1,1), (1,2), "-|>", [nein]),
    )
  ]

  #uncover(2)[
    #place(bottom, dy: 15em)[
      Aufgabe: Erweitern um Geschlecht. Gruppen (2 oder 3), 10 Minuten
    ]
  ]
]

#slide(title: "Beispiel: Code reuse")[
  #place(top+left, dx:-40pt)[
    #place(top+left, dy:-1em, [*f(w, h, uglimit, nglimit)*])
    #box(stroke: black, inset: 20pt,
      [
        #diagram(
          node-stroke: 1pt,
          edge-stroke: 1pt,
          node((0,1), shape: ellipse, width: 6em, height: 7em, [w=weight\ h=height\ uglimit\ nglimit]),
          node((1,0.25), height: 2em, [$"BMI"=frac("w", "h*h")$]),
          node((1,1), shape: diamond, height: 2em, align(center)[BMI < 20?]),
          node((1,1.75), shape: diamond, height: 2em, align(center)[BMI <= 24.9?]),
          node((2,1), shape: ellipse, width: 6em, height: 3em, [Unter-\ gewicht]),
          node((2,1.75), shape: ellipse, width: 6em, height: 3em, [Normal-\ gewicht]),
          node((0,1.75), shape: ellipse, width: 6em, height: 2em, [Übergewicht]),
          edge((0,1), (1,0.25), "-|>"),
          edge((1,0.25), (1,1), "-|>"),
          edge((1,1), (2,1), "-|>", [ja]),
          edge((1,1.75), (2,1.75), "-|>", [ja]),
          edge((1,1.75), (0,1.75), "-|>", [nein]),
          edge((1,1), (1,1.75), "-|>", [nein]),
        )
      ]
    )
  ]
  #place(top+right, dx:40pt)[
    #diagram(
        node-stroke: 1pt,
        edge-stroke: 1pt,
        node((0,0), shape: ellipse, width: 3em, height: 3em, [w, h\ sex]),
        node((0,0.75), shape: diamond, width: 3em, height: 2em, [sex=m?]),
        node((0, 1.5), [f(w, h, 19, 23.9)]),
        node((0, 2.25), [f(w, h, 20, 24.9)]),
        edge((0,0), (0,0.75), "-|>"),
        edge((0,0.75), (0,1.5), "-|>", [nein]),
        edge((0,0.75), (0.6, 0.75), (0.6, 2.25), (0,2.25), "-|>", [ja], label-pos: 0.1),
      )
  ]
]

#slide(title: "Beispiel: Steuersatz berechnen")[

  In zweier- oder dreier-Gruppen, 10 Minuten

  #table(
    columns: 2,
    [*Einkommen*], [*Steuersatz*],
    [0-744€], [0%],
    [745-14.753€], [14%-24%],
    [14.754€-57.918€], [24%-42%],
    [57.919€-274.612€], [42%],
    [>274.612€], [45%],
  )

]

/*#slide(title: "Frage!")[

- Dreier-Gruppen, 10 Minuten
- Danach: Zufallsauswahl, Antwort von jemandem anders erzählen
- Vorteile: 
  - Kennenlernen
  - Bezug zum Thema verstehen (für mich und für die anderen)
- Experiment - Kein Bock = auch OK :)
- Frage: "Was wollen Sie mit dem hier gelernten erreichen, was motiviert Sie?"

]*/

#slide(title: "Scratch", new-section: "Scratch")[

  - Einfache, block-basierte Programmiersprache
  - #link("https://scratch.mit.edu")[Online] verfügbar
  - Ziele:
    - Grundlegende Algorithmik üben
    - An Variablen und Methoden gewöhnen
    - Hoffentlich Spaß
  - Zusatzaufgabe (max. 15% Bonus-Punkte)
    - (Sehr einfaches) Spiel überlegen
    - Semesterbegleitend implementieren
    - Am Ende des Semesters präsentieren
    - Zusatzressourcen: #link("https://riskylab.com/tilemap/")[Karteneditor], #link("https://craftpix.net/freebies/")[Grafiken]
]

#slide(title: "Grundlegende Begriffe")[

  - Sprite
    - Etwas, was sich bewegen kann
    - Hat eigene Logik
    - Costumes definieren mögliche Aussehen
  - Stage
    - Hintergrund, auf dem Sprites dargestellt werden
    - Vorsicht: Hat auch eigene Logik!
    - Backdrops definieren mögliche Hintergründe
  - Block
    - Element der Logik, "tut etwas"
    - Muss durch ein Ereignis (event) ausgelöst werden -> GUI

]

#slide(title: "Beispiele I")[

  - Algorithmus aus dem ersten Flussdiagramm: Zur Tür laufen
    - Ressourcen zum mitmachen in moodle verfügbar
    - Backdrop und 2 sprites erstellen (Drohne und Tür)
    - Flussdiagramm "abschreiben"
    - Damit die Schritte erkennbar sind: wait
  - Was, wenn sprite nicht direkt vor der Tür ist?
    - Variable: door_x = x-Koordinate der Tür
    - So lange nach rechts laufen, bis door_x = eigene x-Position
    - Schöner: door_x direkt von der Tür nehmen

]

#slide(title: "Beispiele II")[

  - Neuer Sprite: Spieler
  - Keine automatische Bewegung, sondern reagieren auf Tasten
  - Erstmal: Wenn links, dann:
    - Nach links drehen
    - Vorwärts bewegen
    - Wenn schwarze Linie (Wand) berührt wird: "Aua" sagen, zurück
  - Das gleiche für andere Richtungen
    - Kopieren ist aber unschön... Was, wenn wir jetzt auch kurz einen Effekt haben wollen?
    - Lösung: Eigener Block, der das macht!

]

#slide(title: "Beispiele III")[
  
  - Mini-Spiel: Rennen
    - Wenn grüne Fahne gedrückt wird, fliegt die Drohne los in Richtung Tür
    - Spieler kann mit Tasten bewegt werden
    - Wenn jemand die Tür berührt, ist das Spiel vorbei
    - Zwei Lösungen für die Drohne: Endlosschleife und "stop all", oder Variable

]

