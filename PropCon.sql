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

--Get the % change of the current dividends paid versus the previous dividends distributed

select fsym_id
, currency
, p_divs_exdate
, p_divs_pd as current_div
, lag(p_divs_pd, 1)
	over(order by p_divs_exdate asc) as previous_div
, round(((p_divs_pd - lag(p_divs_pd, 1)
	over(order by p_divs_exdate asc))
		/	lag(p_divs_pd, 1)
			over(order by p_divs_exdate asc) * 100),2) as pct_chg
from fp_v2.fp_basic_dividends
where fsym_id = 'MH33D6-R'
order by p_divs_exdate desc

