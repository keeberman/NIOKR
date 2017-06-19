select 
initcap(fio) fio ,
to_char(dataoch,'dd.mm.yyyy hh24:mi') data,
nprot,
nvl(pjsk.GetDept2Name(emp.mipodr_id),lefts.mestorab) mestorab,
nvl(nvl(Lower(job.snaim),Lower(lefts.prof)),'Пенсионер') doljn,
main.datapriem,
main.sostav,
initcap(main.adres) adres,
to_char(main.s,'990D99')||' кв.м  ' plos,
flat.snaim mikvart_naim,
to_char(flats.s,'990D99')||' кв.м  '||to_char(flats.sjil,'990D99')||' кв.м' jskplos
from
p.mikvart flat,
p.mjdrug lefts,
p.mirabpens pens,
p.miprof job,
p.mirab emp,
p.mjkvart flats,
p.mjzasjsk colon,
p.mjochered main
where
main.mijsk_id= :JskId
and colon.mjochered_id(+)= main.id
and flats.mjkvart_id(+)= colon.mjkvart_id
and emp.tabn(+)= main.mirab_tabn
and pens.tabn(+)= main.mirabpens_tabn
and lefts.tabn(+)= main.mjdrug_tabn
and emp.miprof_kod= job.kod(+)
and main.mikvart_kod= flat.kod(+)
