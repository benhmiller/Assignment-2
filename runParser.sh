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

# Concatenate all Category.dat files into one file, then remove duplicates
cat items-*_Category.dat > Categories.dat
sort Categories.dat | uniq > Categories_Temp.dat
mv Categories_Temp.dat Categories.dat

# Create Database
sqlite3 AuctionBase.db < create.sql

# Populate Database
sqlite3 AuctionBase.db < load.txt

# Clean directory of .dat files
rm *.dat
#rm items-*_Item.dat
#rm items-*_Seller.dat
#rm items-*_Bid.dat
#rm items-*_Bidder.dat
#rm items-*_Category.dat

# Run SQL Query Files
sqlite3 AuctionBase.db < query1.sql
sqlite3 AuctionBase.db < query2.sql
sqlite3 AuctionBase.db < query3.sql
sqlite3 AuctionBase.db < query4.sql
sqlite3 AuctionBase.db < query5.sql
sqlite3 AuctionBase.db < query6.sql
sqlite3 AuctionBase.db < query7.sql