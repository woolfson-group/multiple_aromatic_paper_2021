#!/bin/bash

# Script to download files from RCSB http file download services.
# Use the -h switch to get help on usage.

if ! command -v curl &> /dev/null
then
    echo "'curl' could not be found. You need to install 'curl' for this script to work."
    exit 1
fi

PROGNAME=$0
BASE_URL="https://files.rcsb.org/download"

usage() {
  cat << EOF >&2
Usage: $PROGNAME -f <file> [-o <dir>] [-c] [-p]

 -f <file>: the input file containing a comma-separated list of PDB ids
 -o  <dir>: the output dir, default: current dir
 -c       : download a cif.gz file for each PDB id
 -p       : download a pdb.gz file for each PDB id
 -x       : download a xml.gz file for each PDB id
 -s       : download a sf.cif.gz file for each PDB id (diffraction only)
 -m       : download a mr.gz file for each PDB id (NMR only)
 -r       : download a mr.str.gz for each PDB id (NMR only)
 -1	  : download a pdb1.gz for each PDB id
 -2      : download a pdb2.gz for each PDB id
 -3      : download a pdb3.gz for each PDB id
 -4      : download a pdb4.gz for each PDB id
 -5      : download a pdb4.gz for each PDB id
 -6      : download a pdb4.gz for each PDB id
 -7      : download a pdb4.gz for each PDB id
 -8      : download a pdb4.gz for each PDB id
EOF
  exit 1
}

download() {
  url="$BASE_URL/$1"
  out=$2/$1
  echo "Downloading $url to $out"
  curl -s -f $url -o $out || echo "Failed to download $url"
}

listfile=""
outdir="."
cif=false
pdb=false
xml=false
sf=false
mr=false
mrstr=false
pdb1=false
pdb2=false
pdb3=false
pdb4=false
pdb5=false
pdb6=false
pdb7=false
pdb8=false
while getopts f:o:cpxsmr12345678 o
do
  case $o in
    (f) listfile=$OPTARG;;
    (o) outdir=$OPTARG;;
    (c) cif=true;;
    (p) pdb=true;;
    (x) xml=true;;
    (s) sf=true;;
    (m) mr=true;;
    (r) mrstr=true;;
    (1) pdb1=true;;
    (2) pdb2=true;;
    (3) pdb3=true;;
    (4) pdb4=true;;   
    (5) pdb5=true;;   
    (6) pdb6=true;;   
    (7) pdb7=true;;   
    (8) pdb8=true;;   
    (*) usage
  esac
done
shift "$((OPTIND - 1))"

if [ "$listfile" == "" ]
then
  echo "Parameter -f must be provided"
  exit 1
fi
contents=$(cat $listfile)

# see https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash#tab-top
IFS=',' read -ra tokens <<< "$contents"

for token in "${tokens[@]}"
do
  if [ "$cif" == true ]
  then
    download ${token}.cif.gz $outdir
  fi
  if [ "$pdb" == true ]
  then
    download ${token}.pdb.gz $outdir
  fi
  if [ "$xml" == true ]
  then
    download ${token}.xml.gz $outdir
  fi
  if [ "$sf" == true ]
  then
    download ${token}-sf.cif.gz $outdir
  fi
  if [ "$mr" == true ]
  then
    download ${token}.mr.gz $outdir
  fi
  if [ "$mrstr" == true ]
  then
    download ${token}_mr.str.gz $outdir
  fi
  if [ "$pdb1" == true ]
  then
    download ${token}.pdb1.gz $outdir
  fi
  if [ "$pdb2" == true ]
  then
    download ${token}.pdb2.gz $outdir
  fi
  if [ "$pdb3" == true ]
  then
    download ${token}.pdb3.gz $outdir
  fi
  if [ "$pdb4" == true ]
  then
    download ${token}.pdb4.gz $outdir
  fi
  if [ "$pdb5" == true ]
  then
    download ${token}.pdb5.gz $outdir
  fi 
  if [ "$pdb6" == true ]
  then
    download ${token}.pdb6.gz $outdir
  fi 
  if [ "$pdb7" == true ]
  then
    download ${token}.pdb7.gz $outdir
  fi
  if [ "$pdb8" == true ]
  then
    download ${token}.pdb8.gz $outdir
  fi

done
