#!/bin/bash

# Resmin indirileceği klasörü belirtin
download_folder="$(echo $HOME)"

# https://matematikdelisi.com/yks/sayac/images/tyt/tyt-sinavina-geri-sayim-kalan-gun-161.jpg
# Sayfanın HTML içeriğini çekin


# Hedef tarih
target_date="2025-06-21 10:15"
# Yıl-Ay-Gün Saat:Dakika şeklinde


# Hedef tarihi saniyeye çevirin
target_epoch=$(date -d "$target_date" +"%s")

# Şu anki tarihi saniyeye çevirin
current_epoch=$(date +"%s")

# Kalan süreyi hesaplayın
remaining_seconds=$((target_epoch - current_epoch))
remaining_days=$((remaining_seconds / 86400))  # 1 gün = 86400 saniye

if [ $remaining_days -lt 0 ]; then
    printf " Hata: Belirlenen sınav tarihi çoktan geçmiş.\n Lütfen sonraki yks zamanını bu betik için düzenleyin veya geliştirici ile iletişime geçin.\n https://github.com/Metincloup/YKS-Timer-Walpaper/issues adresinde issue açabilirsiniz.\n"
exit 1
fi


curl -o "$download_folder/image.jpg" "https://matematikdelisi.com/yks/sayac/images/tyt/tyt-sinavina-geri-sayim-kalan-gun-$remaining_days.jpg"

if [ $(echo $DESKTOP_SESSION) = 'xfce' ]; then
# xfce için duvar kağıdını ayarlayın
	xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image") -s "$download_folder/image.jpg"
else
# Nitrogen ile duvar kağıdını ayarlayın
nitrogen --set-centered "$download_folder/image.jpg"
fi

