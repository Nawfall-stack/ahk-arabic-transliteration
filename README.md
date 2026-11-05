# AHK Arabic Transliteration Keyboard

Script [AutoHotkey v2](https://www.autohotkey.com/) untuk mengetik huruf Arab
di Windows memakai huruf Latin (transliterasi fonetis), dengan skema yang
mengikuti keyboard transliterasi di [Lexilogos](https://www.lexilogos.com/keyboard/arabic.htm).
Bisa dipakai di aplikasi apa pun: Word, browser, editor teks, chat, dan lainnya.

> *English:* an AutoHotkey v2 script that lets you type Arabic on Windows using
> Latin letters, following the Lexilogos transliteration scheme. Toggle with
> `Ctrl+Alt+A`. See the mapping tables below.

Proyek ini tidak berafiliasi dengan Lexilogos.

## Fitur

- Toggle mode Arab dengan `Ctrl+Alt+A`, jadi mengetik Latin biasa tidak terganggu
- Huruf dasar, huruf emphatic (huruf besar), dan varian dengan apostrof
- Semua bentuk hamzah, alif maqshurah, ta marbuthah
- Harakat: fathah, kasrah, dhammah, tanwin, syaddah, sukun
- Satu file, tanpa dependensi lain

## Instalasi

1. Pasang [AutoHotkey v2](https://www.autohotkey.com/) (bukan v1).
2. Unduh `arabic-transliteration.ahk` dari repo ini.
3. Klik dua kali file tersebut. Ikon AutoHotkey (huruf H hijau) muncul di system tray.
4. Tekan `Ctrl+Alt+A` untuk mengaktifkan mode Arab, tekan lagi untuk mematikan.

### Jalan otomatis saat Windows menyala

1. Tekan `Win + R`, ketik `shell:startup`, lalu Enter.
2. Taruh pintasan (shortcut) ke `arabic-transliteration.ahk` di folder itu.

Kalau script harus bekerja di aplikasi yang berjalan sebagai administrator,
jalankan lewat **Task Scheduler** dengan opsi *Run with highest privileges*.

Opsi lain: kompilasi menjadi `.exe` lewat *AutoHotkey Dash → Compile*.

## Cara pakai

- **Huruf emphatic** memakai huruf besar: `H` `S` `D` `T` `Z`
- **Varian** memakai apostrof setelah hurufnya: `t'` `H'` `d'` `s'` `g'`
- **Harakat** diketik setelah hurufnya, diawali `=` (lihat tabel di bawah)

### Huruf

| Ketik | Huruf | Ketik | Huruf | Ketik | Huruf |
|:-:|:-:|:-:|:-:|:-:|:-:|
| `a` | ا | `d'` | ذ | `S` | ص |
| `b` | ب | `r` | ر | `D` | ض |
| `t` | ت | `z` | ز | `T` | ط |
| `t'` | ث | `s` | س | `Z` | ظ |
| `j` | ج | `s'` | ش | `g` | ع |
| `H` | ح | `f` | ف | `g'` | غ |
| `H'` | خ | `q` | ق | `k` | ك |
| `d` | د | `l` | ل | `m` | م |
| `n` | ن | `h` | ه | `w` / `u` | و |
| `y` / `i` / `e` | ي | `Y` | ى | `h'` | ة |

Alias tambahan (bukan bagian dari tabel Lexilogos): `S'` = ض dan `T'` = ظ.

### Hamzah

| Ketik | Hasil | Ketik | Hasil |
|:-:|:-:|:-:|:-:|
| `-` | ء | `y--` | ئ |
| `-a` | أ | `w--` | ؤ |
| `a--` | إ | `--a` | ءا |
| `aa` | آ | `la` | لا |

Pada `y--` dan `w--`, huruf `i`/`e` dan `u` juga bisa dipakai (`i--`, `e--`, `u--`).

### Harakat

| Ketik | Hasil | Nama |
|:-:|:-:|---|
| `=a` | ـَ | fathah |
| `=i` | ـِ | kasrah |
| `=u` | ـُ | dhammah |
| `==a` | ـً | tanwin fathah |
| `==i` | ـٍ | tanwin kasrah |
| `==u` | ـٌ | tanwin dhammah |
| `=w` | ـّ | syaddah |
| `=o` | ـْ | sukun |

### Contoh

| Ketik | Hasil |
|---|---|
| `salam` | سلام |
| `ktab` | كتاب |
| `s'kran` | شكران |
| `g'yr` | غير |
| `yawm` | يوم |
| `rsul` | رسول |
| `k=at=ab=a` | كَتَبَ |
| `b=w` | بّ |
| `b==u` | بٌ |

## Cara kerja singkat

Script memantau tombol huruf saat mode Arab aktif. Setiap tombol langsung
mengirim satu huruf Arab. Jika tombol berikutnya membentuk kombinasi yang
dikenal (misalnya `s` lalu `'`), script menghapus huruf sebelumnya dan
menggantinya dengan hasil kombinasi (س menjadi ش). Spasi, Enter, Tab,
BackSpace, panah, dan klik mouse mereset kombinasi.

## Kustomisasi

Semua pemetaan ada di tabel `m` pada bagian atas script. Tambah atau ubah
baris dengan format `"tombol","huruf"`. Untuk mode Arab langsung aktif saat
script jalan, ubah `active := false` menjadi `active := true`.

## Keterbatasan

- Saat mode Arab aktif, tanda hubung `-` dan `=` dipakai untuk hamzah dan harakat.
  Matikan mode dulu (`Ctrl+Alt+A`) untuk mengetik tanda tersebut.
- Huruf `c`, `o`, `p`, `v`, `x` tidak dipetakan dan diketik apa adanya.
- Karena pergantian huruf memakai BackSpace, beberapa aplikasi dengan autocomplete
  atau editor khusus bisa menampilkan kedipan sesaat.
- Aplikasi yang berjalan sebagai administrator butuh script yang juga dijalankan
  sebagai administrator.
- Tanda baca Arab (`؟ ، ؛`) dan angka Arab-Indic belum tersedia.

## Pemecahan masalah

| Masalah | Solusi |
|---|---|
| Tidak terjadi apa-apa saat klik dua kali | Pastikan AutoHotkey **v2** terpasang, bukan v1 |
| Muncul error `#Requires` | Versi AutoHotkey terlalu lama, pasang v2.0+ |
| Tidak jalan di aplikasi tertentu | Coba jalankan script sebagai administrator |
| Huruf Latin tetap muncul | Cek tooltip `Mode Arab: ON` setelah `Ctrl+Alt+A` |

## Kontribusi

Lihat [CONTRIBUTING.md](CONTRIBUTING.md). Riwayat versi ada di [CHANGELOG.md](CHANGELOG.md).

## Lisensi

[MIT](LICENSE)
