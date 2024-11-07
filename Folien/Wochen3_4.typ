#import "@preview/polylux:0.3.1": *
#import "@preview/colorful-boxes:1.3.1": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge
#import "@preview/codelst:2.0.0": sourcecode
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
  subtitle: "Wochen 3-4: Der Schritt zu Java",
  date: "24.10.2024",
  institution-name: "HTW Berlin"
)

#slide(title: "Programmiersprachen", new-section: "Einführung")[

- Neben Scratch-Blöcken gibt es viele andere Programmiersprachen

#sourcecode[```python
vals = [1, 6, 5, 3]
for i in range(0, len(vals)):
    print(vals[i])
```]

#sourcecode[```c++
#include <iostream>
int vals[4] = {1, 6, 5, 3};
for(int i=0; i<sizeof(vals)/sizeof(int); i+=1) {
    std::cout << vals[i] << "\n";
}
```]

]

#slide(title: "Java")[

- Weit eingesetzte Programmiersprache
- Kümmert sich um Speicherverwaltung (anders als bspw. C)
- Besitzt viele Komfort-Features
- Beliebt auf dem Markt

]

#slide(title: "Erstes Java-Programm")[

#sourcecode[```java
// Jede Klasse muss in gleichnamiger Datei stehen
// Jeder Java-Code muss in einem Klassen-Block stehen: {}
public class HelloWorld {
  // Code ist in Methoden unterteilt. Anweisungen in 
  // Methoden-Blöcken
  // Spezielle Methode main: Startpunkt eines Programms
  public static void main(String[] args) {
    // System.out.println: Bildschirmausgabe    
    System.out.println("Hello, world!");
    // Jede Zeile muss mit einem       ; enden
  }
  // Jede geöffnete Klammer muss geschlossen werden
}
```]
]


#slide(title: "Variablen in Java")[

#sourcecode[```java
public class HelloWorld {
  public static void main(String[] args) {
    // Variablen (hier: Zahlen) deklarieren und initialisieren
    int i = 0;
    int k = 3;
    // Wert von i um 1 erhöhen
    i ++;
    // Mathematische Operationen (hier: +, * und Modulo)
    i = (k + 3*i) % 2;
    System.out.print(i);
  }
}
```]
]


#slide(title: "Funktionen in Java")[

#sourcecode[```java
public class StackBeispiel {
  // Definition einer eigenen Funktion mit 2 Argumenten
  public static void pn(int from, int to, int by) {
    for(int i=from; i<to; i+=by) {
      System.out.println(i);
    }
  }

