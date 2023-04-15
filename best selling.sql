Select *
FROM portfolioproject..[best-selling game consoles]
order by 3,4


select [Console Name], Type, [Released Year], [Discontinuation Year], [Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
order by 1,2

select [Console Name], MAX(cast([Units sold (million)] as int))
FROM portfolioproject..[best-selling game consoles]
where [Console Name] like 'playstation'
Group by [Console Name], Type, [Units sold (million)]
order by 1,2


select [Console Name], Type, [Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
where [Console Name] like 'Xbox'
Group by [Console Name], Type, [Units sold (million)]
order by 1,2

select [Console Name], [Units sold (million)] 
FROM portfolioproject..[best-selling game consoles]
--where [Console Name] like 'playstation'
Group by [Console Name], Type, [Units sold (million)]
order by 1,2


select [Console Name], MAX([Units sold (million)]) 
FROM portfolioproject..[best-selling game consoles]
--where [Console Name] like 'playstation'
Group by [Console Name], [Units sold (million)]
order by 1,2

select [Console Name], Company,[Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
--where [Console Name] like 'playstation'
Group by [Console Name], Company, [Units sold (million)]
order by 1,2

select [Console Name], company, MAX(cast([Units sold (million)] as int)) as [Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
where Company like 'microsoft'
Group by [Console Name], Company, [Units sold (million)]
order by 1,2

select [Console Name], company, MAX(cast([Units sold (million)] as int)) as [Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
where Company like 'nintendo'
Group by [Console Name], Company, [Units sold (million)]
order by 1,2

select [Console Name], company, MAX(cast([Units sold (million)] as int)) as [Units sold (million)]
FROM portfolioproject..[best-selling game consoles]
where Company like 'atari'
Group by [Console Name], Company, [Units sold (million)]
order by 1,2