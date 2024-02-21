SELECT COUNT(DISTINCT Seller.UserID)
FROM Seller, Bidder
WHERE Seller.UserID = Bidder.UserID;