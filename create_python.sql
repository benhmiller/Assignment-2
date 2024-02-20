{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "13d20f0f",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The sql extension is already loaded. To reload it, use:\n",
      "  %reload_ext sql\n",
      " * sqlite://\n",
      "Done.\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "[]"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "%load_ext sql\n",
    "%sql sqlite://\n",
    "%sql PRAGMA foreign_keys = ON"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "f5e37a8a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " * sqlite://\n",
      "Done.\n",
      "Done.\n",
      "Done.\n",
      "Done.\n",
      "Done.\n",
      "Done.\n",
      "Done.\n",
      "Done.\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "[]"
      ]
     },
     "execution_count": 6,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "%%sql\n",
    "DROP TABLE IF EXISTS Item;\n",
    "DROP TABLE IF EXISTS Seller;\n",
    "DROP TABLE IF EXISTS Bid;\n",
    "DROP TABLE IF EXISTS Bidder;\n",
    "\n",
    "CREATE TABLE Item (\n",
    "    ItemID INTEGER PRIMARY KEY,\n",
    "    SellerID INTEGER,\n",
    "    Name TEXT,\n",
    "    Category TEXT,\n",
    "    First_Bid REAL,\n",
    "    Currently REAL,\n",
    "    Number_of_Bids INTEGER,\n",
    "    Buy_Price REAL,\n",
    "    Location TEXT,\n",
    "    Country TEXT,\n",
    "    Started DATETIME,\n",
    "    Ends DATETIME,\n",
    "    Description TEXT,\n",
    "    FOREIGN KEY (SellerID) REFERENCES Seller(UserID)\n",
    "        ON DELETE CASCADE\n",
    ");\n",
    "\n",
    "CREATE TABLE Seller (\n",
    "    UserID INTEGER PRIMARY KEY,\n",
    "    Rating INTEGER\n",
    ");\n",
    "\n",
    "CREATE TABLE Bid (\n",
    "    ItemID INTEGER,\n",
    "    Time DATETIME,\n",
    "    Amount REAL,\n",
    "    BidderID INTEGER,\n",
    "    PRIMARY KEY(ItemID, Amount),\n",
    "    FOREIGN KEY (BidderID) REFERENCES Bidder(UserID)\n",
    "        ON DELETE CASCADE\n",
    ");\n",
    "\n",
    "CREATE TABLE Bidder (\n",
    "    UserID INTEGER PRIMARY KEY,\n",
    "    Rating INTEGER,\n",
    "    Location TEXT,\n",
    "    Country TEXT\n",
    ");\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "447f424e",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " * sqlite://\n",
      "Done.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table>\n",
       "    <thead>\n",
       "        <tr>\n",
       "            <th>sql</th>\n",
       "        </tr>\n",
       "    </thead>\n",
       "    <tbody>\n",
       "        <tr>\n",
       "            <td>CREATE TABLE Item (<br>    ItemID INTEGER PRIMARY KEY,<br>    SellerID INTEGER,<br>    Name TEXT,<br>    Category TEXT,<br>    First_Bid REAL,<br>    Currently REAL,<br>    Number_of_Bids INTEGER,<br>    Buy_Price REAL,<br>    Location TEXT,<br>    Country TEXT,<br>    Started DATETIME,<br>    Ends DATETIME,<br>    Description TEXT,<br>    FOREIGN KEY (SellerID) REFERENCES Seller(UserID)<br>        ON DELETE CASCADE<br>)</td>\n",
       "        </tr>\n",
       "        <tr>\n",
       "            <td>CREATE TABLE Seller (<br>    UserID INTEGER PRIMARY KEY,<br>    Rating INTEGER<br>)</td>\n",
       "        </tr>\n",
       "        <tr>\n",
       "            <td>CREATE TABLE Bid (<br>    ItemID INTEGER,<br>    Time DATETIME,<br>    Amount REAL,<br>    BidderID INTEGER,<br>    PRIMARY KEY(ItemID, Amount),<br>    FOREIGN KEY (BidderID) REFERENCES Bidder(UserID)<br>        ON DELETE CASCADE<br>)</td>\n",
       "        </tr>\n",
       "        <tr>\n",
       "            <td>None</td>\n",
       "        </tr>\n",
       "        <tr>\n",
       "            <td>CREATE TABLE Bidder (<br>    UserID INTEGER PRIMARY KEY,<br>    Rating INTEGER,<br>    Location TEXT,<br>    Country TEXT<br>)</td>\n",
       "        </tr>\n",
       "    </tbody>\n",
       "</table>"
      ],
      "text/plain": [
       "[('CREATE TABLE Item (\\n    ItemID INTEGER PRIMARY KEY,\\n    SellerID INTEGER,\\n    Name TEXT,\\n    Category TEXT,\\n    First_Bid REAL,\\n    Currently R ... (94 characters truncated) ... n    Started DATETIME,\\n    Ends DATETIME,\\n    Description TEXT,\\n    FOREIGN KEY (SellerID) REFERENCES Seller(UserID)\\n        ON DELETE CASCADE\\n)',),\n",
       " ('CREATE TABLE Seller (\\n    UserID INTEGER PRIMARY KEY,\\n    Rating INTEGER\\n)',),\n",
       " ('CREATE TABLE Bid (\\n    ItemID INTEGER,\\n    Time DATETIME,\\n    Amount REAL,\\n    BidderID INTEGER,\\n    PRIMARY KEY(ItemID, Amount),\\n    FOREIGN KEY (BidderID) REFERENCES Bidder(UserID)\\n        ON DELETE CASCADE\\n)',),\n",
       " (None,),\n",
       " ('CREATE TABLE Bidder (\\n    UserID INTEGER PRIMARY KEY,\\n    Rating INTEGER,\\n    Location TEXT,\\n    Country TEXT\\n)',)]"
      ]
     },
     "execution_count": 7,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "%sql SELECT sql FROM sqlite_master ;"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.9.13"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
