# Routine Sequenziali Individuate

Di seguito è riportato l'elenco delle routine individuate nei file `gromance.asm`, `oriv1.asm`, `qriv2.asm`, `vlove.asm` e `wriv4.asm` che rispettano tutti i criteri richiesti:
- Richiamate tramite `JSR`
- Flusso di codice sequenziale
- Senza ulteriori ingressi dall'esterno (le eventuali label interne non sono referenziate al di fuori della routine)
- Senza "buchi" di codice (nessuna direttiva dati come `.BYTE`, frammischiata)
- Dimensione stimata non superiore a 256 byte.

### `gromance.asm`
- **sE33A** (~17 byte) - Label interne: `bE344`, `bE33C`
- **sEB58** (~12 byte) - Label interne: `bEB63`
- **sEB92** (~14 byte) - Label interne: `bEB94`
- **sEB9F** (~96 byte) - Label interne: `bEBDF`, `bEBDA`, `bEBCC`, `bEBAA`, `bEBA9`

### `oriv1.asm`
- **s3190** (~12 byte) - Label interne: `b3192`
- **s3244** (~56 byte) - Label interne: `b325E`
- **s3405** (~5 byte)

### `qriv2.asm`
- **s7F70** (~38 byte) - Label interne: `b7F88`
- **s802A** (~18 byte) - Label interne: `b803B`, `b8036`
- **s8424** (~46 byte) - Label interne: `b8451`, `b8426`, `b8438`
- **s8452** (~90 byte) - Label interne: `b847A`, `b84A7`, `b8476`
- **s84AC** (~33 byte) - Label interne: `b84CC`
- **s84E1** (~26 byte) - Label interne: `b84EF`
- **s8507** (~45 byte) - Label interne: `b8518`, `b850C`, `b8532`
- **s856C** (~26 byte) - Label interne: `b857F`, `b856E`
- **j85CF** (~91 byte) - Label interne: `b85F0`
- **s87DE** (~63 byte) - Label interne: `b87F2`, `b87F4`
- **s881B** (~31 byte)
- **s883A** (~54 byte)
- **s88E0** (~72 byte) - Label interne: `b8917`, `b8905`, `b8903`, `b88F1`, `b8901`, `b8922`
- **s89A4** (~64 byte) - Label interne: `b89D3`, `b89D8`, `b89B3`, `b89C3`
- **s89E1** (~25 byte) - Label interne: `b89E9`
- **s8D0D** (~19 byte) - Label interne: `b8D1F`
- **j8EE8** (~18 byte) - Label interne: `b8EF9`
- **s91D4** (~26 byte) - Label interne: `b91EB`, `b91E8`
- **s9249** (~12 byte) - Label interne: `b9254`
- **s9555** (~203 byte) - Label interne: `b95E7`, `b95EB`, `b961B`, `b95B7`, `b95A7`, `b95F4`, `b9603`, `b95CF`, `b959A`, `b95A6`
- **s9917** (~28 byte) - Label interne: `b992F`, `b9924`, `b9930`
- **s9932** (~24 byte) - Label interne: `b9943`
- **s999F** (~20 byte) - Label interne: `b99AF`
- **s99EC** (~53 byte) - Label interne: `b99F7`, `b9A20`, `b9A01`
- **s9B10** (~35 byte) - Label interne: `b9B25`
- **sA241** (~156 byte) - Label interne: `bA2B1`, `bA259`, `bA25F`, `bA26B`, `bA251`, `bA2D1`, `bA2C2`, `bA297`
- **sA2D4** (~16 byte) - Label interne: `bA2E0`
- **sA2E4** (~16 byte) - Label interne: `bA2F0`
- **sA3D4** (~14 byte) - Label interne: `bA3D8`
- **sA3E2** (~30 byte) - Label interne: `bA3FF`, `bA3F4`
- **sA7E3** (~42 byte) - Label interne: `bA7E5`, `bA7F1`
- **sA80C** (~42 byte) - Label interne: `bA832`, `bA815`, `bA81E`
- **sA835** (~17 byte) - Label interne: `bA837`
- **sAF6F** (~11 byte)
- **sAF7A** (~13 byte)
- **sB28F** (~34 byte) - Label interne: `bB2A4`, `bB2AB`
- **sB2B1** (~20 byte) - Label interne: `bB2B3`
- **sB2C5** (~79 byte) - Label interne: `bB2D7`, `bB2EB`, `bB2FA`, `bB2C7`
- **sB314** (~21 byte) - Label interne: `bB318`
- **sB60B** (~15 byte) - Label interne: `bB618`, `bB60D`
- **sB7B9** (~12 byte) - Label interne: `bB7BD`
- **sB7CD** (~13 byte)
- **sB7DD** (~13 byte)
- **sB7EA** (~19 byte)
- **sB7FD** (~11 byte)
- **sB808** (~9 byte)
- **sB811** (~12 byte) - Label interne: `bB814`
- **sB81D** (~9 byte) - Label interne: `bB821`
- **sB826** (~16 byte) - Label interne: `bB82C`
- **sB836** (~27 byte) - Label interne: `bB838`
- **sB859** (~55 byte) - Label interne: `bB88F`, `bB881`, `bB85F`, `bB86F`
- **sB8A2** (~54 byte) - Label interne: `bB8D4`, `bB8D5`, `bB8AC`, `bB8C2`
- **sB8E0** (~65 byte) - Label interne: `bB8E6`, `bB907`, `bB920`, `bB8F6`, `bB91E`
- **sBA24** (~41 byte) - Label interne: `bBA2E`, `bBA3B`

### `vlove.asm`
- **sE7B2** (~9 byte) - Label interne: `bE7BA`
- **sEA96** (~23 byte) - Label interne: `bEA9C`
- **sEB58** (~12 byte) - Label interne: `bEB63`
- **sEB92** (~14 byte) - Label interne: `bEB94`

### `wriv4.asm`
- **jFBA3** (~187 byte) - Label interne: `bFBEE`, `bFBF0`, `bFC29`, `bFC2C`, `bFC2D`, `bFBBC`, `bFBC4`, `bFBDC`
- **sFD5B** (~8 byte)
- **eFD86** (~45 byte) - Label interne: `bFDA9`, `bFDB0`, `bFDA7`
- **sFDB3** (~1 byte)
