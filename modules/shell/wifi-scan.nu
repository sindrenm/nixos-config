# Lists nearby Wi-Fi networks/APs as a table, parsed from `nmcli`'s terse
# output. Useful for telling mesh APs with the same SSID apart by BSSID/signal.
def "wifi scan" [] {
  nmcli -t -f active,bssid,ssid,chan,rate,signal,security dev wifi list
  | lines
  | each { |line|
      $line
      | str replace --all "\\:" (char -u 1f)
      | split column ":" in-use bssid ssid chan rate signal security
      | update cells { str replace --all (char -u 1f) ":" }
    }
  | flatten
}
