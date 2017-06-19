begin
pshtat.Rising:= true;
update MSHTAT
    set
  	  tarif= decode(tarif_star,
                    1250.28,1583.68)
    where datavivod is null and tarif is not null
    and mipodr_id in (select id from mipodr 
                          start with miuroven_kod=2 and kod in (87)
                          connect by prior id=mipodr_id)
    and miprof_kod in (0402);
  dbms_output.put_line(to_char(SQL%ROWCOUNT));  
  pshtat.Rising:= false;
  commit;
end;