declare
percent number:= 4.918;
BEGIN
  --LOCK TABLE MSHTAT IN EXCLUSIVE MODE NOWAIT;
    pshtat.Rising:= true;
    update MSHTAT
    set
      oklad_star= oklad,
      nijgran_star= nijgran,
      verhgran_star= verhgran,
      oklad= round(oklad*(1+percent/100)),
      nijgran= round(nijgran*(1+percent/100)),
      verhgran= round(verhgran*(1+percent/100))
    where razr is null and datavivod is null and oklad is not null
     and mikat_kod<>4
    and mipodr_id in ( select id from mipodr 
                       start with miuroven_kod=2 and kod in (23,49,53,64) connect by prior id=mipodr_id);
  pshtat.Rising:= false;
end;
