begin
pshtat.Rising:= true;
update MSHTAT
    set
  	  tarif= decode(tarif_star,
                    1570.25,2041.33)
    where datavivod is null and tarif_star is not null
    and mipodr_id in (select id from mipodr 
                          start with miuroven_kod=2 and kod in (37)
                          connect by prior id=mipodr_id)
    and miprof_kod in (0457);
  dbms_output.put_line(to_char(SQL%ROWCOUNT));  
  pshtat.Rising:= false;
  commit;
end;