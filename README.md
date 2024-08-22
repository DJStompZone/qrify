# qrify

`qrify` is a command-line tool for generating QR codes from files, raw data, or piped input. It automatically handles large inputs by splitting them into multiple QR codes as needed. The tool is capable of encoding both text and binary data.

## Features

- Encode text or binary data into QR codes.
- Automatically split large data into multiple QR codes.
- Supports input from files, raw strings, and standard input (stdin).
- Simple command-line interface.

## Installation

To install `qrify`, clone the repository and run the `install.sh` script:

```bash
git clone https://github.com/djstompzone/qrify.git
cd qrify
chmod +x install.sh
./install.sh