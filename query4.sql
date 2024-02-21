SELECT Item.ItemID
FROM Item
WHERE Item.Currently = 
    (SELECT MAX(Item.Currently) 
     FROM Item);