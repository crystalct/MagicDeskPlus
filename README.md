# Specifiche Tecniche: Cartuccia Magic Desk Plus per Commodore 64

## 1. Introduzione: Il Formato Magic Desk Standard
Il formato di cartuccia **Magic Desk** nacque originariamente nel 1983 da un progetto di Commodore Business Machines volto a ospitare una suite di software di produttività semplificata residente in memoria, azzerando i tempi di caricamento dei drive a disco o a nastro. 

L'architettura hardware di una Magic Desk standard prevede l'attivazione della cartuccia tramite i segnali del porto di espansione, configurando la linea `/EXROM` a livello basso e `/GAME` a livello alto. Questa impostazione istruisce il PLA (Programmable Logic Array) del Commodore 64 a mappare una finestra fissa di ROM esterna da **8 KB** nell'intervallo di indirizzi **`$8000 - $9FFF`**.

Il cuore del meccanismo di *bank switching* (commutazione dei banchi) risiede nel registro ad indirizzo **`$DE00`** (attivato dal segnale di I/O `/IO1`). A differenza di altri formati, la Magic Desk adotta un *data-type banking*, in cui la selezione del banco avviene tramite il valore del byte scritto nel registro:
* **Bit 0-5 (o 0-6):** Definiscono quale sezione da 8 KB della ROM debba slittare sotto la finestra `$8000-$9FFF`, consentendo di indirizzare fino a 64 banchi (512 KB) o 128 banchi (1 MB).
* **Bit 7 (Controllo di Disabilitazione):** Se impostato a 1 (valori `>=$80`), il circuito hardware forza la linea `/EXROM` a livello alto, disattivando istantaneamente la visibilità della cartuccia e ripristinando la RAM interna del C64 nell'area `$8000-$9FFF`.

A livello software, il cambio di banco richiede l'adozione di una routine di "trampolino" (*trampoline code*) preventivamente copiata nella RAM di sistema (es. in pagina tre o nello stack)[cite: 131]. Questo impedisce il crash della CPU dovuto alla scomparsa del codice in esecuzione "sotto se stessa" al momento della scrittura in `$DE00`. Per l'avvio automatico al boot, il banco 0 deve tassativamente ospitare la stringa di identificazione PETSCII **`"CBM80"`** all'indirizzo `$8004`, unitamente ai vettori di Cold e Warm Start nei primi quattro byte.

---

## 2. Architettura Hardware della Magic Desk Plus
La **Magic Desk Plus** rappresenta un'evoluzione massiccia dello standard di base[cite: 1]. Essa espande lo spazio di memorizzazione portando la capacità della ROM fino a **1 MByte** e introducendo una **SRAM statica persistente da 128 KByte** (mantenuta da una batteria tampone) affiancata, in alcune varianti, da una memoria **EEPROM** da 8 KB o 32 KB.

Mentre il registro `$DE00` conserva la sua funzione nativa per la commutazione dei banchi di ROM, l'accesso e il controllo della memoria persistente avvengono mediante l'introduzione di due nuovi registri mappati nell'area di I/O 1 (`$DE01` e `$DE03`) e di una finestra di transito dati dedicata:

* **Finestra di I/O Dati (`$DF00 - $DFFF`):** È una finestra di accesso fissa da 256 byte mappata sulla pagina di memoria persistente (SRAM o EEPROM) attualmente attiva.
* **Registro di Pagina (`$DE01` - PAGE_REG):** Registro in sola scrittura (*Write-only*) adibito alla selezione della pagina da 256 byte da proiettare nella finestra `$DF00-$DFFF`.
* **Registro di Controllo (`$DE03` - CTRL_REG):** Registro in sola scrittura (*Write-only*) deputato alla configurazione e abilitazione dei chip di memoria volatile e non volatile.

### Strategia dello Shadow Register per `$DE03`
Essendo `$DE03` un registro *Write-only*, la CPU 6502 non è in grado di rileggerne lo stato tramite istruzioni di *Load* (es. `LDA`). È obbligo dello sviluppatore riservare una locazione nella RAM interna del C64 (denominata `mdp_ctrl_shadow`) per conservare una copia specchio dello stato dei bit. Qualsiasi modifica deve essere applicata prima sulla variabile shadow tramite operatori logici bitwise (`AND`/`OR`) e successivamente trasmessa fisicamente al registro hardware.

La allocazione dei bit del registro `$DE03` è strutturata come segue:
* **Bit 0 (SRAM_BANK_SELECT):** Seleziona la porzione attiva di SRAM da 64 KB. Lo stato `0` seleziona la prima porzione (Portion 0); lo stato `1` seleziona la seconda porzione (Portion 1).
* **Bit 3 o Bit 5 (MEMORY_SELECT):** Controlla l'attivazione della SRAM e lo switch mutuamente esclusivo con la EEPROM. Al boot/accensione, questo flag è azzerato di default, mantenendo la SRAM disattivata e la EEPROM abilitata. Il settaggio del bit abilita l'accesso alla SRAM escludendo la EEPROM.

---

## 3. Gestione e Programmazione della EEPROM
L'hardware permette l'interfacciamento con memorie EEPROM (es. serie AT28C64 o AT28C256) che condividono con la SRAM la medesima finestra di I/O (`$DF00-$DFFF`) e il medesimo registro delle pagine (`$DE01`).

### Paging e Maschere Hardware
A seconda del taglio della EEPROM installata sulla cartuccia, la scrittura dell'indice di pagina nel registro `$DE01` risponde a specifiche maschere logiche di limitazione:
* **EEPROM da 8 KB:** Suddivisa in 32 pagine da 256 byte ciascuna. Accetta indici di pagina da 0 a 31; i bit 5-7 del registro vengono ignorati hardware (maschera `0x1F`).
* **EEPROM da 32 KB:** Suddivisa in 128 pagine da 256 byte ciascuna. Accetta indici da 0 a 127; il bit 7 del registro viene ignorato (maschera `0x7F`).

### Vincoli di Temporizzazione della Scrittura
A differenza della SRAM, la quale supporta operazioni di scrittura alla velocità nominale del bus del C64, i chip EEPROM richiedono una temporizzazione fisica interna per completare la scrittura della cella (fino a 10 ms per ciclo). 
Il programmatore deve inserire una routine di ritardo (*delay loop*) subito dopo ogni istruzione di memorizzazione nell'area `$DF00-$DFFF`, bloccando l'esecuzione prima di alterare il registro delle pagine, cambiare banco o effettuare una nuova scrittura. Un esempio in linguaggio Assembly prevede l'utilizzo di registri indice nidificati per generare l'attesa richiesta:

```assembly
; Esempio di scrittura su EEPROM (Pagina $12, Offset $34, Valore $A5)
lda mdp_ctrl_shadow
and #$DF             ; Bit 5 a 0 per selezionare EEPROM
sta mdp_ctrl_shadow
sta $DE03
lda #$12             ; Pagina $12
sta $DE01
lda #$A5             ; Valore da scrivere
sta $DF34            ; Scrittura nella finestra I/O

; Loop di ritardo hardware (~10ms)
ldx #$14
delay_outer:
ldy #$FF
delay_inner:
dey
bne delay_inner
dex
bne delay_outer
