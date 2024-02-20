python my_parser.py ebay_data/items-*.json

# Concatenate all Item.dat files into one file, then remove duplicates
cat items-*_Item.dat > Items.dat
sort Items.dat | uniq > Items.dat

# Concatenate all Seller.dat files into one file, then remove duplicates
cat items-*_Seller.dat > Sellers.dat
sort Sellers.dat | uniq > Sellers.dat

# Concatenate all Bid.dat files into one file, then remove duplicates
cat items-*_Bid.dat > Bids.dat
sort Bids.dat | uniq > Bids.dat

# Concatenate all Bidder.dat files into one file, then remove duplicates
cat items-*_Bidder.dat > Bidders.dat
sort Bidders.dat | uniq > Bidders.dat

# Clean directory of temporary .dat files (excludes those created above)
make clean