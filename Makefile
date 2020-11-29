MCU=atmega328p

all:
	avr-gcc -g -Os -mmcu=${MCU} -c demo.c
	avr-gcc -g -mmcu=${MCU} -o demo.elf demo.o
	avr-gcc -g -mmcu=${MCU} -Wl,-Map,demo.map -o demo.elf demo.o
	avr-objcopy -j .text -j .data -O ihex demo.elf demo.hex
	avr-objcopy -j .eeprom --change-section-lma .eeprom=0 -O ihex demo.elf demo_eeprom.hex
	avrdude -v -p atmega328p -C avrdude.conf -c arduino -b 115200 -D -P "/dev/ttyUSB0" -U flash:w:demo.hex:i
