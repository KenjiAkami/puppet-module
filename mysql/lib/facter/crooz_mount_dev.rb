Facter.add("crooz_mount_dev") do
      setcode do
              Facter::Util::Resolution.exec('/bin/df | /bin/grep /crooz | /bin/awk \'{print $1}\'')
      end
end
