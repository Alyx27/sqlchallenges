--Get the historical cross exchange rate

select 
a.iso_currency as base_currency
, b.iso_currency as quote_currency
, a.exch_date
, round(a.exch_rate_usd / b.exch_rate_usd, 6) as exch_rate
from [ref_v2].[econ_fx_rates_usd] a
left join [ref_v2].[econ_fx_rates_usd] b on a.exch_date = b.exch_date
where a.iso_currency = 'PHP'
and b.iso_currency = 'THB'
order by a.exch_date desc

--Get the latest cross exchange rate

select 
a.iso_currency as base_currency
, b.iso_currency as quote_currency
, a.exch_date
, round(a.exch_rate_usd / b.exch_rate_usd, 6) as exch_rate
from [ref_v2].[econ_fx_rates_usd] a
left join [ref_v2].[econ_fx_rates_usd] b on a.exch_date = b.exch_date
where a.iso_currency = 'PHP'
and b.iso_currency = 'THB'
and a.exch_date in 
	(select max(exch_date) from [ref_v2].[econ_fx_rates_usd])
group by
a.iso_currency
,  b.iso_currency
, a.exch_rate_usd / b.exch_rate_usd
, a.exch_date
