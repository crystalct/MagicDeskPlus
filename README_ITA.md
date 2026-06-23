# Cartuccia Magic Desk Plus per Commodore 64

***Cosa non è la Magic Desk Plus:*** una cartuccia di espansione di memoria general-purpose per C64<br>
***Cosa è la Magic Desk Plus:*** un'interessante piattaforma che può essere utilizzata per sviluppare giochi su cartuccia che richiedono grandi quantità di spazio ROM, RAM aggiuntiva e memoria non volatile scrivibile.

## 1. Introduzione: Il Formato Magic Desk Standard

Il formato di cartuccia **Magic Desk** nacque originariamente nel 1983 da un progetto di Commodore Business Machines, concepito per ospitare una suite di software di produttività semplificata (comprendente moduli come *Type and File*, *Spreadsheet* e *Financial Planning*). L'obiettivo fondamentale dei progettisti era mantenere il software residente in memoria, azzerando completamente i tempi di caricamento estenuanti del drive a disco o del Datassette. Sebbene commercialmente sia stato rilasciato solo il modulo *Type and File*, l'eredità tecnica dell'architettura hardware è sopravvissuta per decenni.

### Interfaccia Hardware e Segnali della Porta di Espansione
L'operatività di una cartuccia Magic Desk standard è legata alla gestione dei segnali elettrici sulla porta di espansione a 44 pin del Commodore 64. La configurazione standard prevede il segnale `/EXROM` portato a livello basso (massa) e il segnale `/GAME` mantenuto a livello alto. 

Questa impostazione istruisce il PLA (Programmable Logic Array) del C64 a mappare 8 KB di ROM esterna nella finestra di memoria compresa tra `$8000` e `$9FFF`, mantenendo inalterati il BASIC ROM e il KERNAL ROM.

### Architettura del Memory Banking: Il Registro `$DE00`
Come altri tipi di cartucce, la Magic Desk adotta un *data-type banking*, dove il cambio di banco è innescato dal valore del dato scritto. Il cuore del sistema è un registro hardware di *latching* (solitamente un chip 74LS273) che si attiva quando la CPU scrive un byte nell'area di I/O compresa tra `$DE00` e `$DEFF`.

La struttura del byte di controllo scritto in `$DE00` è la seguente:
* **Bit 0-5 (o 0-6):** Definiscono quale banco da 8 KB della ROM debba slittare sotto la finestra `$8000-$9FFF`. Con 7 bit è possibile indirizzare fino a 128 banchi, pari a 1 MB di memoria.
* **Bit 7 (Controllo di Disabilitazione):** Funge da interruttore globale. Se impostato a 1 (valori `>= $80`), la circuiteria forza la linea `/EXROM` a uno stato logico alto, disabilitando istantaneamente la cartuccia e ripristinando la RAM interna del C64 nell'area `$8000-$9FFF`.

### Sfruttamento Software: La Tecnica del Trampolino
Poiché il processore 6502 non può cambiare il banco ROM "sotto se stesso" senza interpretare dati casuali e causare un crash, i programmatori ricorrono alla tecnica del trampolino (*trampoline code*). Il software copia una piccola routine di banking nella RAM del C64 (ad esempio nello Stack o in pagina 3), disabilita gli interrupt (`SEI`), esegue la scrittura in `$DE00`, salta al nuovo banco ROM e riabilita gli interrupt (`CLI`).

Affinché il KERNAL avvii automaticamente la cartuccia all'accensione, il Banco 0 deve contenere i vettori di avvio (Cold e Warm Start) e la firma PETSCII `"CBM80"` a partire dall'indirizzo `$8000`.

---

## 2. Architettura Hardware della Magic Desk Plus

La **Magic Desk Plus** espande radicalmente le specifiche del formato classico. Oltre a supportare una memoria ROM di 256/512/1024 Kbyte, introduce una **SRAM statica da 128 KByte** supportata da una batteria tampone, affiancata da una memoria **EEPROM da 8/32 Kbyte**. Una configurazione con solo la SRAM o solo la EEPROM è ammessa.

