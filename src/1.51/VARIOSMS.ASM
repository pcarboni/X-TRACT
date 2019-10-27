REGISTERED:
                DB ' REGISTERED VERSION'
		DB 0DH,0AH,'$'
BETA:
                DB ' BETA-TEST VERSION'
		DB 0DH,0AH,'$'
DISTROSITE:
                DB ' DISTR. SITE VERSION'
		DB 0DH,0AH,'$'
SPECIAL:
                DB ' SPECIAL VERSION'
		DB 0DH,0AH,'$'
NOPATENT:
                DB '  No patent ;-('
		DB 0DH,0AH,'$'
HELPNOPATENT:
		DB 'This program is freeware, please spread it FREELY'
		db 0dh,0ah,'$'
HELPWITHKEY:
		DB 'This copy is registered to: ','$'
HELPTEXT:
                DB 0dh,0ah,'Usage: X-TRACT [d:][/path]filename.ext',0dh,0ah,0ah
                DB '$'
NAMEFILE:
		DB 0dh,0ah,'Opening : ','$'
NOFOUND:
		DB 0dh,0ah,'Could not find the file!',0dH,0aH,'$'
FOUNDPRG:
		DB 0dh,0ah,'Found '
		DB '$'
NOTOUCHED:
		DB 0Dh,0ah,'No known program found!',0dh,0ah,'$'
NOTMEMO:
		DB 0dh,0ah,'Not enough memory - Remove some TSR',27H,'s & '
		DB 'Try Again!',0dh,0ah,'$'
FUCKED:
		DB 0dH,0aH,'Saving file ...$'
DONE:
		DB ' done ! ...',0dh,0ah,'$'
REMOVE:
		DB ', remove? [Y/N] $'
OVERLAYMSG:
		DB 0dh,0ah,'Overlays detected in $'
COPYMSG:
		DB '!, copy? [Y/N] $'
CARRIAGE:
		DB 0dh,0ah,'$'
FAKEXTR141520:
		DB 0dh,0ah,'Do you want to fake PKLITE signature? [Y/N] $'
PASSWORD:
                DB 0dh,0ah,'Enter a password for this file compressed with'
                DB ' TINYPROG:',0dh,0ah
                DB '$'
