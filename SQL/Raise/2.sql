begin
pshtat.Rising:= true;
update MSHTAT
    set
  	  tarif= decode(tarif_star,
                    988.81,1252.49,
                    1007.83,1276.58,
                    1140.94,1445.18,
                    1121.92,1421.10)
    where datavivod is null and tarif is not null
    and mipodr_id in (select id from mipodr 
                          start with miuroven_kod=2 and kod in (26,87,88)
                          connect by prior id=mipodr_id)
    and miprof_kod in (0414);
  dbms_output.put_line(to_char(SQL%ROWCOUNT));  
  pshtat.Rising:= false;
  commit;
end;