# MagicDesk Plus File System (MDP-FS)
**Manuale Utente e Comandi**

Il MagicDesk Plus File System (MDP-FS) trasforma l'espansione di memoria della cartuccia MagicDesk Plus in un vero e proprio disco RAM ultra-veloce. L'installer si aggancia direttamente alle routine di sistema (KERNAL) del Commodore 64, permettendoti di utilizzare i classici comandi DOS come se stessi usando un drive floppy reale.

## Numero di Device (Drive)
Il disco RAM risponde in modo esclusivo e predefinito al **Device 7** (il drive floppy standard è l'8). 
In questo modo, puoi usare contemporaneamente il disco fisico (drive 8) e il RAM disk (drive 7) per copiare file alla massima velocità.

---

## Comandi Supportati

### 1. Formattazione (Format)
Il disco RAM deve essere inizializzato prima del primo utilizzo. Questo comando cancella l'intera directory e svuota la BAM (Block Availability Map).
Puoi usare indifferentemente `N:` (New) o la sintassi estesa `NEW:`.

*Sintassi dal BASIC:*
```basic
OPEN 15,7,15,"N:" : CLOSE 1
```
oppure
```basic
OPEN 15,7,15,"NEW:" : CLOSE 1
```

### 2. Validazione e Ottimizzazione (Validate)
La validazione analizza l'integrità del File System. In futuro potrà ricostruire la BAM scansionando la directory e recuperare eventuali blocchi "orfani".

*Sintassi dal BASIC:*
```basic
OPEN 15,7,15,"V0:" : CLOSE 1
```

### 3. Visualizzare il Contenuto del Disco (Directory)
Per visualizzare l'elenco dei file presenti nella memoria della cartuccia e i blocchi (bytes) rimanenti liberi.

*Sintassi dal BASIC:*
```basic
LOAD "$",7
LIST
```
*(Nota: il comando cancellerà l'eventuale programma BASIC in memoria, proprio come un floppy reale).*

### 4. Salvataggio di un File (Save)
Salva il programma BASIC attualmente in memoria, oppure una specifica area di memoria, nel disco RAM.

*Sintassi dal BASIC:*
```basic
SAVE "NOMEFILE",7
```
Il nome del file può essere lungo fino a un massimo di 16 caratteri. 
Se tenti di salvare un file ma non c'è abbastanza spazio sulla cartuccia, riceverai l'errore standard `?FILE TOO LARGE ERROR` o la procedura verrà abortita in sicurezza liberando i blocchi parziali (Rollback).

### 5. Caricamento di un File (Load)
Carica in memoria un programma salvato in precedenza.

*Sintassi dal BASIC per caricamento relativo (area BASIC):*
```basic
LOAD "NOMEFILE",7
```

*Sintassi dal BASIC per caricamento assoluto (indirizzo originale di salvataggio):*
```basic
LOAD "NOMEFILE",7,1
```

---

## Note Tecniche
- I salvataggi non sovrascrivono la delicata memoria *Zero Page* garantendo compatibilità con altro software.
- Il file system è robusto: se tenti di salvare quando il disco è pieno, MDP-FS applicherà un roll-back istantaneo rimuovendo i blocchi parzialmente allocati, lasciando la memoria intatta.
