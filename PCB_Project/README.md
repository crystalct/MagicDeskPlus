Components
---------
- 27C020 or 27C040  or 27C080 PROM/EPROM/FLASH ROM Family (DIP_32) [U4]
- 621025 SRAM Family (DIP_32) [U2]
- AT28C64 or AT28C256 EEProm (PLCC_32) [IC1]
- 74LS273 (or 74HCT273) x2 (SOP_20) [IC2 - IC3]
- 74LS00 (or 74HCT00) (SO_14) [U3]
- 74LS138 (or 74HCT138) (SO_14) [U1]
- 74LS174 (or 74HCT174) (SO_14) [U5]
- 100nF (SMD_0805) x7 [C1, C2, C3, C4, C5, C6, C7]
- 1u/10uF (SMD_0805) [C9]
- 10K Ω (SMD_1206) x5 [R2, R3, R4, R5, R6]
- 1N4148 (SMD_0805) x10 [D1, D2, D3, D4, D5, D6, D7, D8, D11, D12]
- 1N5711 (SMD_0805) x2 Schottky Diode [D9, D10]

**Optional lighting eyes**
- SMD led (SMD_0603) x2 [DE1, DE2] (UP/DOWN reverse mounted to see the light through the hole)
- From 400 to 1K Ω (SMD_1206) [R1]

**Appeareance**

||
|:---:|
|<img width="876" height="601" alt="MagicDeskPlus" src="https://github.com/user-attachments/assets/d4079940-641e-46b6-a437-c79d52b66581" />|

**Schematics**
[MDPlus_schematics.pdf](https://github.com/user-attachments/files/30178454/MDPlus_schematics.pdf)

Jumper configuration
--------------------
**256 KByte ROM**

| JP40 | JP80 |
|:---:|:---:|
|Short 2 and 3|Short 2 and 3|
|<img width="100" height="63" alt="j2" src="https://github.com/user-attachments/assets/5e5e47a4-206f-4ab7-aa2a-175475e95891" />|<img width="100" height="63" alt="j2" src="https://github.com/user-attachments/assets/5e5e47a4-206f-4ab7-aa2a-175475e95891" />|

**512 KByte ROM**

| JP40 | JP80 |
|:---:|:---:|
|Short 1 and 2|Short 2 and 3|
|<img width="100" height="64" alt="j1" src="https://github.com/user-attachments/assets/9a617420-88bc-4c8a-b896-771ad57910b7" />|<img width="100" height="63" alt="j2" src="https://github.com/user-attachments/assets/5e5e47a4-206f-4ab7-aa2a-175475e95891" />|

**1 MByte ROM**

| JP40 | JP80 |
|:---:|:---:|
|Short 1 and 2|Short 1 and 2|
|<img width="100" height="64" alt="j1" src="https://github.com/user-attachments/assets/9a617420-88bc-4c8a-b896-771ad57910b7" />|<img width="100" height="64" alt="j1" src="https://github.com/user-attachments/assets/9a617420-88bc-4c8a-b896-771ad57910b7" />|
