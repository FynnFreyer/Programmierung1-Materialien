---
marp: true
theme: default
paginate: true
footer: Prof. Dr.-Ing. P. W. Dabrowski - Programmierung 1 - HTW Berlin

---

## Spezielle Methoden: toString()

```java
public class Mob {
    public int x;
    public int y;

    public String toString() {
        return "Mob at " + x + ", " + y;
    }
}
Mob mob1 = new Mob(12, 15);
System.out.println(mob1);
```

Standard-`toString()`: Speicheradresse (wie bei Array)

---

## Spezielle Methoden: Getter, Setter

```java
public class Mob {
    private int x;
    // [...]
    public void setX(int newValue) {
        x = newValue;
    }
    public int getX() {
        return x;
    }
}
Mob mob1 = new Mob(12, 15);
System.out.println(mob1);
mob1.setX(50);
System.out.println(mob1);
```

---

## Setter: Einhaltung von Logik sicherstellen

```java
public class Mob {
    private int x;
    private int maxSpeed;
    // [...]
    public void setX(int newValue) {
        if(Math.abs(x-newValue) <= maxSpeed) {}
            x = newValue;
        }
    }
}
```

* Es muss nicht für jeden Wert einen setter geben!

---

## Besondere Klassen: String

* Speichert Text
* Bietet convenience-Funktionen wie `.toLowerCase()`, `.split()`
* Vorsicht, Objekt! `==` -> Adressvergleich, `.equals` für Inhalt!

```java
String text = "Te";
text += "xt";
System.out.println(text == "Text"); // false! Warum?
System.out.println(text.equals("Text")); // true
String[] parts = text.split("x"); // ["Te", "t"]
```

---

## Besondere Klassen: LinkedList/ArrayList

* Nachteil von Arrays: Feste Länge
* Alternative: Dynamisch verwaltete Listen von Objekten (->typisiert)
* Hinzufügen (`.add(V value)`) und Entfernen (`.remove(int index)`)
* `LinkedList<V>`: Jedes Element enthält Adressen der Nachbarelemente
    * Hinzufügen/Entfernen sehr schnell
    * Random access langsam ("Durchhangeln" durch alle Elemente)
* `ArrayList<V>`: Intern Array, wächst bei Bedarf
    * Entfernen sehr langsam, Hinzufügen meist schnell (Reserve-Platz)
    * Random access sehr schnell (wie bei Array)

---

## LinkedList vs. ArrayList

* Theorie: LinkedList oder ArrayList je nach Verwendung
    * LinkedList wenn viel Veränderung und meist Iterieren ohne random access
    * ArrayList wenn wenig Veränderung und meist random access
* Praxis: ArrayList meist effizienter
    * Array-Verwaltung in modernen Architekturen hochoptimiert
    * Overhead durch Speicheradressen in LinkedList
* Aber: ArrayList braucht zusammenhängenden Speicher -> eventuell unvorhersagbares Verhalten bei hoher Speicherauslastung

---

## Besondere Klassen: HashMap

* Array und ArrayList/LinkedList: Nur Adressierung über Position
* Adressierung über Key-Wert: `HashMap<K, V>`, Zuordnung Key->Value
    * Intern Array von Values
    * Position im Array wird aus Hash des Keys berechnet
 
```java
HashMap<String, String> blumenFarben = new HashMap<>();
blumenFarben.put("Rose", "rot");
blumenFarben.put("Veilchen", "blau");
String keyValue = "Rose";
if(blumenFarben.containsKey(keyValue)) {
    System.out.println("Farbe von " + keyValue + blumenFarben.get(keyValue));
}
```
---

## Live-Beispiel: Refactoring Rezeptverwaltung

* `ZutatenTyp`: Repräsentiert einen Typ Zutat (Mehl, Zucker etc.) mit:
    * Name
    * Einheit
    * Kcal/Einheit
* `ZutatenManager`: `HashMap<String, ZutatenTyp>` mit allen bekannten Zutaten
* `Rezept`: `LinkedList<Zutat>` statt `Zutat[]`
    * `Zutat[]` in Constructor optional (weiterer Constructor)
    * Überprüft, ob Name und Einheit OK sind, sonst Programmende
    * `addZutat(Zutat)`, `removeZutat(String name)` zum Hinzufügen/Entfernen
    * `getKcal()`: Berechnet Summe der Kalorien (mit Attribut)
* Überall wo sinnvoll/möglich getter und setter

---

## Live-Beispiel: Weiteres Refactoring

* `Rezept`, `Zutat`:
    * `toString()`-Methoden für schöne Ausgabe
* `Rezept`: Einlesen aus komplettem String anstatt String[]: "200g Mehl, 170m Milch, 30g Zucker"
* Nicht zusammen, aber als Idee für Übung zu Hause: `RezeptManager`-Klasse mit: 
    * Constructor, der einen String nimmt, wo mehrere Rezepte mit "\n" getrennt drin stehen
    * `HashMap<String, Rezept>`: Alle Rezepte, key=Name des Rezeptes
    * `toString()`: Gibt die ganze Rezeptliste aus
    * `getRecipe(String name)`: Gibt ein Rezept zurück

---

## Exceptions: Die Idee

* Bisheriges Umgehen mit Fehlern:
    * Alle Fehlerquellen abfangen
    * Ungültigen Wert zurückgeben
* Aber das geht nicht immer
    * Oft zu viele mögliche Gründe für Fehler, um alle zu vermeiden
    * Es können alle Rückgabewerte sinnvoll sein
