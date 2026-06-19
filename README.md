# Specifiche Tecniche Avanzate: Cartuccia Magic Desk Plus per Commodore 64

## 1. Introduzione: Il Formato Magic Desk Standard

[cite_start]Il formato di cartuccia **Magic Desk** nacque originariamente nel 1983 da un progetto di Commodore Business Machines, concepito per ospitare una suite di software di produttività semplificata (comprendente moduli come *Type and File*, *Spreadsheet* e *Financial Planning*)[cite: 68, 70]. [cite_start]L'obiettivo fondamentale dei progettisti era mantenere il software residente in memoria, azzerando completamente i tempi di caricamento estenuanti del drive a disco o del Datassette[cite: 70]. [cite_start]Sebbene commercialmente sia stato rilasciato solo il modulo *Type and File*, l'eredità tecnica dell'architettura hardware è sopravvissuta per decenni[cite: 72].

### Interfaccia Hardware e Segnali del Porto di Espansione
[cite_start]L'operatività di una cartuccia Magic Desk standard è legata alla gestione dei segnali elettrici sul porto di espansione a 44 pin del Commodore 64[cite: 75]. [cite_start]La configurazione standard prevede il segnale `/EXROM` portato a livello basso (massa) e il segnale `/GAME` mantenuto a livello alto[cite: 79, 80]. 

[cite_start]Questa impostazione istruisce il PLA (Programmable Logic Array) del C64 a mappare 8 KB di ROM esterna nella finestra di memoria compresa tra `$8000` e `$9FFF`, mantenendo inalterati il BASIC ROM e il KERNAL ROM[cite: 81].

### Architettura del Memory Banking: Il Registro `$DE00`
[cite_start]A differenza di altre cartucce, la Magic Desk adotta un *data-type banking*, dove il cambio di banco è innescato dal valore del dato scritto[cite: 91, 171]. [cite_start]Il cuore del sistema è un registro hardware di *latching* (solitamente un chip 74LS273) che si attiva quando la CPU scrive un byte nell'area di I/O compresa tra `$DE00` e `$DEFF`[cite: 84, 85, 89].

La struttura del byte di controllo scritto in `$DE00` è la seguente:
* [cite_start]**Bit 0-5 (o 0-6):** Definiscono quale banco da 8 KB della ROM debba slittare sotto la finestra `$8000-$9FFF`[cite: 94]. [cite_start]Con 7 bit è possibile indirizzare fino a 128 banchi, pari a 1 MB di memoria[cite: 95].
* [cite_start]**Bit 7 (Controllo di Disabilitazione):** Funge da interruttore globale[cite: 96]. [cite_start]Se impostato a 1 (valori `>= $80`), la circuiteria forza la linea `/EXROM` a uno stato logico alto, disabilitando istantaneamente la cartuccia e ripristinando la RAM interna del C64 nell'area `$8000-$9FFF`[cite: 97, 98, 99].

### Sfruttamento Software: La Tecnica del Trampolino
[cite_start]Poiché il processore 6502 non può cambiare il banco ROM "sotto se stesso" senza interpretare dati casuali e causare un crash, i programmatori ricorrono alla tecnica del trampolino (*trampoline code*)[cite: 126, 128, 129]. [cite_start]Il software copia una piccola routine di banking nella RAM del C64 (ad esempio nello Stack o in pagina 3), disabilita gli interrupt (`SEI`), esegue la scrittura in `$DE00`, salta al nuovo banco ROM e riabilita gli interrupt (`CLI`)[cite: 130, 131, 132, 133, 134, 135, 136].

[cite_start]Affinché il KERNAL avvii automaticamente la cartuccia all'accensione, il Banco 0 deve contenere i vettori di avvio (Cold e Warm Start) e la firma PETSCII `"CBM80"` a partire dall'indirizzo `$8000`[cite: 138, 139].

---

## 2. Architettura Hardware della Magic Desk Plus

La **Magic Desk Plus** espande radicalmente le specifiche del formato classico. Oltre a supportare una memoria ROM fino a 1 MByte, introduce una **SRAM statica da 128 KByte** supportata da una batteria tampone, affiancata in alcune varianti da una memoria EEPROM.

