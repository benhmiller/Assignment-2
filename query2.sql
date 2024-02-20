SELECT Count(DISTINCT UserID)
FROM (
    SELECT SellerID AS UserID, Location FROM Item
    UNION
    SELECT UserID, Location FROM Bidder
)
WHERE Location = "New York"