* Alternative: Neuer Informationskanal zusätzlich zu return

---

## Exceptions: Die Umsetzung

* Bei Auftreten eines Fehlers kann eine Exception geworfen werden:

```java
public class Divider {
    public static double divide(double a, double b) throws Exception {
        if(b == 0) {
            throw new Exception("Can't divide by zero");
        }
        return a/b;
    }
}
try {
	System.out.println(Divider.divide(7, 0));
} catch(Exception e) {
    System.out.println("Ups, Fehler: " + e.getMessage());
}
```

---

## Exceptions: Regeln

* Wenn eine Methode eine Exception werfen kann, muss sie das mit `throws` in der Signatur ankündigen
* Wird eine Exception von einer Methode `a` geworfen, dann:
    * Ist das automatisch wie ein return an dieser Stelle
    * Wird die Exception an der Stelle, wo `a` aufgerufen wurde, sofort wieder geworfen
    * Die Kette wird erst durch ein passendes `catch` unterbrochen
* Alle Exceptions außer `RuntimeExceptions` wie `ArrayIndexOutOfBounds` müssen zwingend per `catch` gefangen werden, bevor sie aus der main-Methode fliegen können

---

## Exceptions: Live-Beispiel

Weiteres refactoring der Rezeptverwaltung:
* Exceptions mit aussagekräftigem Text werfen, wenn:
    * Zutat eines Rezeptes nicht im ZutatenManager bekannt ist
    * Einheit in Zutatenliste nicht zur Einheit im ZutatenManager passt
* Exceptions behandeln (z.B. sinnvolle Ausgabe an User) + wenn möglich weitermachen mit dem nächsten Rezept

---

## Besondere Klassen: StringBuilder

* String hält intern ein `char[]`
    * immutable!
    * Scheinbare Veränderung = Inhalt kopieren + neuer String
* Effizienter Aufbau: `StringBuilder`
    * Erlaubt Hinzufügen von Textteilen
    * Werden am Ende mit `toString()` zusammengefügt
    * -> nur 1 Kopiervorgang

---

# Zeiteffekt von StringBuilder

```java
double startTime = System.currentTimeMillis();
String text = "";
for(int i=0; i<100000; i++) {
    text += i + ",";
}
System.out.println(text.substring(0, 10));
System.out.println(System.currentTimeMillis() - startTime); // 4291 ms
startTime = System.currentTimeMillis();
StringBuilder textBuilder = new StringBuilder();
for(int i=0; i<100000; i++) {
    textBuilder.append(i + ",");
}
System.out.println(textBuilder.toString().substring(0, 10));
System.out.println(System.currentTimeMillis() - startTime); // 8 ms
```

---

## Static-Attribute

Wichtig bei Attributen: Jedes Objekt hat eine eigene Kopie!

* Sinnvoll bei Eigenschaften des Objekts (ISBN des Buches)
* Aber schwierig, wenn Eigenschaft gemeinsam sein soll

Lösung: Statische Attribute:

* Markierung mittels `static`
* Alle Objekte haben gemeinsamen Wert!

---

## Static-Attribute: Instanzen zählen (+Heap)

```java
public Class Book {
    private int ID;
    public static int numBooks = 0;
    public Book() {
        ID = numBooks;
        numBooks += 1;
    }
    public int getID() { return ID; } 
}
Book book1 = new Book();
System.out.println("Book 1 ID: " + book1.getID())
System.out.println("Total number of books: " + Book.numBooks); //nicht book1.
Book book2 = new Book();
System.out.println("Book 2 ID: " + book2.getID())
System.out.println("Total number of books: " + Book.numBooks);
```

---

## Static-Methoden: Logik kapseln

* Methoden, die keinen Zugriff auf Attribute außer `static` brauchen
* Typisch:
    * Utility-Methoden, die logisch in die Klasse gehören
    * Ganze Utility-Klassen
    * Getter für statische Attribute

```java
public Class Book {
    private static int numBooks = 0;
    //...
    public static int getNumBooks() { return numBooks; } // kann static sein
}
```

---

## Live-Beispiele

* Book - was passiert mit und ohne static?
* static als Fehlerquelle - PatientList.calculateMeanAge() mit Patient.age als static
* Singleton zum Verwalten von Einstellungen
* DateUtilities.getDay("12.07.2022") - ähnliche Logik wie Integer.parseInt("12")

---

## Dateien

* Spezilalisierte Klassen für Dateioperationen:
    * Datei selber: `File`
    * Lesen: `FileReader` + `BufferedReader`
    * Schreiben: `FileWriter` + `BufferedWriter`
    * Werfen bei Fehlern (Datei existiert nicht, keine Berechtigung, Festplatte voll...) `IOException`
* Idee: `File` beschreibt Datei, `Reader`/`Writer` macht low-Level-Zugriff, `BufferedReader`/`BufferedWriter` bietet Komfort-Funktionen (z.B. zeilenweises Lesen)

---

## Dateien: Live-Beispiel

```java
public class TextReader {
	public static int countWords(String infile) {
		int res = 0;
		File f = new File(infile);
		try {
			BufferedReader r = new BufferedReader(new FileReader(f));
			while(r.ready()) {
				String[] words = r.readLine().split(" ");
				res += words.length;
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		return res;
	}
}
```

---

## Zu guter Letzt: Evaluationsbögen

* Bitte ausfüllen! Jetzt 20 Minuten Zeit.
