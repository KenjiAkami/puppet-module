class hp-health {
   if $manufacturer =~ /HP/ {
    package { 'hp-health': }
    package { 'hpacucli': }
   }
}
