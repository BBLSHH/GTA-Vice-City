#!/bin/bash

## This is an auto build script that can be used with the new RSPNVPK tool
## https://github.com/mrsteyk/RSPNVPK
## Add the VPK that your editing in a /dir folder
## eg. englishclient_frontend.bsp.pak000_dir.vpk

if [ "$1" = "prod" ]
then
  ## Run on Prod
  cp -R ./src ./englishclient_frontend.bsp.pak000_dir
  wait
  ./RSPNVPK ./englishclient_frontend.bsp.pak000_dir.vpk -s
  wait
  rm -rf ./englishclient_frontend.bsp.pak000_dir
  mkdir "Enhanced Menu"
  mv ./*.vpk ./"Enhanced Menu"/
  zip -r "Enhanced Menu Compiled VPK.zip" ./"Enhanced Menu"/
  rm -rf ./"Enhanced Menu"/
else
  ## Run on Dev
  cp ./dir/englishclient_frontend.bsp.pak000_dir.vpk ./ & cp -R ./src ./englishclient_frontend.bsp.pak000_dir
  wait
  RSPNVPK englishclient_frontend.bsp.pak000_dir.vpk -s
  wait
  rm -rf ./englishclient_frontend.bsp.pak000_dir
  # mv ./*.vpk "C:\Program Files (x86)\Origin Games\Titanfall2\vpk"
fi

## Northstar and Icepick Changes
mkdir ./Icepick
cp -R ./src/* ./Icepick && cp -R ./ice/* ./Icepick
rm ./Icepick/scripts/vscripts/scripts.rson
mkdir ./Northstar
cp -R ./src/ ./Northstar/mod && cp -R ./nstar/* ./Northstar
rm ./Northstar/mod/scripts/vscripts/scripts.rson

mv ./Icepick ./Enhanced.Menu.Mod.Icepick
mv ./Northstar ./Enhanced.Menu.Mod.Northstar

if [ "$1" = "prod" ]
then
  zip -r "Enhanced.Menu.Mod.Icepick.zip" ./"Enhanced.Menu.Mod.Icepick"/
  rm -rf ./"Enhanced.Menu.Mod.Icepick"/
  zip -r "Enhanced.Menu.Mod.Northstar.zip" ./"Enhanced.Menu.Mod.Northstar"/
  rm -rf ./"Enhanced.Menu.Mod.Northstar"/
fi
