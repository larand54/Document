DECLARE
@Language int = 1,
@Deliver_To varchar(20) = 'Deliver to',
@Ready_Date varchar(20) = 'Ready date',
@SpeditorID varchar(20) = 'Speditor id',
@TRPID varchar(20) = 'TrpID',
@VESSEL varchar(20) = 'Vessel',
@ETD varchar(20) = 'ETD',
@Ca varchar(20) = 'Ca',
@AM3 varchar(20) = 'AM3',
@M2_aB varchar(20) = 'M2 aB',
@M2 varchar(20) = 'M2',
@Sqm_tB varchar(20) = 'M2 tB',
@Run_m_a varchar(20) = 'Rm_a',
@M1 varchar(20) = 'M1',
@m3_aDxaL varchar(20) = 'm3 aDxaL',
@m3_aDxnL varchar(20)= 'm3 aDxnL',
@NM3 varchar(20) = 'NM3',
@m3_nDxaL varchar(20) = 'm3 nDxaL',
@m3_nDxnL varchar(20) = 'm3 nDxnL',
@MFBM_Nom varchar(20) = 'MFBM Nom',
@MFBM varchar(20) = 'MFBM',
@PACKAGES varchar(20) = 'Packages',
@PKGS varchar(20) = 'PKGS',
@HEADAGE varchar(20) = 'Pcs' -- 'Stycketal', -- 'Headage'
@PCS varchar(20) = 'PCS',
@Run_m_n varchar(20) = 'Rm n',
@NOF_STRAPS varchar(20) = 'No of straps: ',
@PRELIMINARY varchar(20) = 'Preliminary',
@NY varchar(20) = 'NEW',
@REJECTED varchar(20) = 'REJECTED',
@ACCEPTED varchar(20) = 'ACCEPTED',
@FINISHED varchar(20) = 'FINISHED',
@WAIT varchar(20) = 'WAIT',
@PROD_READY varchar(20) = 'PROD.READY',
@ANNULLED varchar(20) = 'ANNULLED',
@ANNUL_RECEIVED varchar(20) = 'ANNUL_RECEIVED',
@FETCHED varchar(20) = 'NOTE! TO BE FETCHED!', -- 'Claimed', 'Collected', 'Fetched'
@FOHC varchar(20) = 'FOHC: ',
@NOF_STICKS varchar(20) = 'NO OF STICKS',
@PACKSIZE varchar(20) = 'PACKET SIZE',
@APIECE varchar(20) = 'a piece', -- 'a pice', 'head'
@b_x varchar(20) = 'b x',
@h varchar(20) = 'h,',
@KD varchar(20) = 'KD,',
@BUNDELED varchar(20) = 'BUNDELED',
@FINGERJOINTED varchar(20) = 'FINGER JOINTED',			
@PKG_CUT varchar(20) = 'PACKAGE CUT', --'SVÄRDKAPAS, ',
@PET_TOL varchar(20) = 'PET TOL:',
@LP varchar(20) = 'LP, ',				
@TP varchar(20) = 'TP',
@FOILED varchar(20) = 'FOILED', --'FOLIERAT, ',
@STAMPED varchar(20) = 'STAMPED',
@NO_CODE varchar(20) = 'No code', -- 'Ingen kod',
@TREATED varchar(20) = 'TREATED', --'IMPREGNERAS:',
@PKG_LABEL varchar(20) = 'PKG LABEL', --'PAKETLAPP:',
@PPP varchar(20) = 'PPP',
@CO-LOAD varchar(28) = 'This car shall co-load' --Denna bil skall samlasta'
 
IF @Language = 1 BEGIN

SET @Deliver_To = 'Levereras till:'
SET @Ready_Date ='Redodag:'
SET @SpeditorID = 'Speditörens ID: '
SET @TRPID = 'TrpID: '

SET @VESSEL = 'Fartyg: '
SET @ETD = 'ETD: '
SET @Ca = 'Ca '
SET @AM3 = ' AM3'
SET @M2_aB = 'Kvm aB'
SET @M2 = 'M2'
SET @M2_tB = 'Kvm tB'
SET @Run_m_a = 'Lopm a'
SET @M1 ='M1'
SET @m3_aDxaL = 'm3 aDxaL'
SET @m3_aDxnL = 'm3 aDxnL'
SET @NM3 = 'NM3'
SET @m3_nDxaL = 'm3 nDxaL'
SET @m3_nDxnL = 'm3 nDxnL'
SET @MFBM_Nom = 'MFBM Nom'
SET @MFBM = 'MFBM'
SET @PACKAGES = 'Packages'
SET @PKGS = 'PKGS'
SET @APIECE = 'Stycketal' -- 'Headage'
SET @PCS = 'PCS'
SET @Rum_m_n = 'Lopm n'
SET @NOF_STRAPS = 'ANTAL BAND: '
SET @PRELIMINARY = 'Preliminär'
SET @NY = 'NY'
SET @REJECTED = 'AVSLAG'
SET @ACCEPTED = 'ACCEPTERAD'
SET @FINISHED = 'AVSLUTAD'
SET @WAIT = 'VÄNTA'
SET @PROD_READY = 'PROD.KLAR'
SET @ANNULLED = 'ANNULERAD'
SET @ANNUL_RECEIVED = 'ANNU.MOTTAGEN'
SET @FETCHED = 'OBS! AVHÄMTAS!' -- 'Claimed', 'Collected', 'Fetched'
SET @FOHC = 'FOHC: '
SET @NOF_STICKS = 'ANTAL STRÖ: '
SET @PACKSIZE = 'PAKETSTORLEK: '
SET @APIECE = ' STYCK, ' -- 'a pice', 'head'
SET @b_x = 'b x '
SET @h = 'h, '
SET @KD = 'KD, '
SET @BUNDELED = 'BUNTAT, '
SET @FINGERJOINTED = 'FINGERSKARVAT, '			
SET @PKG_CUT = 'SVÄRDKAPAS, '
SET @PET_TOL = 'PET TOL:'
SET @LP = 'LP, '				
SET @TP = 'TP'
SET @FOILED = 'FOLIERAT, '
SET @STAMPED = 'STÄMPLAS: '
SET @NO_CODE = 'Ingen kod'
SET @TREATED = 'IMPREGNERAS: '
SET @PKG_LABEL = 'PAKETLAPP: '
SET @PPP = ' PPP, '
SET @CO-LOAD = 'Denna bil skall samlasta'
END
SELECT
@CO-LOAD AS SAMLASTAS,
@TREATED AS IMPREGNERAS



























































































































































































































