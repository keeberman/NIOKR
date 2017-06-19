begin
pshtat.Rising:= true;
update MSHTAT
    set
  	  tarif= decode(tarif_star,
                    1463.47,1902.51,
                    1532.56,1992.33,
                    1589.09,2065.82,
                    1651.90,2147.47,
                    1708.43,2220.96,
                    1790.09,2327.11,
                    1859.18,2416.93)
    where datavivod is null and tarif is not null
    and mipodr_id in (select id from mipodr 
                          start with miuroven_kod=2 and kod in (01,31,37,39,70)
                          connect by prior id=mipodr_id)
    and miprof_kod in (0402);
  dbms_output.put_line(to_char(SQL%ROWCOUNT));  
  pshtat.Rising:= false;
  commit;
end;