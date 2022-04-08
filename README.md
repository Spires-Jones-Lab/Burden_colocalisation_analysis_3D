# Burden_colocalisation_analysis_3D

This script is designed to analyse the surface of a channel that colocalize with up to 3 other channels. Also reports the percent of image are occupied by the main channel.

## Scripts
-	The two needed scripts should be saved into the same folder (i.e **Scripts**).
-	Does not need to be the folder where the images are located.
-	Scripts required:
    - **Burden_colocalization_analysis_3D.m**
    -	**read_stackTiff.m**

## Inputs
-	The script can analyse multiple channels (the same case, different stains).
-	The input folder should contain segmented images (black and white).
-	Be sure that the name of the channel is not included in the case name (image_name).
-	The script can do colocalization between a "burden channel" and 1, 2 or 3 other channels.
-	“Burden channel” means that you want to calculate the percent of its area that colocalize with another channel.

## Run the script
-	Run **Burden_colocalization_analysis_3D.m** in Matlab.
-	It will ask the folder where the images are located.
-	In the menu that appears write the name of the channel that you want to test, the "burden channel". In case multiple channels would like to be tested as “burden channel”, will need to run the script for each. It is the best way found to not have hundreds of combinations. It should not be a problem as the script is fast and the “burden channel” name is saved in the output, so there is no overwriting.
-	In the other channels write the channel names you want to test the colocalization with the burden channel.
-	Leave empty the channels you don't need. Now the script can do colocalization between the "burden channel" and 1, 2 or 3 other channels. As more channels more combinations!
-	That’s all!

## Output
-	It creates a new folder into the input folder called **Results_burden** that contains an Excel file named: **burdenchannelnamechosen_percent_area.csv**.
-	It contains:
      -	Percent of the image occupied by the "burden channel".
      -	Percent of the "burden channel" that colocalize with the others and their combinations.


