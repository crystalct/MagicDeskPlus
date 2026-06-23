# **Specifiche Tecniche dello Standard RAM Disk per MagicDesk Plus (mdp_FS)**

Il presente documento definisce le specifiche tecniche e l'architettura software per l'implementazione di un file system denominato **mdp_FS (MagicDesk Plus File System)**, operante sulla SRAM persistente della cartuccia MagicDesk Plus per Commodore 64\.

## **1\. Architettura Hardware e Finestra di I/O**

La cartuccia MagicDesk Plus mette a disposizione 128 KiB di SRAM statica persistente, gestita tramite una tecnica di banking e paging alternato.

| Risorsa Hardware | Indirizzo / Valore | Descrizione Funzionale   |
| :---- | :---- | :---- |
| Finestra di I/O | $DF00 \- $DFFF | Finestra di accesso da 256 byte mappata sulla pagina SRAM attiva. |
| Registro di Pagina | $DE01 (PAGE\_REG) | Write-only. Seleziona la pagina attiva (0-255) della porzione SRAM corrente. |
| Registro di Controllo | $DE03 (CTRL\_REG) | Write-only. Bit 5 abilita la SRAM (1=SRAM, 0=EEPROM). Bit 0 seleziona la Portion (0=Prima da 64KB, 1=Seconda da 64KB). |

## **2\. Struttura Logica del Blocco (Filosofia 1541-Style)**

Per ottimizzare le performance computazionali del processore MOS 6502 ed eliminare la frammentazione, mdp_FS adotta un'allocazione a blocchi concatenati. Ogni pagina hardware da 256 byte corrisponde a un singolo blocco logico del file system.  
Ciascun blocco sacrifica gli ultimi due byte (offset $FE e $FF) per scopi di concatenazione e controllo del flusso (Pointer Linking), offrendo una capacità netta di 254 byte di dati per blocco:

* **Byte 0 \- 253 (Offset $00 \- $FD):** Settore Dati Netto (Payload).  
* **Byte 254 (Offset $FE):** Indicatore della *Portion* successiva. Se impostato a **$FF**, indica che il blocco corrente è l'ultimo blocco del file (End of File \- EOF). Se impostato a **$00** o **$01**, specifica la Portion SRAM del blocco successivo.  
* **Byte 255 (Offset $FF):** Se il blocco non è l'ultimo, contiene l'indice della *Pagina* successiva (0-255) da mappare in $DE01. Se il blocco è l'ultimo (EOF), contiene il numero esatto di byte validi all'interno dell'area dati di questa pagina (da 1 a 254).

## **3\. Layout della Memoria RAM Disk (Mappatura Fissa)**

La SRAM totale è suddivisa rigidamente per garantire l'integrità dei metadati e il corretto boot hardware:

| Portion | Pagina (Blk) | Destinazione d'Uso   |
| :---- | :---- | :---- |
| Portion 0 | 0 | **Directory Principale (Blocco 1):** Contiene le entry descrittive dei primi file. |
| Portion 0 | 1 | **BAM (Block Allocation Map):** Mappa di bit per la disponibilità dei 512 blocchi complessivi (richiede 64 byte). I restanti byte sono riservati a configurazioni di sistema. |
| Portion 0 | 2 \- 255 | Blocchi Dati Utente (Area Disponibile). |
| Portion 1 | 0 \- 254 | Blocchi Dati Utente (Area Disponibile). |
| Portion 1 | 255 | **Blocco di Sistema Hardware:** Gli ultimi due byte (offset $FE e $FF) devono tassativamente ospitare la signature hardware standard di MagicDesk Plus ($CA, $F1). I primi 254 byte sono utilizzabili per dati o identificativi del volume. |

### **Struttura di una Entry della Directory (Dimensione fissa: 32 Byte)**

Ogni pagina di Directory può ospitare esattamente 8 voci di file (256 / 32 \= 8). La singola entry è strutturata come segue:

