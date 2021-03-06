USE [Northwind]
GO
/****** Object:  StoredProcedure [dbo].[ChangeDiscontinued]    Script Date: 21/09/2021 3:56:48 Pm. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangeDiscontinued]
	@Param_ProductID int
AS
	UPDATE Products SET Discontinued = ~Discontinued where ProductID = @Param_ProductID
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 21/09/2021 3:56:48 Pm. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProduct]
	@Param_ProductName nvarchar(40),
	@Param_SuplierID int,
	@Param_CategoryID int,
	@Param_QuantityPerUnit nvarchar(20),
	@Param_UnitPrice money,
	@Param_UnitsInStock smallint,
	@Param_UnitsOnOrder smallint,
	@Param_ReorderLevel smallint

AS
BEGIN
	if not exists (Select ProductName from Products where ProductName = @Param_ProductName)
		BEGIN
			INSERT Into Products (ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES (
				@Param_ProductName,
				@Param_SuplierID,
				@Param_CategoryID,
				@Param_QuantityPerUnit,
				@Param_UnitPrice,
				@Param_UnitsInStock,
				@Param_UnitsOnOrder,
				@Param_ReorderLevel,
				0
	 )
			
		END
	else
		BEGIN
			Print N'Se Encontro un Producto'
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllProductsWhithProductID]    Script Date: 21/09/2021 3:56:48 Pm. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllProductsWhithProductID]
	@Param_ProductID int
AS
	SELECT * FROM Products
		INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID
		INNER JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
	WHERE Discontinued = 0 AND ProductID = @Param_ProductID
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 21/09/2021 3:56:48 Pm. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
	@Param_ProductID int,
	@Param_ProductName nvarchar(40),
	@Param_SuplierID int,
	@Param_CategoryID int,
	@Param_QuantityPerUnit nvarchar(20),
	@Param_UnitPrice money,
	@Param_UnitsInStock smallint,
	@Param_UnitsOnOrder smallint,
	@Param_ReorderLevel smallint

AS
	UPDATE Products SET 
		Productname = @Param_ProductName,
		SupplierID = @Param_SuplierID,
		CategoryID = @Param_CategoryID,
        QuantityPerUnit = @Param_QuantityPerUnit,
        UnitPrice = @Param_UnitPrice,
        UnitsInStock = @Param_UnitsInStock,
        UnitsOnOrder = @Param_UnitsOnOrder,
        ReorderLevel = @Param_ReorderLevel
     WHERE ProductID = @Param_ProductID
GO
