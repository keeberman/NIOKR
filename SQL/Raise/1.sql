begin
pshtat.Rising:= true;
update MSHTAT
    set
  	  tarif= decode(tarif_star,
                    1306.45,1698.38,
                    1331.57,1731.04,
                    1394.38,1812.70,
                    1438.35,1869.85,
                    1463.47,1902.51,
                    1482.32,1927.01,
                    1507.44,1959.67,
                    1532.56,1992.33,
                    1557.69,2024.99,
                    1626.78,2114.81,
                    1683.31,2188.30,
                    1764.96,2294.45)
    where datavivod is null and tarif is not null
    and mipodr_id not in (select id from mipodr 
                          start with miuroven_kod=2 and kod in (26,87,88,90)
                          connect by prior id=mipodr_id)
    and miprof_kod in (0411,0414,0416,0418);
  dbms_output.put_line(to_char(SQL%ROWCOUNT));  
  pshtat.Rising:= false;
  commit;
end;