[cite_start]Per gestire questo spazio aggiuntivo mantenendo il registro `$DE00` inalterato, la cartuccia introduce una finestra di transito dati dedicata e due nuovi registri nell'area di I/O 1[cite: 1, 2]:

* **Finestra di I/O Dati (`$DF00 - $DFFF`):** Una finestra di accesso fissa da 256 byte mappata direttamente sulla pagina di memoria SRAM o EEPROM attualmente attiva.
* **Registro di Pagina (`$DE01`):** Registro *Write-only* preposto alla selezione della pagina da 256 byte (valori da 0 a 255) da proiettare nella finestra di transito.
* **Registro di Controllo (`$DE03`):** Registro *Write-only* deputato all'abilitazione e alla configurazione della SRAM.

### Configurazione del Registro di Controllo `$DE03`
Essendo `$DE03` un registro in sola scrittura, il processore 6502 non può leggerne lo stato. È perciò obbligatorio mantenere una copia ombra (*shadow register*) nella RAM di sistema (es. `mdp_ctrl_shadow`) per applicare modifiche bitwise in modo sicuro.

* **Bit 0:** Seleziona le due porzioni di SRAM. Scrivendo `0` si utilizza la prima porzione da 64 KByte; scrivendo `1` si utilizza la seconda porzione da 64 KByte. [cite_start]All'accensione è selezionata di default la prima porzione[cite: 7].
* **Bit 3 o Bit 5:** Attiva o disattiva la SRAM effettuando la commutazione con l'eventuale EEPROM. Se impostato a `1`, la SRAM è abilitata; se impostato a `0`, la SRAM è disattivata e subentra la EEPROM. All'accensione, la SRAM è disattivata per default.

---

## 3. Gestione e Programmazione della EEPROM

L'architettura Magic Desk Plus prevede la coesistenza della SRAM con memorie non volatili di tipo EEPROM (nei tagli da 8 KB o 32 KB). EEPROM e SRAM condividono la stessa finestra hardware di I/O (`$DF00-$DFFF`) e lo stesso registro di pagina `$DE01`. La selezione esclusiva dell'una o dell'altra si effettua disabilitando il flag della SRAM in `$DE03`.

A seconda della EEPROM installata, la selezione della pagina risponde a maschere hardware fisse. Una EEPROM da 8 KB (32 pagine) risponde alla maschera `0x1F` ignorando i bit superiori di `$DE01`, mentre una da 32 KB (128 pagine) usa la maschera `0x7F` e ignora il bit 7.

A differenza della SRAM che permette scritture immediate, la programmazione di una cella EEPROM impone un tempo fisico di memorizzazione che può arrivare fino a 10 millisecondi per operazione. Il software deve tassativamente inserire un *delay loop* (ciclo di ritardo software) subito dopo ogni istruzione di memorizzazione nella finestra `$DF00-$DFFF`, per impedire che cambi di pagina o nuove scritture corrompano il processo in corso.

---

## 4. Il File System MDP-FS (MagicDesk Plus File System)

[cite_start]Il **MagicDesk Plus File System (MDP-FS)** è un'architettura software progettata per gestire i 128 KiB di SRAM persistente e trasformarli in un "RAM Disk" ad altissime prestazioni[cite: 14].

### Filosofia di Allocazione Concatenata (1541-Style)
[cite_start]Per eliminare la frammentazione ed alleggerire il carico sul processore MOS 6502, MDP-FS adotta un'allocazione a blocchi concatenati ispirata alla logica di formattazione del Commodore 1541[cite: 18, 19]. [cite_start]Ogni pagina hardware da 256 byte corrisponde esattamente a un singolo blocco logico[cite: 20].

[cite_start]Ciascun blocco sacrifica sistematicamente gli ultimi due byte (offset `$FE` e `$FF`) per ospitare i puntatori di concatenazione (*Pointer Linking*), offrendo **254 byte di dati netti per blocco**[cite: 21, 22]:
* [cite_start]**Byte 0 - 253 (Offset `$00` - `$FD`):** Settore dati netto (Payload)[cite: 22].
* [cite_start]**Byte 254 (Offset `$FE`):** Indica la Portion SRAM (0 o 1) in cui risiede il blocco successivo[cite: 23, 25]. [cite_start]Se impostato a `$FF`, indica la fine assoluta del file (EOF)[cite: 24].
* [cite_start]**Byte 255 (Offset `$FF`):** Se il blocco non è l'ultimo, indica l'indice della pagina successiva da mappare in `$DE01`[cite: 26]. [cite_start]Se il blocco è terminale (EOF), contiene il numero esatto di byte validi nell'area dati (da 1 a 254)[cite: 27].

