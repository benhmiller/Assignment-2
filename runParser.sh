python my_parser.py ebay_data/items-*.json

# Concatenate all Item.dat files into one file, then remove duplicates
cat items-*_Item.dat > Items.dat
sort Items.dat | uniq > Items_Temp.dat
mv Items_Temp.dat Items.dat

# Concatenate all Seller.dat files into one file, then remove duplicates
cat items-*_Seller.dat > Sellers.dat
sort Sellers.dat | uniq > Sellers_Temp.dat
mv Sellers_Temp.dat Sellers.dat

# Concatenate all Bid.dat files into one file, then remove duplicates
cat items-*_Bid.dat > Bids.dat
sort Bids.dat | uniq > Bids_Temp.dat
mv Bids_Temp.dat Bids.dat

# Concatenate all Bidder.dat files into one file, then remove duplicates
cat items-*_Bidder.dat > Bidders.dat
sort Bidders.dat | uniq > Bidders_Temp.dat
mv Bidders_Temp.dat Bidders.dat

# Clean directory of temporary .dat files (excludes those created above)
make clean