Per gestire questo spazio aggiuntivo mantenendo il registro `$DE00` inalterato, la cartuccia introduce una finestra di transito dati dedicata e due nuovi registri nell'area di I/O 1:

* **Finestra di I/O Dati (`$DF00 - $DFFF`):** Una finestra di accesso fissa da 256 byte mappata direttamente sulla pagina di memoria SRAM o EEPROM attualmente attiva.
* **Registro di Pagina (`$DE01`):** Registro *Write-only* preposto alla selezione della pagina da 256 byte (valori da 0 a 255) da proiettare nella finestra di transito.
* **Registro di Controllo (`$DE03`):** Registro *Write-only* deputato all'abilitazione e alla configurazione della SRAM/EEPROM.

**La finestra `$DF00 - $DFFF` sarà l'accesso diretto, sia in lettura che scrittura, alla memoria (SRAM o EEPROM) anche con la ROM principale della cartuccia disabilitata.**

### Configurazione del Registro di Controllo `$DE03`
Essendo `$DE03` un registro in sola scrittura, il processore 6502 non può leggerne lo stato. È perciò utile mantenere una copia ombra (*shadow register*) nella RAM di sistema (es. `mdp_ctrl_shadow`) per applicare modifiche bitwise in modo sicuro (gli eventuali *shadow registers*  sia per `$DE01` che per `$DE03` non sono strettamente necessari). 

* **Bit 0:** Seleziona le due porzioni di SRAM. Scrivendo `0` si utilizza la prima porzione da 64 KByte; scrivendo `1` si utilizza la seconda porzione da 64 KByte. All'accensione è selezionata di default la prima porzione. Se la SRAM è disattivata il Bit 0 è irrilevante.
* **Bit 5:** Attiva o disattiva la SRAM effettuando la commutazione con l'eventuale EEPROM. Se impostato a `1`, la SRAM è abilitata; se impostato a `0`, la SRAM è disattivata e subentra la EEPROM. All'accensione, la EEPROM è attiva per default.

---

## 3. Gestione e Programmazione della EEPROM

L'architettura Magic Desk Plus prevede anche la coesistenza della SRAM con una memoria non volatile di tipo EEPROM (da 8 KB o 32 KB). EEPROM e SRAM condividono la stessa finestra hardware di I/O (`$DF00-$DFFF`) e lo stesso registro di pagina `$DE01`. La selezione esclusiva dell'una o dell'altra si effettua settando il bit 5 in `$DE03`.

A seconda della EEPROM installata, la selezione della pagina risponde a maschere hardware fisse. Una EEPROM da 8 KB (32 pagine) risponde alla maschera `0x1F` ignorando i bit superiori di `$DE01`, mentre una da 32 KB (128 pagine) usa la maschera `0x7F` e ignora il bit 7.

A differenza della SRAM che permette scritture immediate, la programmazione di una cella EEPROM impone un tempo fisico di memorizzazione che può arrivare fino a 10 millisecondi per operazione. Il software deve tassativamente inserire un *delay loop* (ciclo di ritardo software) subito dopo ogni istruzione di memorizzazione nella finestra `$DF00-$DFFF`, per impedire che cambi di pagina o nuove scritture corrompano il processo in corso.

---

## 4. Case Study per l'utilizzo della SRAM: il File System MDP-FS (MagicDesk Plus File System)

Il **MagicDesk Plus File System (MDP-FS)** è un'architettura software progettata per gestire i 128 KByte di SRAM persistente (tramite batteria tampone) e trasformarli in un "RAM Disk" ad altissime prestazioni.

