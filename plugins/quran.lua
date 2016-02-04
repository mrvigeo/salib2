--shared by @BlackHatchannel
quran() {


  local NAMA_SURAT=( . Al-Fatihah Al-Baqarah Ali-Imran An-Nisaa\' Al-Maaidah \

  Al-An\'aam Al-A\'raaf Al-Anfaal At-Taubah Yunus Huud Yusuf Ar-Ra\'d Ibrahim \

  Al-Hijr An-Nahl Al-Israa\' Al-Kahfi Maryam Thaahaa Al-Anbiyaa\' Al-Hajj \

  Al-Mukminuun An-Nuur Al-Furqaan Ash-Shu\'araa An-Naml Al-Qashash Al-Ankabuut \

  Ar-Ruum Luqman As-Sajdah Al-Ahzaab Saba\' Faathir Yasiin As-Shaaffaat Shaad \

  Az-Zumar Al-Ghaafir Fushshilat Asy-Syuura Az-Zukhruf Ad-Dukhaan Al-Jaatsiyah \

  Al-Ahqaaf Muhammad Al-Fath Al-Hujuraat Qaaf Adz-Dzaariyat Ath-Thur An-Najm \

  Al-Qamar Ar-Rahmaan Al-Waaqi\'ah Al-Hadiid Al-Mujaadilah Al-Hasyr \

  Al-Mumtahanah Ash-Shaff Al-Jumu\'ah Al-Munaafiquun At-Taghaabuun Ath-Thaalaq \

  At-Tahrim Al-Mulk Al-Qalam Al-Haaqqah Al-Ma\'aarij Nuuh Al-Jin Al-Muzzammil \

  Al-Muddatstsir Al-Qiyaamah Al-Insaan Al-Mursalaat An-Naba\' \

  An-Naazi\'aat \'Abasa At-Takwir Al-Infithaar Al-Mutaffifin Al-Insyiqaaq \

  Al-Buruuj Ath-Thaariq Al-A\'laa Al-Ghaashiyah Al-Fajr Al-Balad Asy-Syams \

  Al-Lail Ad-Dhuhaa "Alam Nasyrah" At-Tiin Al-\'Alaq Al-Qadr Al-Bayyinah \

  Al-Zalzalah Al-\'Aadiyaat Al-Qaari\'ah At-Takaatsur Al-\'Ashr Al-Humazah \

  Al-Fiil Quraisy Al-Maa\'uun Al-Kautsar Al-Kaafiruun An-Nashr Al-Lahab \

  Al-Ikhlaas Al-Falaq An-Naas )


  local GALAT="$(quran_help)"


  if [[ ${MESSAGE:5} = ** ]]; then


    local QUERY="${MESSAGE:6}"

    local QUERY="${QUERY//[-+=.,]}"

    local QUERY=( $QUERY )


    if (( ${#QUERY[@]} == 2 )); then

      local SURAT="${QUERY[0]}|${QUERY[1]}|"


      local AYAT="$(while read -r line; \

      do [[ $line =~ ^"${SURAT}" ]] && printf "%s\n" "${line##*|}"; \

      done < ./libs/quran)"


      if [[ -n $AYAT ]]; then


        MSG="$(printf "%s\n" "${AYAT}" "" \

        "(Q.S ${NAMA_SURAT[${QUERY[0]}]}:${QUERY[1]})")"


      else

        MSG="$(printf "%s\n" \

        "Maaf, tidak dapat menemukan surat yang diminta." \

        "Pastikan penulisan adalah benar." "" \

        "Contoh: quran 114 6")"

      fi

    else

      MSG="$(quran_help)"

    fi

  else

    MSG="$(quran_help)"

  fi


  send_chat_action=typing

  disable_web_page_preview=true

  send_message


}


quran_help() {


printf "%s\n" '

quran <nomor surat> <ayat>

Al Quran dan terjemah bahasa Indonesia dari tanzil.net.

Contoh: quran 114 6

'


}

