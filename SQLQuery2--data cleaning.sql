Select *
From portfolioproject.dbo.nationalhousing

Select SaleDateConverted, convert(Date, SaleDate)
From portfolioproject.dbo.nationalhousing

update nationalhousing
SET SaleDate = convert(Date, SaleDate)

ALTER TABLE nationalhousing
Add SaleDateConverted Date;

update nationalhousing
SET SaleDateConverted = Convert(Date, SaleDate)

Select *
From portfolioproject.dbo.nationalhousing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From portfolioproject.dbo.nationalhousing a
JOIN portfolioproject.dbo.nationalhousing b
    on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From portfolioproject.dbo.nationalhousing a
JOIN portfolioproject.dbo.nationalhousing b
    on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


Select PropertyAddress
From portfolioproject.dbo.nationalhousing
--where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1 ) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress)) as Address
From portfolioproject.dbo.nationalhousing


ALTER TABLE nationalhousing
Add propertySplitAddress Nvarchar(255);

update nationalhousing
SET propertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE nationalhousing
Add propertySplitCity Nvarchar(255);

update nationalhousing
SET propertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))


select *
From portfolioproject.dbo.nationalhousing

select OwnerAddress
From portfolioproject.dbo.nationalhousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From portfolioproject.dbo.nationalhousing


ALTER TABLE nationalhousing
Add OwnerSplitAddress Nvarchar(255);

update nationalhousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE nationalhousing
Add OwnerSplitCity Nvarchar(255);

update nationalhousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE nationalhousing
Add OwnerSplitState Nvarchar(255);

update nationalhousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select *
From portfolioproject.dbo.nationalhousing

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From portfolioproject.dbo.nationalhousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE when SoldAsVacant = 'Y' THEN 'Yes'
     when SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
From portfolioproject.dbo.nationalhousing

Update nationalhousing
SET SoldAsVacant = CASE when SoldAsVacant = 'Y' THEN 'Yes'
     when SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END

WITH RowNumCTE AS(
Select *,
    ROW_NUMBER() OVER (
	PARTITION BY parcelID,
	             SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				    UniqueID
					) row_num

From portfolioproject.dbo.nationalhousing
)
select *
From RowNumCTE 
where row_num > 1
Order by PropertyAddress

select *
From portfolioproject.dbo.nationalhousing

ALTER TABLE portfolioproject.dbo.nationalhousing
DROP COLUMN OwnerAddress, PropertyAddress, TaxDistrict

ALTER TABLE portfolioproject.dbo.nationalhousing
DROP COLUMN SaleDate

