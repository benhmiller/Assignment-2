DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS Bid;
DROP TABLE IF EXISTS Bidder;
DROP TABLE IF EXISTS Category;

CREATE TABLE Item (
    ItemID INTEGER PRIMARY KEY,
    SellerID INTEGER,
    Name TEXT NOT NULL,
    Category TEXT NOT NULL,
    First_Bid REAL NOT NULL,
    Currently REAL NOT NULL,
    Number_of_Bids INTEGER NOT NULL,
    Buy_Price REAL,
    Location TEXT NOT NULL,
    Country TEXT NOT NULL,
    Started DATETIME NOT NULL,
    Ends DATETIME NOT NULL,
    Description TEXT NOT NULL,
    FOREIGN KEY (SellerID) REFERENCES Seller(UserID)
        ON DELETE CASCADE
);

CREATE TABLE Seller (
    UserID TEXT PRIMARY KEY,
    Rating INTEGER NOT NULL
);

CREATE TABLE Bid (
    ItemID INTEGER,
    Time DATETIME NOT NULL,
    Amount REAL,
    BidderID INTEGER,
    PRIMARY KEY(ItemID, Amount),
    FOREIGN KEY (BidderID) REFERENCES Bidder(UserID)
        ON DELETE CASCADE
);

CREATE TABLE Bidder (
    UserID TEXT PRIMARY KEY,
    Rating INTEGER NOT NULL,
    Location TEXT,
    Country TEXT
);

CREATE TABLE Category (
    ItemID TEXT,
    Category Text,
    PRIMARY KEY(ItemID, Category)
);
