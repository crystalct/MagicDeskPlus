# Perchè una rimasterizzazione?

Passare dalla storica versione su floppy disk 1541 a una cartuccia **Magic Desk Plus (MDP)** per un titolo come *Murder on the Mississippi* rappresenta una trasformazione radicale sia sul piano tecnico che su quello dell'esperienza di gioco. 

In un'avventura investigativa basata sul continuo spostamento tra cabine, interrogatori ed esami di indizi, la versione originale su disco soffriva del costante tempo di ricerca della testina e dei tempi morti del drive, anche in presenza di un fast loader custom. Convertire il gioco su formato cartuccia MDP offre una serie di vantaggi chiave che ne giustificano pienamente la rimasterizzazione:

---

### 1. Azzeramento totale dei tempi di caricamento
Mappando fino a 1 MB di ROM direttamente nella finestra di memoria `$8000–$9FFF` tramite bank-switching (gestito dal registro `$DE00`), ogni locazione, dialogo o elemento grafico viene richiamato all'istante. Viene del tutto eliminata la dipendenza dai meccanismi del drive 1541 o dalle routine del fast loader, rendendo l'esplorazione del piroscafo fluida e immediata.

---

### 2. Espansione dinamica, RAM aggiuntiva e superamento dei limiti di memoria
Il gioco originale per Commodore 64 era sviluppato al limite delle risorse, occupando praticamente la totalità dei 64 KB di memoria RAM disponibili nel sistema. Nel passaggio a cartuccia, pur avendo rimosso alcune routine diventate obsolete (come il codice dedicato alla gestione e al controllo del Fast Loader 1541), lo spazio libero ottenuto nella RAM interna non era comunque sufficiente per implementare nuove funzionalità. 

La presenza dei **128 KB di SRAM** sulla cartuccia (accessibili in pagine da 256 byte nella finestra I/O `$DF00–$DFFF` gestite dai registri `$DE01` e `$DE03`) è stata fondamentale: anche senza strutturare un file system complesso come l'MDP-FS, lo spazio in SRAM è stato sfruttato direttamente per ospitare le modifiche e le espansioni al codice di gioco, agendo da vera e propria memoria RAM ausiliaria per buffer, decompressioni al volo e dati di stato complessi.

---

### 3. Salvataggi istantanei, sicuri e a prova di tempo
I giochi investigativi richiedono salvataggi frequenti. Rispetto al lento e rischioso processo di scrittura su floppy:
* **SRAM bufferizzata a batteria:** Permette di salvare lo stato esatto del gioco all'istante, mantenendo i dati anche a computer spento.
* **Backup su EEPROM (Non Volatile):** Risolve il limite fisiologico della batteria tampone. Salvando i progressi sulla EEPROM integrata (da 8KB o 32KB), le partite rimangono archiviate in modo permanente e indefinito nel tempo, al riparo dal degrado o dall'esaurimento della batteria.

---

### 4. Integrazione del Manager MDP e del Manager Salvataggi su ROM
Integrare un software di gestione direttamente nella ROM della cartuccia eleva la qualità del lavoro:
* **Manager Magic Desk Plus:** Si occupa dell'inizializzazione dell'hardware all'avvio e del rilevamento delle memorie, prendendo il controllo del sistema in modo pulito e trasparente.
* **Manager dei Salvataggi:** Offre all'utente un'interfaccia comoda e integrata per gestire molteplici slot di salvataggio. Tramite firme hardware dedicate, verifica la validità e l'integrità dei dati prima del caricamento e gestisce in sottofondo il trasferimento dati verso la EEPROM (applicando i corretti tempi di scrittura richiesti dalle memorie non volatili).

---

### 5. Tocco grafico e restyling degli Sprite
A coronamento di questo lavoro di restyling, è stato applicato anche un importante tocco grafico: alcuni sprite dei personaggi sono stati ridisegnati meticolosamente per assomigliare il più possibile alle illustrazioni originali e ai "ritratti" dei personaggi.

![newsprites](./murder.png)
---

### Perchè non una versione su EasyFlash?
Ponendosi questa domanda si comprende a pieno il valore della scelta dell'hardware:
* **Uso continuo del floppy in scrittura:** Nel gioco originale, il disk drive viene interpellato continuamente in scrittura per aggiornare le note nel taccuino di gioco e per effettuare i salvataggi.
* **I limiti della Flash ROM (EasyFlash):** L'EasyFlash si basa su memoria Flash ROM. Sebbene riprogrammabile dal C64, la memoria Flash **non è progettata per scritture casuali, frequenti e ad alta velocità**. Scrivere un singolo byte o aggiornare una nota su Flash richiede di cancellare interi blocchi di memoria (con cicli di scrittura lenti e complessi), rendendo la gestione delle note e dei salvataggi in tempo reale un incubo tecnico impraticabile.
* **RAM aggiuntiva per il codice:** L'EasyFlash non offre un'espansione di RAM da 128 KB ad accesso casuale in tempo reale indispensabile per estendere il codice del gioco oltre i 64 KB nativi del C64.

La cartuccia **Magic Desk Plus**, con i suoi **128 KB di SRAM statica bufferizzata a batteria** (e l'EEPROM per il backup permanente), risolve entrambi i problemi: offre una memoria di lavoro aggiuntiva per superare il limite dei 64 KB del C64 e consente di aggiornare il taccuino e salvare la partita all'istante in tempo reale!