* **Byte 0 \- 15:** Nome del File in formato PETSCII, terminato e riempito con `$00` (NUL) se inferiore a 16 caratteri.  
* **Byte 16:** Portion del blocco iniziale del file (0 o 1).  
* **Byte 17:** Indice di Pagina del blocco iniziale del file (0-255).  
* **Byte 18 \- 19:** Numero totale di blocchi allocati dal file (Word, formato Little-Endian).  
* **Byte 20:** Flag di Stato del file ($01 \= File Attivo/Chiuso, $02 \= File in Scrittura/Aperto, $80 \= File Eliminato).  
* **Byte 21 \- 31:** Byte riservati per estensioni future (es. attributi di protezione).

## **4\. Specifiche del Pool di Funzioni API**

Le API di mdp_FS devono operare in modo astratto, isolando le applicazioni dalle manipolazioni dirette dei registri hardware.

### **Funzioni di Sistema**

**uint8\_t mdp\_init(void)**  
Inizializza la libreria. Esegue l'algoritmo di rilevamento hardware leggendo la firma ($CA, $F1) alla Portion 1, Pagina 255\. Se la firma è presente ed è valido il File System, restituisce uno stato di pronto. Se l'hardware è presente ma non formattato, restituisce un codice di errore specifico.  
**void mdp\_format(void)**  
Inizializza la SRAM azzerando tutte le pagine, impostando la BAM (marcando come occupati solo i blocchi di sistema fissi come Portion 0 Pag 0, Pag 1 e Portion 1 Pag 255). Scrive inoltre la firma hardware nativa $CA, $F1 alla fine della Portion 1\.

### **Funzioni di Stream di Alto Livello**

**uint8\_t mdp\_fopen(const char\* filename, uint8\_t mode)**  
Apre un canale logico verso un file. Se la modalità è in lettura (READ), cerca il nome nella directory e posiziona il puntatore hardware interno sul blocco iniziale del file. Se la modalità è in scrittura (WRITE), verifica la disponibilità di spazio tramite la BAM, alloca il primo blocco, crea la voce in directory e la marca come aperta.  
**uint16\_t mdp\_fread(uint8\_t\* dest\_buffer, uint16\_t bytes\_to\_read)**  
Legge un quantitativo specifico di byte spostandoli dalla finestra $DF00 alla RAM del C64. Se il cursore interno raggiunge l'offset 254 di un blocco non terminale, l'API preleva automaticamente i byte di collegamento ($FE e $FF), commuta i registri hardware $DE03 e $DE01 puntando al blocco successivo, azzera l'offset interno e continua la lettura.  
**uint16\_t mdp\_fwrite(const uint8\_t\* src\_buffer, uint16\_t bytes\_to\_write)**  
Scrive i byte dal buffer alla SRAM. Al raggiungimento del limite di 254 byte del payload del blocco corrente, l'API interroga la BAM per identificare una pagina libera. Scrive le coordinate di questa nuova pagina negli ultimi due byte del blocco precedente, commuta l'hardware sul nuovo blocco e prosegue in modo trasparente per il chiamante.  
**void mdp\_fclose(void)**  
Chiude il file correntemente aperto. Se il file era in scrittura, scrive il flag di EOF ($FF) nel byte di Portion del blocco corrente e imposta nel byte successivo il numero di byte effettivamente usati. Aggiorna lo stato della directory su SRAM marcando il file come valido e chiuso.

## **5\. Strategia di Gestione dello Shadow Register per $DE03**

Poiché il registro di controllo $DE03 è di tipo Write-only, è mandatorio riservare una locazione nella RAM di sistema del Commodore 64 (es. nella pagina zero o nell'area riservata delle API) definita come **mdp\_ctrl\_shadow**. Qualsiasi modifica allo stato della Portion o all'attivazione della SRAM deve prima riflettersi sulla variabile shadow tramite operazioni logiche bitwise (AND / OR) e successivamente essere trasmessa fisicamente al registro hardware.
