# Tang Nano ASCII to Morse code encoder

Translates an ASCII input from a UART interface to Morse code. Symbols recieved by UART RX module
is sent to a buffer and is then converted to binary representation which is read and output using 
the Tang nano's onboard LEDs.
After the symbol has been output in Morse it is then sent via UART TX 
to the host. The UART is currently configured to use a 9600 Baud rate with 1 stop bit and no parity.

Refer to [UART setup for Tang Nano](https://github.com/trabucayre/openFPGALoader)) as the onboard 
CH552T microcontroller needs to be re-flashed for UART to work.

## Synthesis

Can be synthesized using the Gowin IDE, by opening the ASCIItoMorse.gprj file or manually importing
the .v module files to an existing project.
For the UART to work the `Done` and `RECONFIG_N` pins must be configured as dual-purpose, this can 
be done in Gowin IDE under `Project` / `Configuration` / `Place & Route` / `General` / `Dual-Purpose Pin`.
Once synthesized and routed it can be flashed using the Gowin programmer.
Using yowasp to synthesise and OpenFPGAloader to flash may work also but I am unsure on how to set 
dual-purpose pins using those.

## Usage

Once flashed the Tang Nano can be interfaced with by using serial console such as PuTTY or the terminal 
or any UART module.
Symbols recieved will be transmitted back to host device after the morse sequence for 
that symbol has finished.
The UART RX buffer can hold 1024 bytes so up to 1024 symbols can be sent before the buffer starts to 
overwrite itself.
The board can be reset at anytime by pressing the A button.


## Resources

- [UART setup for Tang Nano](https://qiita.com/ciniml/items/05ac7fd2515ceed3f88d)
- [Another Wishbone Controlled UART](https://github.com/ZipCPU/wbuart32) - UART modules used in this project
