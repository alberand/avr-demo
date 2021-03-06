MCU=atmega328p

all:
	avr-gcc -g -O2 -mmcu=${MCU} -c demo.c
	avr-gcc -g -mmcu=${MCU} -o demo.elf demo.o
	avr-gcc -g -mmcu=${MCU} -Wl,-Map,demo.map -o demo.elf demo.o
	avr-objcopy -j .text -j .data -O ihex demo.elf demo.hex
	avr-objcopy -j .eeprom --change-section-lma .eeprom=0 -O ihex demo.elf demo_eeprom.hex
	avr-objdump -h -S demo.elf > demo.lst

upload: demo.hex
	avrdude -v -p atmega328p -C avrdude.conf -c arduino -b 115200 -D -P "/dev/ttyUSB0" -U flash:w:demo.hex:i

clean:
	rm -rf demo.hex demo.elf demo.lst demo.o demo.map demo_eeprom.hex
