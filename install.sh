#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Request sudo permissions for the required steps
echo -e "\n${YELLOW}This script requires sudo permissions to install qrify. You may be prompted for your password.${NC}"
sudo -v

# Step 1: Install Python dependencies
echo -e "\n${YELLOW}Installing Python dependencies...${NC}"
pip install -r requirements.txt
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}Python dependencies installed successfully.${NC}"
else
    echo -e "\n${RED}Failed to install Python dependencies. Please check the error messages above.${NC}"
    exit 1
fi

# Step 2: Copy qrify.py to /usr/local/bin/
echo -e "\n${YELLOW}Copying qrify.py to /usr/local/bin/qrify.py...${NC}"
sudo cp qrify.py /usr/local/bin/qrify.py
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}qrify.py copied successfully.${NC}"
else
    echo -e "\n${RED}Failed to copy qrify.py. Please check the error messages above.${NC}"
    exit 1
fi

# Step 3: Copy qrify.sh to /usr/local/bin/qrify (making it executable)
echo -e "\n${YELLOW}Copying qrify.sh to /usr/local/bin/qrify ...${NC}"
sudo cp qrify.sh /usr/local/bin/qrify
echo -e "\n${YELLOW}Making it executable...${NC}"
sudo chmod +x /usr/local/bin/qrify
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}qrify script copied and made executable successfully.${NC}"
else
    echo -e "\n${RED}Failed to copy and make qrify executable. Please check the error messages above.${NC}"
    exit 1
fi

# Installation complete
echo -e "\n${GREEN}Install complete! You can now use qrify from the command line.${NC}\n"

# Basic help text
qrify --help
echo -e "\n${YELLOW}Usage examples:${NC}"
echo -e "${YELLOW}  qrify --file <file> --output <output_base>${NC}"
echo -e "${YELLOW}  qrify --raw \"<data>\" --output <output_base>${NC}"
echo -e "${YELLOW}  echo \"<data>\" | qrify --stdin --output <output_base>${NC}"