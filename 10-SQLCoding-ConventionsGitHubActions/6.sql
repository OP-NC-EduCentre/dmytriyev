-- Code	Line / Position	Description
-- L003	2 / 5	
-- Expected 0 indentations, found 1 [compared to line 01]
-- L036	4 / 1	
-- Select targets should be on a new line unless there is only one select target.
-- L012	4 / 54	
-- Implicit/explicit aliasing of columns.
-- L011	5 / 14	
-- Implicit/explicit aliasing of table.
-- L031	5 / 14	
-- Avoid aliases in from clauses and join conditions.
-- L011	5 / 26	
-- Implicit/explicit aliasing of table.
-- L031	5 / 26	
-- Avoid aliases in from clauses and join conditions.
-- L011	5 / 46	
-- Implicit/explicit aliasing of table.
-- L001	5 / 54	
-- Unnecessary trailing whitespace.
-- PRS	9 / 1	
-- Line 9, Position 1: Found unparsable section: 'WITH READ ONLY'
-- L044	11 / 1	
-- Query produces an unknown number of result columns.


CREATE OR REPLACE VIEW ATTRIBUTE_VIEW
    (OBJ_CODE, ATTR_ID, ATTR_CODE, ATTR_NAME, OBJ_REF)
AS
SELECT O.CODE, A.ATTR_ID, A.CODE, A.NAME, O_REF.CODE O_REF
FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
    (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID, A.ATTR_ID
WITH READ ONLY;

SELECT * FROM ATTRIBUTE_VIEW;