#!/bin/bash
#Fatih ÖNDER https://github.com/cektor

# Renk kodları
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"


# Yedekleme ve geri yükleme fonksiyonları
backup() {
    # Klasörleri oluştur
    mkdir -p ~/config_yedek

    # Mevcut .config dizinini yedekle
    cp -r ~/.config ~/config_yedek/

    # Bilgilendirme dosyasını oluştur veya güncelle
    echo "Bu klasör içinde home/.config yedeği bulunmaktadır (gizli dosya olarak görünebilir. CTRL+H)" > ~/config_yedek/bilgilendirme.txt

    echo -e "${GREEN}Yedekleme tamamlandı.${RESET}"
}

restore() {
    # Geri yükleme işlemi
    if [ -d ~/config_yedek ]; then
        # .config dizinini geri yükle
        cp -r ~/config_yedek/.config ~/.config/
        # Tüm dosya ve klasörlere değiştirme izni ver
        chmod -R 777 ~/.config
        echo -e "${GREEN}Geri yükleme tamamlandı.${RESET}"
    else
        echo -e "${RED}config_yedek klasörü bulunamadı. Lütfen önce yedek alın.${RESET}"
    fi
}

delete_backup() {
    # Yedekleme klasörünü sil
    if [ -d ~/config_yedek ]; then
        rm -rf ~/config_yedek
        echo -e "${YELLOW}config_yedek klasörü ve içeriği silindi.${RESET}"
    else
        echo -e "${RED}config_yedek klasörü bulunamadı.${RESET}"
    fi
}

# Ana döngü
while true; do
    # Kullanıcıdan seçim al
    echo "home/.config Yedekleme ve Geri Yükleme Uygulaması"
    echo "1. Yedekle"
    echo "2. Geri Yükle"
    echo "3. Yedeklemeyi Sil"
    echo "4. Çıkış"
    read -p "Seçiminizi yapın (1/2/3/4): " secim
    echo "" # Boş bir satır ekleyerek görünümü iyileştir

    case $secim in
        1)
            backup
            ;;
        2)
            restore
            ;;
        3)
            delete_backup
            ;;
        4)
            echo -e "${YELLOW}Programdan çıkılıyor.${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}Geçersiz seçim. Lütfen 1, 2, 3 veya 4 girin.${RESET}"
            ;;
    esac

    echo "" # Boş bir satır ekleyerek görünümü iyileştir

done

