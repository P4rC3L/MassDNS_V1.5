# MassDNS_V1.5

All the credit goes to [blechschmidt](https://github.com/blechschmidt/massdns) for the Original tool massdns - This tool is used to simplify all the installation process for it and make it so the Binary is available system-wide.-
<br><br>
The main goal here was quite personal as I wanted:- <br>
- To simplify the hectic tasks needed to install and utilize the tool on a daily basis. The tool is great, but the binary itself is accessible through a Virtual Environment.<br>
- I created a basic script that will take care of all that hassle for me --> You can also modify the switches on the original Subdominator inside the `massdns.sh` as per your requirement.<br>
- Just using this script without the Tool itself would be un-productive; So I added a installation script `installation.sh` that will build the foundation on your system as required. 

### How to Use?<br>
1. Download the `installation.sh` and give it the required permission: `sudo chmod +x installation.sh`.<br>
2. Execute it and All the required configuration would be done! 
3. Start using the script as required: `massdns.sh -L <File_Name.txt>`
