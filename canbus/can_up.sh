if [[ -e /dev/ttyACM0 ]]; then
  echo "Device at /dev/ttyACM0 found, bringing can1 online";
  slcand -o -c -s8 /dev/ttyACM0 can1;
  ifconfig can1 up;
  ifconfig can1 txqueuelen 1000;
else
  echo "No device found at /dev/ttyACM0 (maybe it was unplugged?)";
  exit 1;
fi
echo `ifconfig can1`
echo Done;
tail -f /dev/null; # runs forever, for some reason if the terminal closed, the interface would die
