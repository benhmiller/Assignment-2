DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS Bid;
DROP TABLE IF EXISTS Bidder;

CREATE TABLE Item (
    ItemID INTEGER PRIMARY KEY,
    SellerID INTEGER,
    Name TEXT,
    Category TEXT,
    First_Bid REAL,
    Currently REAL,
    Number_of_Bids INTEGER,
    Buy_Price REAL,
    Location TEXT,
    Country TEXT,
    Started DATETIME,
    Ends DATETIME,
    Description TEXT,
    FOREIGN KEY (SellerID) REFERENCES Seller(UserID)
        ON DELETE CASCADE
);

CREATE TABLE Seller (
    UserID INTEGER PRIMARY KEY,
    Rating INTEGER
);

CREATE TABLE Bid (
    ItemID INTEGER,
    Time DATETIME,
    Amount REAL,
    BidderID INTEGER,
    PRIMARY KEY(ItemID, Amount),
    FOREIGN KEY (BidderID) REFERENCES Bidder(UserID)
        ON DELETE CASCADE
);

CREATE TABLE Bidder (
    UserID INTEGER PRIMARY KEY,
    Rating INTEGER,
    Location TEXT,
    Country TEXT
);
