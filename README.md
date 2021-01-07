# multiple_aromatic_paper_2021

Scripts related to the article "How coiled-coil assemblies accommodate multiple aromatic residues"

README

These scripts were written to run individual tasks related to extracting bioinformatic information about tyrosine interactions in coiled coils. A maximum of nine biological units for each structure were download from the Protein Data Bank using a modified bash script. All other scripts were written in Python using Ipython notebook. Structure manipulation makes use of the BioPython module. A directory containing pdb files of tyrosine residues is included so that the final data and plots can be reproduces without running all individual tasks (note the directory contains empty files for biological units that lack CC regions/Tyr residues).

The order of processing was as follows.

1. Comma/line seperated PDB ID code lists of coiled coils containing tyrosine at a, d, e and g positions were downloaded and concatenated. This was achieved by filtering the CC+ database http://coiledcoils.chm.bris.ac.uk/ccplus/search/dynamic_interface using the "Specify interface" tab. For example, to select all pdb files containing Tyr at a positions, "Tyr" residues at "a" position within "10" Angstroms of "any" residue at "any" position were selected.

2. SOCKET_downloads.ipynb was ran with the line separated files from step 1 to download all relevant SOCKET files.

3. SOCKET_extract-CCregions.ipynb was ran to create a python dictionary with PDB ID codes as keys and lists of coiled-coil chain and residue identifiers as values from the downloaded SOCKET text files in 2. The dictionary is outputted as a JSON file.

4. batch_download_biolunit.sh was ran nine times using the csv list from 1 to download all structure from the Protein Data Bank.

5. extract_CCregions.ipynb was ran on all pdb files from 4. The script outputs a new directory of pdb files containing only the CC regions.

6. extract_Tyr_residues.ipynb was ran on all CC-region pdb files from 5. The script outputs a new directory of pdb files containing Tyr residues found in CC regions.

7. Tyr_distance_measure_withplot.ipynb was ran to measure pairwise distances for all hydroxyl oxygen atoms and pairwise distance of centroid (averaged Cgama - Czeta position) of all tyrosine residues in PDB files from step 6 and returns a database of distances and produces histograms using the matplotlib module.


