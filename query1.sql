SELECT COUNT(DISTINCT UserID) AS TotalDistinctUsers
FROM (
    SELECT UserID FROM Seller
    UNION
    SELECT UserID FROM Bidder
);