### Layout Fisso della Memoria SRAM
[cite_start]La mappa della SRAM è rigidamente partizionata per garantire il boot e la persistenza dei metadati strutturali[cite: 28, 29]:

| Portion | Pagina | Destinazione d'Uso |
| :--- | :--- | :--- |
| **0** | 0 | [cite_start]**Directory Principale:** Entry descrittive dei file[cite: 30]. |
| **0** | 1 | [cite_start]**BAM:** Mappa di allocazione a bit per i 512 blocchi complessivi[cite: 30]. |
| **0 e 1** | Varie | [cite_start]**Dati Utente:** Blocchi disponibili per lo storage[cite: 30]. |
| **1** | 255 | **Blocco Hardware:** Gli ultimi due byte (`$FE` e `$FF`) devono tassativamente ospitare la signature nativa `$CA, $F1`. |

### Struttura della Directory
[cite_start]Una singola pagina di directory ospita esattamente 8 entry da 32 byte ciascuna[cite: 31, 32]. [cite_start]Ogni entry definisce la struttura del file[cite: 33]:
* [cite_start]**Byte 0-15:** Nome PETSCII del file[cite: 34].
* [cite_start]**Byte 16-17:** Portion e Pagina del blocco iniziale[cite: 35, 36].
* [cite_start]**Byte 18-19:** Word a 16 bit (Little-Endian) con il totale dei blocchi allocati[cite: 37].
* [cite_start]**Byte 20:** Flag di stato (es. `$01` = Attivo, `$02` = In scrittura, `$80` = Eliminato)[cite: 38].
* [cite_start]**Byte 21-31:** Spazio riservato per estensioni[cite: 39].

### Flusso Logico delle API (`mdp_fread` e `mdp_fwrite`)
[cite_start]Le API di MDP-FS astraggono completamente la manipolazione hardware per le applicazioni[cite: 41]. 
[cite_start]Durante la lettura di uno stream tramite `mdp_fread`, l'API legge sequenzialmente la finestra `$DF00` e sposta i byte nel buffer di RAM[cite: 53, 54]. [cite_start]Raggiunto l'offset 254 di un blocco non terminale, l'API preleva autonomamente i byte di collegamento, commuta fisicamente i registri `$DE03` e `$DE01` sul nuovo blocco, azzera l'offset e prosegue la lettura senza interrompere il flusso[cite: 55]. Ciò consente streaming virtualmente istantanei, perfetti per caricare grafica Multicolor complessa in tempo reale.
[cite_start]Durante la scrittura con `mdp_fwrite`, al termine di un blocco l'API interroga la BAM per reperire spazio, aggiorna i puntatori del blocco in esaurimento, commuta i registri ed avanza sul nuovo blocco trasparente per il chiamante[cite: 56, 57, 58].

---

## 5. Algoritmi di Rilevamento Hardware (Detection)

Per identificare le memorie installate, le librerie software eseguono routine di rilevamento sicure. 

Per effettuare il rilevamento della SRAM, il sistema preleva il registro shadow, abilita la Portion 1 e la Pagina 255 per poi leggere gli offset `$FE` e `$FF`. Se i valori letti corrispondono alla firma esadecimale `$CA, $F1`, la SRAM è marcata come hardware presente e già inizializzato. In caso di firma mancante o dati casuali, la libreria tenta una sequenza di memorizzazione e rilettura dei valori firma per appurare la presenza del chip. [cite_start]Se il chip risponde ma il drive risulta non formattato, si può invocare la funzione `mdp_format`, che azzera la RAM, imposta la BAM e inscrive permanentemente la firma fisica nell'ultimo blocco[cite: 46, 47, 48].

Algoritmi simili vengono eseguiti scansionando le pagine 31 e 127 a SRAM disattivata per identificare l'eventuale presenza e taglio delle memorie EEPROM basandosi sull'aliasing degli indirizzi.

