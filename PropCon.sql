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

--Get the % change in price for the exdates / Replicate Price Impact column in Workstation

select 
t1.fsym_id
, t1.p_date
, t1.current_price
, t1.previous_price
, round((((t1.current_price - t1.previous_price) / t1.previous_price) * 100),2) as pct_chg
from (select 
		fsym_id
		, p_date
		, p_price as current_price
		, lag(p_price, 1)
		over(order by p_date asc) as previous_price
		from fp_v2.fp_basic_prices
		where fsym_id = 'MH33D6-R') t1
join (select fsym_id
			, p_divs_exdate
		from fp_v2.fp_basic_dividends
		) t2
on t1.fsym_id = t2.fsym_id and t1.p_date = t2.p_divs_exdate
order by p_date desc

-- Could you please confirm that each new report for specific entity will have higher report_id than previous one (i.e. report_id(fiscal period 2022)>report_id(fiscal period 2021)>report_id(fiscal period 2020)...) ?
	
select 
report_id
, factset_entity_id
, previous_report
, period_start_date
, period_end_date
, previous_date
from (
	select *
	, lag(report_id, 1)
		over (order by report_id asc) as previous_report
	, lag(period_end_date, 1)
		over (order by period_end_date asc) as previous_date
	from gr_v2.gr_report 
) as org
where report_id < previous_report
and period_end_date < previous_date
