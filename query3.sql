SELECT COUNT(*)
FROM Item
WHERE (LENGTH(Category) - LENGTH(REPLACE(Category, '#', '')) + 1) = 4;