---

## 6. Considerazioni Hardware Avanzate e Temporizzazioni

La progettazione di cartucce espanse comporta sfide tecniche specifiche per l'architettura a 8-bit originale del Commodore 64:

### Gestione del Clock e Integrazione del Segnale `PHI2`
[cite_start]L'utilizzo esclusivo della linea `/IO1` per attivare il *latching* dei banchi può innescare severe instabilità hardware sui C64 revisionati[cite: 167]. [cite_start]Il segnale `/IO1` si attiva infatti non appena gli indirizzi decodificati corrispondono, ovvero prima che il bus dati sia elettricamente stabile[cite: 168]. [cite_start]Il segnale `PHI2` definisce la finestra temporale corretta in cui i dati sono garantiti e pronti per essere agganciati[cite: 169]. [cite_start]Per assicurare la massima affidabilità su tutte le motherboard, il circuito di trigger deve basarsi sull'equazione booleana[cite: 170]:

$$\text{Output} = \text{NOT}(\text{/IO1} \text{ OR } \text{NOT}(\text{PHI2}))$$

### Corruzione da Lettura e Conflitti
[cite_start]Nelle implementazioni hardware meno raffinate che non decodificano la linea `R/W` (Read/Write), un'istruzione di lettura come `LDA $DE00` può generare un inatteso impulso di clock sul flip-flop[cite: 174]. [cite_start]Questo memorizzerà dati instabili prelevati dal bus, cambiando banco in modo casuale e corrompendo l'esecuzione[cite: 174]. 

[cite_start]Inoltre, poiché la ROM copre la finestra `$8000-$9FFF`, essa non sovrascrive i vettori di interrupt in cima alla memoria (`$FFFA-$FFFF`)[cite: 175]. [cite_start]Un segnale IRQ o NMI genererà un salto ai vettori del KERNAL ROM; qualora questo sia stato escluso dal layout memoria, il programmatore è obbligato a riprogettare la mappa allocando vettori personalizzati nei banchi attivi[cite: 176].

### Limiti di Velocità su Commodore 128
[cite_start]Sebbene il progetto sia pienamente compatibile con un Commodore 128 in modalità emulazione, il suo utilizzo in modalità nativa a 2 MHz causa problemi a causa dei cicli di bus dimezzati[cite: 177]. [cite_start]I chip standard come il `74LS273` richiedono di essere rimpiazzati con logiche più reattive quali la serie 74HCT o 74AHCT per tollerare la frequenza accelerata del sistema[cite: 178].

---

## 7. Analisi Comparativa Formati

Per contestualizzare la Magic Desk Plus nell'ecosistema di retrocomputing, è essenziale valutarla rispetto agli standard rivali storici e moderni:

| Caratteristica | Magic Desk Standard | Magic Desk Plus | Formato Ocean | EasyFlash |
| :--- | :--- | :--- | :--- | :--- |
| **Finestra di Memoria** | [cite_start]`$8000-$9FFF` (8 KB) [cite: 81] | `$8000-$9FFF` (8 KB) | [cite_start]`$8000` / `$A000` (8 o 16 KB) [cite: 157] | [cite_start]`$8000` + `$A000` (16 KB) [cite: 160, 164] |
| **Memoria Persistente** | Assente | **SRAM 128 KB** + EEPROM | Assente | [cite_start]Flash ROM (1 MB) [cite: 160] |
| **RAM di Servizio I/O** | Assente | **Finestra da 256 Byte** | Assente | [cite_start]Finestra da 256 Byte [cite: 162] |
| **Logica di Banking** | [cite_start]Scrittura in `$DE00` [cite: 92] | Scrittura in `$DE00`, `$DE01`, `$DE03` | [cite_start]Scrittura in `$DE00` [cite: 164] | [cite_start]Registri `$DE00` e `$DE02` [cite: 164] |
| **Complessità Hardware** | [cite_start]Molto Bassa [cite: 164] | [cite_start]**Bassa** (Nessun componente custom) [cite: 107, 182] | [cite_start]Bassa [cite: 164] | [cite_start]Media/Alta (Richiede CPLD) [cite: 160, 163] |