### Filosofia di Allocazione Concatenata (1541-Style)
Per eliminare la frammentazione ed alleggerire il carico sul processore MOS 6502, MDP-FS adotta un'allocazione a blocchi concatenati ispirata alla logica di formattazione del Commodore 1541. Ogni pagina hardware da 256 byte corrisponde esattamente a un singolo blocco logico.

Ciascun blocco sacrifica sistematicamente gli ultimi due byte (offset `$FE` e `$FF`) per ospitare i puntatori di concatenazione (*Pointer Linking*), offrendo **254 byte di dati netti per blocco**:
* **Byte 0 - 253 (Offset `$00` - `$FD`):** Settore dati netto (Payload).
* **Byte 254 (Offset `$FE`):** Indica la Portion SRAM (0 o 1) in cui risiede il blocco successivo. Se impostato a `$FF`, indica la fine assoluta del file (EOF).
* **Byte 255 (Offset `$FF`):** Se il blocco non è l'ultimo, indica l'indice della pagina successiva da mappare in `$DE01`. Se il blocco è terminale (EOF), contiene il numero esatto di byte validi nell'area dati (da 1 a 254).

### Layout Fisso della Memoria SRAM
La mappa della SRAM è rigidamente partizionata per garantire il boot e la persistenza dei metadati strutturali:

| Portion | Pagina | Destinazione d'Uso |
| :--- | :--- | :--- |
| **0** | 0 | **Directory Principale:** Entry descrittive dei file. |
| **0** | 1 | **BAM:** Mappa di allocazione a bit per i 512 blocchi complessivi. |
| **0 e 1** | Varie | **Dati Utente:** Blocchi disponibili per lo storage. |
| **1** | 255 | **Blocco Hardware:** Gli ultimi due byte (`$FE` e `$FF`) devono tassativamente ospitare la signature nativa `$CA, $F1`. |

### Struttura della Directory
Una singola pagina di directory ospita esattamente 8 entry da 32 byte ciascuna. Ogni entry definisce la struttura del file:
* **Byte 0-15:** Nome PETSCII del file.
* **Byte 16-17:** Portion e Pagina del blocco iniziale.
* **Byte 18-19:** Word a 16 bit (Little-Endian) con il totale dei blocchi allocati.
* **Byte 20:** Flag di stato (es. `$01` = Attivo, `$02` = In scrittura, `$80` = Eliminato).
* **Byte 21-31:** Spazio riservato per estensioni.

### Flusso Logico delle API (`mdp_fread` e `mdp_fwrite`)
Le API di MDP-FS astraggono completamente la manipolazione hardware per le applicazioni. 
Durante la lettura di uno stream tramite `mdp_fread`, l'API legge sequenzialmente la finestra `$DF00` e sposta i byte nel buffer di RAM. Raggiunto l'offset 254 di un blocco non terminale, l'API preleva autonomamente i byte di collegamento, commuta fisicamente i registri `$DE03` e `$DE01` sul nuovo blocco, azzera l'offset e prosegue la lettura senza interrompere il flusso. Ciò consente streaming virtualmente istantanei, perfetti per caricare grafica Multicolor complessa in tempo reale.
Durante la scrittura con `mdp_fwrite`, al termine di un blocco l'API interroga la BAM per reperire spazio, aggiorna i puntatori del blocco in esaurimento, commuta i registri ed avanza sul nuovo blocco trasparente per il chiamante.

---

## 5. Algoritmi di Rilevamento Hardware (Detection)

Per identificare le memorie installate, le librerie software eseguono routine di rilevamento sicure. 

Per effettuare il rilevamento della SRAM, il sistema abilita la Portion 1 e la Pagina 255 per poi leggere gli offset `$FE` e `$FF`. Se i valori letti corrispondono alla firma esadecimale `$CA, $F1`, la SRAM è marcata come hardware presente e già inizializzato. In caso di firma mancante o dati casuali, la libreria tenta una sequenza di memorizzazione e rilettura dei valori firma per appurare la presenza del chip. Se il chip risponde ma il drive risulta non formattato, si può invocare la funzione `mdp_format`, che azzera la RAM, imposta la BAM e inscrive permanentemente la firma fisica nell'ultimo blocco.