  public static void main(String[] args) {
    // Aufruf der Funktion (Ausführung des Codes darin)
    pn(1, 12, 2);
  }
}
```]

]

#slide(title: "Stack", new-section: "Speicherorganisation")[

- Eigener Speicherbereich für jede Funktion, pro Aufruf neu
- Variablen der Funktion werden dort angelegt/übergeben
- ``printNumbers(0, 100, 2)`` könnte ergeben:

#table(
  columns: 3,
  table.header(
    [Adresse], [Wert], [Kommentar]
  ),
 [ 12 ], [ ... ], [ Nächster Befehl ],  
 [ ... ], [ ... ], [ Anderer Code etc.], 
 [ 67 ], [ 12 ], [ Rücksprung-Adresse ], 
 [ 68 ], [ 2 ], [ by (Arg. 3) ],
 [ 69 ], [ 100 ], [ to (Arg. 2) ], 
 [ 70 ], [ 0 ], [ from (Arg. 1) ],
 [ 71 ], [... ], [Rücksprung-Adresse vorherige Funktion ],
 [ ... ], [ ... ], [ Restlicher Stack ]

)

]

#slide(title: "Scope")[

Scope ergibt sich aus Stack:
- Funktionen verändern nur ihre eigenen Werte!
- Funktionen kriegen nur Kopien der Argument-Werte!
]

#slide(title: "Scope")[
#sourcecode[```java
public class StackBeispiel {
  public static void pn(int from, int to, int by) {
    for(; from<to; from += by) {
      System.out.println(from);
    }
  }
  public static void main(String[] args) {
    from = 0;
    pn(from, 100, 2);
    System.out.println("From: " + from); // 0 oder 100?
  }
}
```]

]

#slide(title: "Scope")[
#sourcecode[```java
public class StackBeispiel {
public static void pn(int from, int to, int by) {
for(; from<to; from += by) {
System.out.println(from);
}
}
public static void main(String[] args) {
from = 0;
pn(from, 100, 2);
System.out.println("From: " + from); // 0 oder 100?
}
}
```]
]

#slide(title: "Scope")[
#sourcecode[```
public class StackBeispiel {
public static void pn(int from, int to, int by) {
for(; from<to; from += by) {
System.out.println(from);
}
}
public static void main(String[] args) {
from = 0;
pn(from, 100, 2);
System.out.println("From: " + from); // 0 oder 100?
}
}
```]
]


#slide(title: "Datentypen")[

- Bisher angenommen: Ein Wert = eine Speicheradresse
- Aber: Eigentlich kann der Computer nur 1 und 0 (bit)
- Binärsystem: 
    * Wie 10er-System, aber mit nur 2 Ziffern.
    * Umrechnung mit 2er statt 10er Potenzen, Beispiel: Addition
- Definierte Breite einer Zahl: 8 bit = 1 byte -> 0 - 255
- Datentypen: Sagen dem Computer, was der Speicherinhalt bedeutet
    - `int`, `long`: Ganze Zahl
    - `float`, `double`: Gleitkommazahl
    - `char`: Buchstabe (mit Hochkomma: `char x = 'a';`)
    - `boolean`: Ja/nein (`true` oder `false`)

]

#slide(title: "Herausforderungen")[

- Was tut man, um: 
  * Zahlen größer 255 zu speichern?
  * Zahlen kleiner 0 zu speichern?
  * Gelitkommazahlen zu speichern?
  * Buchstaben zu speichern?
- Murmelgruppen, 5 Minuten

]

#slide(title: "Zahlen größer als 0")[

- Mehrere bytes zu einer Zahl zusammengefasst
- Architekturabhängig, wie "breit" Zahlen sind
- Java macht es einheitlich:
  - `byte`: 1 byte -> [-128, 127]
  - `short`: 2 byte -> [-32768, 32767]
  - `int`: 4 byte -> [-2147483648, 2147483647]
  - `long`: 8 byte -> [-9223372036854775808, 9223372036854775807]
  - Optional `unsigned` -> kein Zweierkomplement, höherer Maximalwert

]

#slide(title: "Zweierkomplement ")[

- Einfache Lösung: Erstes bit ist Vorzeichen (z.B. 3 = `0011`, -3=`1011`)
- Probleme: 
  * 0 "doppelt" (`0000`, `1000`)
  * Addition schwierig (z.B. `0011+1011=1110`=-6?)
- Zweierkomplement: Erstes bit ist -1*Max. (z.B. -8=`1000`, -5=`1011`)
- Vorteile:
  * 0 nur ein Mal (`0000`, `1000`=-8)
  * Einfache Addition (z.B. `0101+1011=0000`)

]

#slide(title: "Gleitkommazahlen")[

- Aufteilung der Zahl: Exponent, Mantisse
- Wert=Mantisse^Exponent
- Gleitkommazahlen sind nur Näherungswerte!
  - Für kleine Werte: Extrem gute Näherung
  - Je größer der Wert, um so geringer die Genauigkeit
  - Spezielle Bibliotheken für genaue Berechnungen mit großen Zahlen

]

#slide(title: "Text")[

- Interpretation von Zahlen als Buchstaben
- #link("https://de.wikipedia.org/wiki/American_Standard_Code_for_Information_Interchange")[ASCII-Tabelle]: Zuordnung der Werte eines byte zu Zeichen
- Problem: Unterschiedliche Alphabete
- Lösungen:
  - Codepages - aber nicht automatisch erkennbar
  - UTF-8: Ein Buchstabe kann bis zu 4 Byte breit sein, Erkennung über erstes bit.

]

#slide(title: "Speicherinterpretation: Datentypen")[

Was bedeutet `01001000 01101001`?
- Zwei `byte`: 72, 105?
- Ein `short`: 18537?
- Zwei `char`: "H", "i"?

-> Datentypen müssen in Java deklariert werden und *ändern die Bedeutung* von Variablen - z. B. `00110111` kann die Zahl 55 oder das Zeichen "7" sein (aber niemals die Zahl 7)! 

]
