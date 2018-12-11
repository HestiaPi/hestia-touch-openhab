sudo apt-get update && apt-get upgrade;
sudo apt-get install build-essential python-pip python-dev python-smbus git;
mkdir /home/pi/git/;
cd /home/pi/git/;
git clone https://github.com/adafruit/Adafruit_Python_DHT.git;
cd Adafruit_Python_DHT;
sudo python setup.py install;
