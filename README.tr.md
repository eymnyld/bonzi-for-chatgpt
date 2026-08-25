# ChatGPT için Bonzi (Codex)

[English README](README.md)

<p align="center">
  <img src="docs/assets/ai-generated-label-black.svg" alt="Yapay zekâ ile üretildi" width="240">
</p>

<p align="center"><strong>🍌 Mor masaüstü gorili, muz enerjisiyle geri döndü.</strong></p>

Bonzi’nin neşeli mor goril görünümünden ve meşhur muzundan esinlenen, Codex masaüstü uygulaması için hazırlanmış resmî olmayan ve hayran yapımı animasyonlu pet paketidir. Codex marketplace plugin’i, prompt ile çalışan kurulum becerisi, macOS/Linux ve Windows kurucuları ve doğrulanmış v2 pet dosyalarını içerir.

> Bu paket **Codex masaüstü peti** kurar. Normal ChatGPT web arayüzüne Bonzi eklemez.

![Bonzi animasyon temas sayfası](plugins/bonzi-for-chatgpt/assets/qa/contact-sheet.png)

## İçerik

- Küçük masaüstü pet hücrelerinde okunaklı, muz seven mor goril tasarımı
- 8×11 Codex v2 atlası (`1536×2288`, saydam WebP)
- 9 standart animasyon durumu
- Saat yönünde 16 bakış yönü
- `spriteVersionNumber: 2` pet manifesti
- SHA-256 doğrulamalı kurucular
- Codex marketplace manifesti ve kurulum becerisi

Haricî connector plugin, API anahtarı veya hesap bağlantısı gerekmez.

## Codex uygulamasında tek promptla kurulum (komut satırı yok)

Yeni bir Codex görevi açıp aşağıdaki promptu aynen yapıştır. Kullanıcı terminal açmaz veya komut yazmaz; indirme, doğrulama ve yerel kurulum işlemlerini Codex kendi araçlarıyla yapar. Yalnızca ağ ve pet klasörüne yazma için Codex'in standart izin pencerelerini onaylaman gerekebilir.

```text
Codex masaüstü uygulamasına Bonzi petini kur. İşlemin tamamını kendi yerel dosya ve terminal araçlarınla yap; benden Terminal uygulamasını açmamı veya herhangi bir komutu elle çalıştırmamı isteme.

Kaynak, GitHub'daki sabit v1.0.0 sürümüdür. Yalnızca şu iki dosyayı indir:

1. pet.json
https://raw.githubusercontent.com/eymndev/bonzi-for-chatgpt/v1.0.0/plugins/bonzi-for-chatgpt/assets/pet/bonzi/pet.json

2. spritesheet.webp
https://raw.githubusercontent.com/eymndev/bonzi-for-chatgpt/v1.0.0/plugins/bonzi-for-chatgpt/assets/pet/bonzi/spritesheet.webp

Beklenen SHA-256 değerleri:
- pet.json: 5aab8bddc9e0cd01042b6667843abe1a38bb049b94c9e1bbc081bc57bd5e9a0b
- spritesheet.webp: 6171db4dffa833c4ed6d1cde4828753f92a4209498431502b0860fc5dfbcc145

Dosyaları önce yeni bir geçici klasöre indir. Ağ veya dosya sistemi izni gerekirse normal Codex izin isteğini göster ve izin verildikten sonra devam et. Her iki SHA-256 değeri birebir eşleşmezse hiçbir şeyi kurma veya değiştirme; hatayı bildir. pet.json dosyasını ayrıştırıp id değerinin "bonzi", spriteVersionNumber değerinin 2 ve spritesheetPath değerinin "spritesheet.webp" olduğunu doğrula.

Kurulum hedefi, CODEX_HOME tanımlıysa onun altındaki pets/bonzi klasörü; tanımlı değilse macOS/Linux için $HOME/.codex/pets/bonzi, Windows için kullanıcı profilindeki .codex\pets\bonzi klasörüdür. Hedefte aynı hashli iki dosya zaten varsa değişiklik yapma ve kurulumun hazır olduğunu bildir. Farklı pet.json veya spritesheet.webp varsa yalnızca bu mevcut iki dosyayı pets klasörü altında zaman damgalı bonzi-backup-* klasörüne kopyala; başka petleri, beklenmeyen dosyaları veya Codex ayarlarını silme/değiştirme. Bu prompt, söz konusu iki Bonzi dosyasını yedekleyip doğrulanmış sürümle değiştirmene açıkça izin verir.

Doğrulanmış dosyaları hedefe kur, kurulum sonrasında iki dosyanın SHA-256 değerlerini tekrar kontrol et ve tam hedef yolu, yedek oluşturulup oluşturulmadığını ve doğrulama sonucunu bildir. Son olarak pet görünmüyorsa Codex masaüstü uygulamasını yeniden başlatmam gerektiğini söyle.
```

Aynı prompt ayrı dosya olarak da bulunur: [INSTALL-PROMPT-TR.txt](INSTALL-PROMPT-TR.txt). İngilizce sürüm: [INSTALL-PROMPT-EN.txt](INSTALL-PROMPT-EN.txt).

## Alternatif: Codex plugin olarak kurulum

```bash
codex plugin marketplace add eymndev/bonzi-for-chatgpt
codex plugin add bonzi-for-chatgpt@bonzi-for-chatgpt
```

Yeni bir Codex görevi aç ve şu promptu yapıştır:

```text
Use $install-bonzi-pet to install the bundled Bonzi pet into Codex and verify it. If a different Bonzi pet would be overwritten, ask me first.
```

Pet hemen görünmezse Codex masaüstü uygulamasını yeniden başlat.

## Doğrudan kurulum

macOS/Linux:

```bash
git clone https://github.com/eymndev/bonzi-for-chatgpt.git
cd bonzi-for-chatgpt
./install.sh
```

Windows PowerShell:

```powershell
git clone https://github.com/eymndev/bonzi-for-chatgpt.git
Set-Location bonzi-for-chatgpt
./install.ps1
```

Kurucu yalnızca `${CODEX_HOME:-$HOME/.codex}/pets/bonzi` klasörüne yazar. Farklı bir Bonzi paketi `--force` veya `-Force` açıkça verilmeden değiştirilmez.

## Güncelleme

```bash
codex plugin marketplace upgrade bonzi-for-chatgpt
codex plugin add bonzi-for-chatgpt@bonzi-for-chatgpt
```

Yeni bir Codex görevi açıp kurulum promptunu tekrar çalıştır.

## Kaldırma

```bash
./uninstall.sh --yes
```

Windows:

```powershell
./uninstall.ps1 -Yes
```

## Doğrulama

```bash
python3 scripts/validate_repo.py
```

Repo doğrulayıcısı plugin/marketplace yapısını, manifest değerlerini, hashleri ve WebP boyutlarını kontrol eder.

## Yön QA

![Bonzi bakış yönleri](plugins/bonzi-for-chatgpt/assets/qa/look-directions.png)

Muz, Bonzi’nin görsel esin kaynaklarından biridir; animasyon atlası ise her hareketin ve bakış yönünün pet boyutunda net kalması için temiz, okunaklı goril siluetine odaklanır.

## Lisans ve marka notu

Kod ve özgün dokümantasyon MIT lisanslıdır. Bonzi karakteri, adı, referans görselleri ve türetilmiş sprite çizimi MIT kapsamına dahil değildir. Proje Bonzi Software, OpenAI veya ChatGPT ile bağlantılı ya da onlar tarafından onaylanmış değildir. Ayrıntılar: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
