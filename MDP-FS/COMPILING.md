# Specifiche di Compilazione per MDP-FS

Questo documento descrive l'ambiente di compilazione per il filesystem MagicDesk Plus (MDP-FS) basato su assembler 64tass.

## Prerequisiti
- **Compilatore:** `64tass` (Turbo Assembler Macro) v1.54 o superiore.
- **Path:** Assicurarsi che `64tass` sia disponibile nel PATH di sistema.

## Struttura Multi-Lingua
Il progetto supporta il multi-lingua per tutti i messaggi mostrati a video. La lingua è gestita in fase di compilazione tramite la variabile d'ambiente `LANG`. 
Le lingue supportate sono attualmente incluse nei seguenti file:
- `ENG.inc` (Inglese)
- `ITA.inc` (Italiano)

Se il parametro non viene passato, l'assemblatore utilizzerà automaticamente `ENG` grazie all'assegnazione condizionale.

## Comandi di Compilazione

### 1. Compilazione del KERNAL Hook (Sorgente Principale)
L'assemblaggio del firmware risulterà in un file binario puro `.prg` che andrà mappato all'indirizzo originario (solitamente in pagina `$C000`).

**Compilazione in Inglese (Default):**
```bash
64tass -a mdp-hook.asm -o mdp-hook.prg -L mdp-hook.lst
```

**Compilazione in Italiano:**
```bash
64tass -D LANG=ITA -a mdp-hook.asm -o mdp-hook.prg -L mdp-hook.lst
```
*(Nota: L'opzione `-a` è obbligatoria per far convertire correttamente l'ASCII del codice sorgente in charset PETSCII per Commodore).*

### 2. Compilazione del Loader/Installer
L'installer si interfaccia con il KERNAL, copiando le jump routines e ripristinando i vettori originari di salvataggio/caricamento/apertura.

```bash
64tass -a mdp-init.asm -o mdp-init.prg -L mdp-init.lst
```

Questo genererà il file eseguibile da avviare con un classico `LOAD "mdp-init.prg",8` e `RUN`.

### 3. Creazione Immagine Floppy (.d64)
Per facilitare il test negli emulatori o sulle interfacce SD (come SD2IEC, Ultimate64), puoi generare automaticamente un disco completo ed auto-contenuto. Richiede il tool `c1541` (incluso in VICE).

```bash
c1541 -format "mdp file system,md" d64 mdp.d64 -write mdp-init.prg mdp-init -write mdp-hook.prg mdp-hook
```

Per farti risparmiare tempo è stato creato lo script **`build.bat`** all'interno della cartella: lanciandolo con un doppio click (su Windows) eseguirà autonomamente l'assemblaggio di entrambi i sorgenti in Italiano, per poi generare e farti trovare l'immagine `mdp.d64` bella e pronta per l'uso!
