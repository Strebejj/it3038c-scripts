These are scrpits that output the image format, size, and mode.

To run this script you first need to install Pillow.
To do this firt open a virtualenv session in the directory with the image python script and image you would like to know the format, size and mode of.
In a PowerShell Temrinal run: virtualenv ~venv/webscraping
Then run: .\~/venv/webscraping/Scripts/activate.ps1
Then install Pillow: pip install Pillow
Then run the scripts: 
python format.py
python size.py
python mode.py