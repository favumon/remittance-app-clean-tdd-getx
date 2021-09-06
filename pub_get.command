#chmod u+x ./pub_get.command

cd core 

flutter clean

flutter pub get

cd -

cd domain 

flutter clean

flutter pub get

cd -

cd data

flutter clean

flutter pub get

cd - 

flutter clean

flutter pub get

