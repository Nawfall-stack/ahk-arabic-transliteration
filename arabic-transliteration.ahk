; ==============================================================================
; AHK Arabic Transliteration Keyboard
; Ketik huruf Latin, hasilkan huruf Arab (skema mengikuti keyboard Lexilogos).
;
; Versi    : 1.0.0
; Butuh    : AutoHotkey v2.0+
; Toggle   : Ctrl+Alt+A  (hidupkan / matikan mode Arab)
; Lisensi  : MIT (lihat LICENSE)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Pengaturan -------------------------------------------------------------
active  := false   ; true = mode Arab langsung aktif saat script dijalankan
token   := ""      ; rangkaian tombol yang sedang membentuk satu kombinasi
lastOut := ""      ; teks Arab yang sedang tampil untuk token tersebut

; --- Tabel pemetaan -----------------------------------------------------------
m := Map(
    ; Huruf dasar
    "a","ا", "b","ب", "t","ت", "t'","ث", "j","ج",
    "H","ح", "H'","خ", "d","د", "d'","ذ", "r","ر",
    "z","ز", "s","س", "s'","ش",
    "S","ص", "D","ض", "T","ط", "Z","ظ",
    "g","ع", "g'","غ",
    "f","ف", "q","ق", "k","ك", "l","ل", "m","م",
    "n","ن", "h","ه",
    "w","و", "u","و",
    "y","ي", "i","ي", "e","ي",

    ; Alias tambahan (bukan bagian dari tabel Lexilogos; hapus jika tidak perlu)
    "S'","ض", "T'","ظ",

    ; Karakter khusus
    "Y","ى",      ; alif maqshurah
    "h'","ة",     ; ta marbuthah
    "aa","آ",     ; alif madd

    ; Hamzah
    "-","ء",
    "-a","أ",
    "--","ء", "--a","ءا",
    "a-","اء", "a--","إ",
    "y-","يء", "y--","ئ",
    "i-","يء", "i--","ئ",
    "e-","يء", "e--","ئ",
    "w-","وء", "w--","ؤ",
    "u-","وء", "u--","ؤ",

    ; Harakat
    "=","=", "==","==",
    "=a","َ", "=i","ِ", "=u","ُ",          ; fathah, kasrah, dhammah
    "==a","ً", "==i","ٍ", "==u","ٌ",       ; tanwin
    "=w","ّ",                              ; syaddah
    "=o","ْ"                               ; sukun
)

; --- Toggle mode Arab -------------------------------------------------------
^!a:: {
    global active, token, lastOut
    active := !active
    token := "", lastOut := ""
    ToolTip(active ? "Mode Arab: ON" : "Mode Arab: OFF")
    SetTimer(() => ToolTip(), -1000)
}

; --- Hotkey (hanya aktif saat mode Arab ON) ------------------------------
HotIf (*) => active

for ch in StrSplit("abcdefghijklmnopqrstuvwxyz") {
    Hotkey("$" ch, KeyHandler.Bind(ch))
    Hotkey("$+" ch, KeyHandler.Bind(StrUpper(ch)))
}
for ch in ["-", "=", "'"]
    Hotkey("$" ch, KeyHandler.Bind(ch))

; Tombol yang mereset kombinasi (tombolnya tetap diteruskan ke aplikasi)
for k in ["~Space", "~Enter", "~Tab", "~BackSpace", "~LButton",
          "~Left", "~Right", "~Up", "~Down"]
    Hotkey(k, (*) => ResetToken())

HotIf

; --- Fungsi -------------------------------------------------------------------
ResetToken() {
    global token, lastOut
    token := "", lastOut := ""
}

KeyHandler(ch, *) {
    global token, lastOut, m
    cand := token . ch
    if (token != "" && m.Has(cand)) {
        ; Kombinasi: hapus output sebelumnya, ganti dengan hasil kombinasi
        if (StrLen(lastOut) > 0)
            Send("{BackSpace " StrLen(lastOut) "}")
        lastOut := m[cand]
        token := cand
        SendText(lastOut)
    } else if m.Has(ch) {
        lastOut := m[ch]
        token := ch
        SendText(lastOut)
    } else {
        ; Tidak terpetakan (c, o, p, v, x, ' sendirian): ketik apa adanya
        SendText(ch)
        token := "", lastOut := ""
    }
}
