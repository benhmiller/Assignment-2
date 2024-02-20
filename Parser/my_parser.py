
"""
FILE: my_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Modified: 04/21/2014

Skeleton parser for CS564 programming project 1. Has useful imports and
functions for parsing, including:

1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.

Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!
"""

import sys
from json import loads
from re import sub

columnSeparator = "|"

# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
"""
def transformDttm(dttm):
    dttm = sub(r'"', '', dttm)
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

"""
Recursively traverse an object to: escape quotations of string object and cast to int
"""
def format_value(val):
    if isinstance(val, str):
        if val.isdigit():
            return int(val) # Convert to int if it's a numeric string (will not incorrectly cast dollar amounts such vals are strings)
        else:
            return '"' + sub(r'"', '""', val) + '"'
    elif isinstance(val, list):
        # If val is a list, apply the format_value function to each element
        return [format_value(item) for item in val]
    elif isinstance(val, dict):
        # If val is a dictionary, apply the format_value function to each value
        return {key: format_value(value) for key, value in val.items()}
    else:
        return val

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):

    schema = {"Items": [], "Sellers": [], "Bids": [], "Bidders": []}

    with open(json_file, 'r') as f:
        ## Open file for writing
        if(json_file.count('/') > 0):
            filename = json_file[json_file.rindex('/')+1:-5]
        else:
            filename = json_file[:5]


        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file

        for item in items:
            # Format strings to escaped quotation format
            item['Category'] = ", ".join(item['Category'])
            print(item['Category'])
            item = format_value(item)
            print(item['Category'])
            ## This employs the schema of Item.
            
            currentItem = {
                "ItemID": item['ItemID'], 
                "SellerID": item['Seller']['UserID'], 
                "Name": item['Name'], 
                "Category": item['Category'], 
                "First_Bid": transformDollar(item['First_Bid']), 
                "Currently": transformDollar(item['Currently']), 
                "Number_of_Bids": item['Number_of_Bids'], 
                "Buy_Price": None, "Location": item['Location'], 
                "Country": item['Country'], 
                "Started": transformDttm(item['Started']), 
                "Ends": transformDttm(item['Ends']), 
                "Description": item['Description']
            }
            if "Buy_Price" in item:
                currentItem['Buy_Price'] = transformDollar(item['Buy_Price'])

            ## This employs the schema of Seller.
            currentSeller = {"UserID": item['Seller']['UserID'], "Rating": item['Seller']['Rating']}

            if (schema['Items'].count(currentItem) == 0):
                schema['Items'].append(currentItem)
            if (schema['Sellers'].count(currentSeller) == 0):
                schema['Sellers'].append(currentSeller)


            if(item['Bids'] != None):
                for bid in item['Bids']:
                    ## This employs the schema of Bid.
                    currentBid = {"ItemID": item['ItemID'], "Time": transformDttm(bid['Bid']['Time']), "Amount": transformDollar(bid['Bid']['Amount']), "BidderID": bid['Bid']['Bidder']['UserID']}
                    ## This employs the schema of Bidder.
                    currentBidder = {"UserID": bid['Bid']['Bidder']['UserID'], "Rating": bid['Bid']['Bidder']['Rating'], "Location": None, "Country": None}
                    if "Location" in bid['Bid']['Bidder']:
                        bid['Bid']['Bidder']['Location']
                    if "Country" in bid['Bid']['Bidder']:
                        bid['Bid']['Bidder']['Country']


                    if (schema['Bids'].count(currentBid) == 0):
                        schema['Bids'].append(currentBid)
                    if (schema['Bidders'].count(currentBidder) == 0):
                        schema['Bidders'].append(currentBidder)

            continue

        Item_output = open(filename + "_Item.dat", "w")
        Seller_output = open(filename + "_Seller.dat", "w")
        Bid_output = open(filename + "_Bid.dat", "w")
        Bidder_output = open(filename + "_Bidder.dat", "w")
        outputs = [Item_output, Seller_output, Bid_output, Bidder_output]
        printSchema(schema, outputs)

    return

def printSchema(schema, outputs):

    # outputs[0] corresponds to _Item.dat
    for item in schema['Items']:
        outputs[0].write(str(item['ItemID']) + columnSeparator)
        outputs[0].write(str(item['SellerID']) + columnSeparator)
        outputs[0].write(str(item['Name']) + columnSeparator)
        #for category in item['Category']:
        #    if(item['Category'].index(category) == len(item['Category'])-1):
        #        outputs[0].write(str(category) + columnSeparator)
        #        continue
        #    outputs[0].write(str(category) + ", ")
        outputs[0].write(str(item['Category']) + columnSeparator)
        outputs[0].write(str(item['First_Bid']) + columnSeparator)
        outputs[0].write(str(item['Currently']) + columnSeparator)
        outputs[0].write(str(item['Number_of_Bids']) + columnSeparator)
        outputs[0].write(str(item['Buy_Price']) + columnSeparator)
        outputs[0].write(str(item['Location']) + columnSeparator)
        outputs[0].write(str(item['Country']) + columnSeparator)
        outputs[0].write(str(item['Started']) + columnSeparator)
        outputs[0].write(str(item['Ends']) + columnSeparator)
        outputs[0].write(str(item['Description']) + "\n")

    # outputs[1] corresponds to _Seller.dat
    for seller in schema['Sellers']:
        outputs[1].write(str(seller['UserID']) + columnSeparator)
        outputs[1].write(str(seller['Rating']) + "\n")

    # outputs[2] corresponds to _Bid.dat
    for bid in schema['Bids']:
        outputs[2].write(str(bid['ItemID']) + columnSeparator)
        outputs[2].write(str(bid['Time']) + columnSeparator)
        outputs[2].write(str(bid['Amount']) + columnSeparator)
        outputs[2].write(str(bid['BidderID']) + "\n")

    #outputs[3] corresponds to _Bidder.dat
    for bidder in schema['Bidders']:
        outputs[3].write(str(bidder['UserID']) + columnSeparator)
        outputs[3].write(str(bidder['Rating']) + columnSeparator)
        outputs[3].write(str(bidder['Location']) + columnSeparator)
        outputs[3].write(str(bidder['Country']) + "\n")

    return


""""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def main(argv):
    if len(argv) < 2:
        print ('Usage: python skeleton_json_parser.py <path to json files>', file=sys.stderr)
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print ("Success parsing ", f)

if __name__ == '__main__':
    main(sys.argv)