Algoritmi simili vengono eseguiti scansionando le pagine 31 e 127 a EEPROM attivata per identificare l'eventuale presenza e taglio delle memorie EEPROM basandosi sull'aliasing degli indirizzi.

---

## 6. Considerazioni Hardware Avanzate e Temporizzazioni

La progettazione di cartucce espanse comporta sfide tecniche specifiche per l'architettura a 8-bit originale del Commodore 64:

### Gestione del Clock e Integrazione del Segnale `PHI2`
L'utilizzo esclusivo della linea `/IO1` per attivare il *latching* dei banchi può innescare severe instabilità hardware sui C64 revisionati. Il segnale `/IO1` si attiva infatti non appena gli indirizzi decodificati corrispondono, ovvero prima che il bus dati sia elettricamente stabile. Il segnale `PHI2` definisce la finestra temporale corretta in cui i dati sono garantiti e pronti per essere agganciati. Per assicurare la massima affidabilità su tutte le motherboard, il circuito di trigger deve basarsi sull'equazione booleana:

$$\text{Output} = \text{NOT}(\text{/IO1} \text{ OR } \text{NOT}(\text{PHI2}))$$

### Corruzione da Lettura e Conflitti
Nelle implementazioni hardware meno raffinate che non decodificano la linea `R/W` (Read/Write), un'istruzione di lettura come `LDA $DE00` può generare un inatteso impulso di clock sul flip-flop. Questo memorizzerà dati instabili prelevati dal bus, cambiando banco in modo casuale e corrompendo l'esecuzione. 

Inoltre, poiché la ROM copre la finestra `$8000-$9FFF`, essa non sovrascrive i vettori di interrupt in cima alla memoria (`$FFFA-$FFFF`). Un segnale IRQ o NMI genererà un salto ai vettori del KERNAL ROM; qualora questo sia stato escluso dal layout memoria, il programmatore è obbligato a riprogettare la mappa allocando vettori personalizzati nei banchi attivi.

### Limiti di Velocità su Commodore 128
Sebbene il progetto sia pienamente compatibile con un Commodore 128 in modalità emulazione, il suo utilizzo in modalità nativa a 2 MHz potrebbe causare problemi dovuti ai cicli di bus dimezzati. In questo caso potrebbe essere una buona idea sostituire i chip logici della serie `74LS` con quelli della serie `74HCT` o `74AHCT` per tollerare la frequenza accelerata del sistema.

---

## 7. Analisi Comparativa Formati

Per contestualizzare la Magic Desk Plus nell'ecosistema di retrocomputing, è essenziale valutarla rispetto agli standard rivali storici e moderni:

| Caratteristica | Magic Desk Standard | Magic Desk Plus | Formato Ocean | EasyFlash |
| :--- | :--- | :--- | :--- | :--- |
| **Finestra di Memoria** | `$8000-$9FFF` (8 KB)  | `$8000-$9FFF` (8 KB) | `$8000` / `$A000` (8 o 16 KB)  | `$8000` + `$A000` (16 KB)  |
| **Memoria Persistente** | Assente | **SRAM 128 KB** + EEPROM | Assente | Flash ROM (1 MB) + 256 Byte di SRAM |
| **RAM di Servizio I/O** | Assente | **Finestra da 256 Byte** | Assente | Finestra da 256 Byte  |
| **Logica di Banking** | Scrittura in `$DE00`  | Scrittura in `$DE00`, `$DE01`, `$DE03` | Scrittura in `$DE00`  | Registri `$DE00` e `$DE02`  |
| **Complessità Hardware** | Molto Bassa  | **Bassa** (Nessun componente custom)  | Bassa  | Media/Alta (Richiede CPLD)  |
