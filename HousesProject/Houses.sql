USE PROYECTO1

---standardize Date Format---

select *
from houses


 select SaleDateConverted, CONVERT(date,Saledate)
 from houses

 update houses
 set Saledate=CONVERT(date,Saledate)
 
Alter table houses
add SaleDateConverted Date;

update houses
 set SaleDateConverted=CONVERT(date,Saledate)


 ---Populate Property Addres Data
Select PropertyAddress
from Houses
where PropertyAddress is null

Select a.ParcelID,b.ParcelID,a.PropertyAddress,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)	
from houses a
join houses b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyaddress = isnull(a.PropertyAddress,b.PropertyAddress)
from houses a
join houses b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

---breaking out addres column into individual columns (addres, city, state)
Select PropertyAddress
from Houses

select
SUBSTRING(propertyaddress,1, CHARINDEX(',', Propertyaddress)-1) as address
,SUBSTRING(propertyaddress, CHARINDEX(',', Propertyaddress)+1, LEN(propertyaddress)) as address

from Houses


---createa two tables (city and state)
 alter table houses
 add PropertySplitAddress nvarchar(255)

 update houses
 set PropertySplitAddress = SUBSTRING(propertyaddress,1, CHARINDEX(',', Propertyaddress)-1) 


 alter table houses
 add City nvarchar(255)

 Update Houses
 set city =SUBSTRING(propertyaddress, CHARINDEX(',', Propertyaddress)+1, LEN(propertyaddress))

 Select city,propertysplitaddress
 from Houses

 --- break out OwnerAddress column---
 Select OwnerAddress
 from Houses

Select PARSENAME(REPLACE(owneraddress,',','.'),3),
 PARSENAME(REPLACE(owneraddress,',','.'),2),
 PARSENAME(REPLACE(owneraddress,',','.'),1)
from Houses

Alter table houses 
add state nvarchar(255)

Alter table houses
add ownerSplitaddress nvarchar(255)

update houses
set ownerSplitaddress=PARSENAME(REPLACE(owneraddress,',','.'),3)

alter table houses
add ownerSplitCity nvarchar(255)

update houses 
set ownerSplitCity=PARSENAME(REPLACE(owneraddress,',','.'),2)

alter table houses
add ownerSplitState nvarchar(255)

update Houses
set ownerSplitState=PARSENAME(REPLACE(owneraddress,',','.'),1)

---Change Y and N to YES and NO in "Sold as vacant" Field
 Select distinct(SoldAsVacant), count(soldasvacant)
 from Houses
 group by soldasvacant
 order by 2

 select soldasvacant
 , case when soldasvacant = 'Y' then 'Yes'
		when soldasvacant = 'N'	then 'No'
		else soldasvacant
		end
from Houses

update houses
set SoldAsVacant=case when soldasvacant = 'Y' then 'Yes'
		when soldasvacant = 'N'	then 'No'
		else soldasvacant
		end

---Delete Duplicate Data---
WITH ROWNUMBERCTE as(
select *,
	ROW_NUMBER() OVER (
	partition by ParcelID,
	PropertyAddress,
	SalePrice,
	LegalReference
	ORDER BY 
		uniqueID
		)row_num 
from Houses
)
select* 
from ROWNUMBERCTE
where row_num > 1
order by PropertyAddress



--delete unusual columns
Select *
from Houses

alter table houses
drop column owneraddress,taxdistrict,propertyaddress

alter table houses
drop column saledate

alter table houses
drop column legalreference,state

select *
from Houses

SELECT ownername, COUNT(OwnerName) as Properties
FROM Houses
Group by OwnerName
order by properties desc
GO


