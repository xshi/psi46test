log === startdigmod ===

--- set voltages ----------------------------
vd 2500 mV
id  800 mA
va 1600 mV
ia  800 mA

--- setup timing & levels -------------------
clk  4
sda 19  (CLK + 15)
ctr  4  (CLK + 0)
tin  9  (CLK + 5)

clklvl 15
ctrlvl 15
sdalvl 15
tinlvl 15

--- power on --------------------------------
pon
mdelay 400
resoff
mdelay 200

getid
getia


a1 1
udelay 100

a2 3
udelay 100

--- setup TBM -------------------------------
modsel b11111
modsel 0

tbmset $E4 $F0    Init TBM, Reset ROC
tbmset $F4 $F0
tbmset $E0 $00    open for full module 
tbmset $F0 $00
tbmset $E2 $C0    Mode = Calibration
tbmset $F2 $C0
tbmset $E8 $02    Set PKAM Counter
tbmset $F8 $02
tbmset $EA $00 Delays (?)
tbmset $FA $00
tbmset $EC $00    Temp measurement control
tbmset $FC $00


mdelay 100

--- setup all ROCs --------------------------
select :

dac   1   8  Vdig 
dac   2 120  Vana
dac   3  40  Vsf
dac   4  12  Vcomp

dac   7  60  VwllPr
dac   9  60  VwllPr
dac  10 117  VhldDel
dac  11   1  Vtrim
dac  12  40  VthrComp

dac  13  30  VIBias_Bus
dac  14   6  Vbias_sf
dac  22  99  VIColOr

dac  15  60  VoffsetOp
dac  17 150  VoffsetRO
dac  18  45  VIon

dac  19  50  Vcomp_ADC 100
dac  20  70  VIref_ADC 160

dac  25  170  Vcal
dac  26  68  CalDel

dac  $fe 45  WBC
dac  $fd  4  CtrlReg
flush

mask

--select 2
--cole :
--pixe : 10 0
--cal  :41 10

--select 5
--cole :
--pixe : 10 0
--cal  :9 10


--- setup probe outputs ---------------------
a2 1  sdata
udelay 100
a1 3  ctr
udelay 100
d1 20 
udelay 100
d2 22
udelay 100

--- setup readout timing --------------------
pgstop
pgset 0 b010000  20  pg_rest
pgset 1 b000000   0
pgsingle

pgset 0 b001000  15  pg_rest
pgset 1 b000100  50  pg_cal
pgset 2 b100010   0  pg_trg pg_sync

--- pgloop 20000

flush
